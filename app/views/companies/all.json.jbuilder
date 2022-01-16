json.people(@users) do |user|
  json.company user.company&.name
  json.company_total_users user.company&.users&.count
  json.email user.email
  json.first_name user.first_name
end
