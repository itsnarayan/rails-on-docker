class PolicyTerms < ApplicationRecord
  def self.agree_policy(email)
    ActiveRecord::Base.connection.execute("SELECT \"policytermaccepted\"('#{email}', 1);")
  end
end
