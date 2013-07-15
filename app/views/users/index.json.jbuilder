json.array!(@users) do |user|
  json.extract! user, :username, :name, :password_digest, :email, :avatar_url
  json.url user_url(user, format: :json)
end
