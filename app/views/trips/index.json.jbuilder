json.array!(@trips) do |trip|
  json.id               trip.id
  json.user_id          trip.user_id
  json.distance         trip.distance
  json.time             trip.time
  json.points           trip.points
  json.created_at       trip.created_at
end
