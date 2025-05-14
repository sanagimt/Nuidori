# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: "a@a",
  password: "aaaaaa"
)

taro = User.find_or_create_by!(email: "taro@example.com") do |user|
  user.password = "password"
  user.last_name = "佐藤"
  user.first_name = "太郎"
  user.username = "taro-st"
  user.nickname = "太郎"
  user.introduction = "よろしくお願いします。"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

