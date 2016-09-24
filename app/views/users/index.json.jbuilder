json.array!(@users) do |user|
  json.id               user.id
  json.email            user.email
  json.name             user.name
  json.created_at       user.created_at
  json.role             user.role
  json.avatar           user.avatar
  json.city             user.city
  json.state            user.state
  json.zip_code         user.zip_code
  json.birthday         user.birthday
  json.age              user.age
  json.gender           user.gender
  json.custom_gender    user.custom_gender
  json.pronouns         user.pronouns
end
