namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 sex: "male",
                 password: "foobar22",
                 password_confirmation: "foobar22",
                 admin: true)
    50.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      sex = "male"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   sex: sex,
                   password: password,
                   password_confirmation: password)
    end
  end
end