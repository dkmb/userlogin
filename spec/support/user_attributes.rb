def user_attributes(overrides = {})
  {
    username: "Timuser",
    password: "4321",
    email: "tim@user.com"
  }.merge(overrides)
end