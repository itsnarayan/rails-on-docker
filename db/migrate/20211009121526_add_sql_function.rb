class AddSqlFunction < ActiveRecord::Migration[6.1]
  def change
    execute <<-SQL
      CREATE OR REPLACE FUNCTION PolicyTermAccepted (uni_id VARCHAR(255), acc_bit SMALLINT) RETURNS void AS
      $$
      BEGIN
         IF CAST(acc_bit as boolean) THEN
            UPDATE
               policy_terms
            SET
               accepted = CURRENT_TIMESTAMP
            WHERE
               uniqueid = uni_id;
         END IF;
      END;
      $$ LANGUAGE plpgsql VOLATILE;
      -- just in case create different function for unknown
      -- otherwise everytime we need cast before call it
      CREATE OR REPLACE FUNCTION PolicyTermAccepted (uid VARCHAR(255), acc_bit INT) RETURNS void AS
      $$
      -- DECLARE
         -- uid VARCHAR(255);
      BEGIN
         IF CAST(acc_bit as boolean) THEN
            -- uid = CAST($1 AS VARCHAR);
            UPDATE
               policy_terms
            SET
               accepted = CURRENT_TIMESTAMP
            WHERE
               uniqueid = uid;
         END IF;
      END;
      $$ LANGUAGE plpgsql VOLATILE;
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION PolicyTermAccepted;
    SQL
  end
end
