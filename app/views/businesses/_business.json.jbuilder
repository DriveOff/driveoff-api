json.id               business.id
json.user_id          business.user_id
json.name             business.name
json.logo             (business.logo? ? business.avatar.default : nil)
json.created_at       business.created_at
