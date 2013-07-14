json.array!(@users) do |user|
  json.extract! user, :username, :password, :email, :follow_id, :follower_id, :avatar, :favorite_id
  json.url user_url(user, format: :json)
end
