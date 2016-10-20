json.id                 redemption.id
json.business_id        redemption.business.id
json.business_name      redemption.business.name
json.business_logo      (redemption.business.logo? ? redemption.business.logo.default : nil)
json.reward_id          redemption.reward_id
json.reward_title       redemption.reward.title
json.reward_description redemption.reward.description
json.reward_cost        redemption.reward.cost
json.created_at         redemption.reward.created_at