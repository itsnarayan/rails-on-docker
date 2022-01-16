class AddSqlView < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW policy_terms (
        uniqueid,
        mustaccept,
        accepted
      ) AS
      SELECT
        email,
        CASE WHEN agreement_required AND confirmed_at IS NULL THEN 1 END,
        confirmed_at
      FROM users;
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW policy_terms;
    SQL
  end
end
