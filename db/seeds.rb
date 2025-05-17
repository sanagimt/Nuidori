# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedの実行を開始"

admin = Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
end

taro = User.find_or_create_by!(email: "taro@example.com") do |user|
  user.password = "password"
  user.last_name = "佐藤"
  user.first_name = "太郎"
  user.username = "taro-st"
  user.nickname = "太郎"
  user.introduction = "よろしくお願いします。"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

jiro = User.find_or_create_by!(email: "jiro@example.com") do |user|
  user.password = "password"
  user.last_name = "田中"
  user.first_name = "次郎"
  user.username = "jirotnk"
  user.nickname = "JIRO"
  user.introduction = "初めまして。\nよろしくお願いします。"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

hanako = User.find_or_create_by!(email: "hanako@example.com") do |user|
  user.password = "password"
  user.last_name = "高橋"
  user.first_name = "花子"
  user.username = "hanahana87"
  user.nickname = "はな"
  user.introduction = "ぬいぐるみを撮るのが大好きです。\n仲良くしてください！"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

Post.find_or_create_by!(id: "1") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.title = "4人で撮影"
  post.body = "4人で撮影しました"
  post.user = taro
end

Post.find_or_create_by!(id: "2") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.title = "仲間が増えました"
  post.body = "ヘビくんが仲間入りしました"
  post.user = jiro
end

Post.find_or_create_by!(id: "3") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.title = "ぬいの行進"
  post.body = "ぬいが行進しています"
  post.user = hanako
end


puts "seedの実行が完了しました"