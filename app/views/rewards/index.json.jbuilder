json.array!(@rewards) do |reward|
  json.id               reward.id
  json.business_id      reward.business_id
  json.business_name    reward.business.name
  json.business_logo    (reward.business.logo? ? reward.business.logo.default : nil)
  json.title            reward.title
  json.description      reward.description
  json.cost             reward.cost
  json.created_at       reward.created_at
end
