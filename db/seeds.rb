User.create!(name:  "Amy Bo Bamy",
             email: "zanizm@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

12.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end