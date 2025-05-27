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

puts "user、post、toyの更新を開始"

#ユーザー
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

shiro = User.find_or_create_by!(email: "shiro@example.com") do |user|
  user.password = "password"
  user.last_name = "白石"
  user.first_name = "しろ"
  user.username = "shiroshiro"
  user.nickname = "しろ"
  user.introduction = "しろいぬのぬいを集めています。"
end

mika = User.find_or_create_by!(email: "mika@example.com") do |user|
  user.password = "password"
  user.last_name = "中村"
  user.first_name = "美香"
  user.username = "mika-nkm"
  user.nickname = "みか"
  user.introduction = "ぬいとのおでかけが好き。"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.jpg"), filename:"sample-user5.jpg")
end

ken = User.find_or_create_by!(email: "ken@example.com") do |user|
  user.password = "password"
  user.last_name = "井上"
  user.first_name = "健"
  user.username = "ken-inoue"
  user.nickname = "ケン"
  user.introduction = "ぬいと旅をしています。"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user6.jpg"), filename:"sample-user6.jpg")
end

aya = User.find_or_create_by!(email: "aya@example.com") do |user|
  user.password = "password"
  user.last_name = "青木"
  user.first_name = "彩"
  user.username = "ayaaa123"
  user.nickname = "あや"
  user.introduction = "日常に癒しを。ぬい活記録中。"
end

#投稿
Post.find_or_create_by!(id: 1) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.title = "家族が増えました"
  post.body = "家族の一員が増えて嬉しいです！！"
  post.user = taro
end

Post.find_or_create_by!(id: 2) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.title = "仲間が増えました"
  post.body = "ヘビくんが仲間入りしました"
  post.user = jiro
end

Post.find_or_create_by!(id: 3) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.title = "ぬいの行進"
  post.body = "ぬいが行進しています"
  post.user = hanako
end

Post.find_or_create_by!(id: 4) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")
  post.title = "お昼寝タイム"
  post.body = "お気に入りのぬいと昼寝中。"
  post.user = shiro
end

Post.find_or_create_by!(id: 5) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.jpg"), filename:"sample-post5.jpg")
  post.title = "うさぎちゃんたちといっしょ"
  post.body = "あやさんのおうちのうさぎちゃんたちと撮影しました！\n仲良しです！"
  post.user = mika
end

Post.find_or_create_by!(id: 6) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"), filename:"sample-post6.jpg")
  post.title = "ぬい旅日記"
  post.body = "カフェで休憩中！"
  post.user = ken
end

Post.find_or_create_by!(id: 7) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post7.jpg"), filename:"sample-post7.jpg")
  post.title = "おやつタイム"
  post.body = "ぬいとおやつの時間です"
  post.user = aya
end

Post.find_or_create_by!(id: 8) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post8.jpg"), filename:"sample-post8.jpg")
  post.title = "森の中で"
  post.body = "ぬいと森を探検しました"
  post.user = taro
end

Post.find_or_create_by!(id: 9) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post9.jpg"), filename:"sample-post9.jpg")
  post.title = "仲良く"
  post.body = "いつも仲良しです"
  post.user = hanako
end

Post.find_or_create_by!(id: 10) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post10.jpg"), filename:"sample-post10.jpg")
  post.title = "おでかけ前の1枚"
  post.body = "今日はどこ行こうかな？"
  post.user = mika
end

Post.find_or_create_by!(id: 11) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post11.jpg"), filename:"sample-post11.jpg")
  post.title = "春の訪れ"
  post.body = "桜とぬいぐるみのツーショット"
  post.user = shiro
end

Post.find_or_create_by!(id: 12) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post12.jpg"), filename:"sample-post12.jpg")
  post.title = "おしゃれコーデ"
  post.body = "今日はおしゃれしてみたよ"
  post.user = aya
end

Post.find_or_create_by!(id: 13) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post13.jpg"), filename:"sample-post13.jpg")
  post.title = "のんびり休日"
  post.body = "たまには家で過ごすのもいいですね"
  post.user = ken
end

Post.find_or_create_by!(id: 14) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post14.jpg"), filename:"sample-post14.jpg")
  post.title = "森でひとやすみ"
  post.user = jiro
end

Post.find_or_create_by!(id: 15) do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post15.jpg"), filename:"sample-post15.jpg")
  post.title = "ピクニック日和"
  post.body = "天気が良いのでぬいと一緒にピクニックしました！\nとても楽しいです！"
  post.user = mika
end

#ぬいぐるみ

Toy.find_or_create_by!(id: 1) do |toy|
  toy.toy_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-toy1.jpg"), filename:"sample-toy1.jpg")
  toy.name = "テディ"
  toy.introduction = "可愛いくまちゃんです。"
  toy.user = taro
end

Toy.find_or_create_by!(id: 2) do |toy|
  toy.toy_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-toy2.jpg"), filename:"sample-toy2.jpg")
  toy.name = "ワンちゃん"
  toy.introduction = "小さい頃から一緒です。"
  toy.user = taro
end

Toy.find_or_create_by!(id: 3) do |toy|
  toy.toy_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-toy3.jpg"), filename:"sample-toy3.jpg")
  toy.name = "うさぎくん"
  toy.introduction = "遊ぶのが大好きです。\n足が早いです。"
  toy.user = jiro
end

Toy.find_or_create_by!(id: 4) do |toy|
  toy.toy_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-toy4.jpg"), filename:"sample-toy4.jpg")
  toy.name = "ぶたくん"
  toy.introduction = "マイペースです。\n食いしん坊です。"
  toy.user = jiro
end

Toy.find_or_create_by!(id: 5) do |toy|
  toy.toy_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-toy5.jpg"), filename:"sample-toy5.jpg")
  toy.name = "へびくん"
  toy.introduction = "新入りです。\nこれからよろしくね。"
  toy.user = jiro
end

Toy.find_or_create_by!(id: 6) do |toy|
  toy.toy_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-toy6.jpg"), filename:"sample-toy6.jpg")
  toy.name = "うまさん"
  toy.introduction = "足の速さは誰にも負けません！"
  toy.user = hanako
end

Toy.find_or_create_by!(id: 7) do |toy|
  toy.toy_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-toy7.jpg"), filename:"sample-toy7.jpg")
  toy.name = "いぬさん"
  toy.introduction = "とてもマイペースな女の子です。"
  toy.user = hanako
end

Toy.find_or_create_by!(id: 8) do |toy|
  toy.toy_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-toy8.jpg"), filename:"sample-toy8.jpg")
  toy.name = "しろくまちゃん"
  toy.introduction = "いつも一緒に寝ている、大切な家族です。"
  toy.user = shiro
end

Toy.find_or_create_by!(id: 9) do |toy|
  toy.toy_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-toy9.jpg"), filename:"sample-toy9.jpg")
  toy.name = "めーちゃん"
  toy.introduction = "ふわふわでもこもこな可愛いひつじさんです！"
  toy.user = shiro
end

Toy.find_or_create_by!(id: 10) do |toy|
  toy.toy_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-toy10.jpg"), filename:"sample-toy10.jpg")
  toy.name = "ピーナッツ"
  toy.introduction = "色がお気に入りです。"
  toy.user = mika
end

Toy.find_or_create_by!(id: 11) do |toy|
  toy.toy_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-toy11.jpg"), filename:"sample-toy11.jpg")
  toy.name = "水色うさぎちゃん"
  toy.introduction = "ちょっぴりクールなところがあります"
  toy.user = aya
end

Toy.find_or_create_by!(id: 12) do |toy|
  toy.toy_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-toy12.jpg"), filename:"sample-toy12.jpg")
  toy.name = "ピンクうさぎちゃん"
  toy.introduction = "とてもキュート！！"
  toy.user = aya
end

puts "user、post、toyの更新完了"

puts "relationshipsの更新を開始"

#フォロー・フォロワー関係
relationships = {
  1 => [2, 3, 4, 6],
  2 => [1, 3, 4, 7],
  3 => [2, 3, 5],
  5 => [1, 3, 4, 7],
  6 => [2, 4],
  7 => [2, 3, 5, 6]
}

relationships.each do |follower_id, followed_ids|
  followed_ids.each do |followed_id|
    Relationship.find_or_create_by!(follower_id: follower_id, followed_id: followed_id)
  end
end

puts "relationshipsの更新を終了"

puts "favoritesの更新を開始"

favorites = {
  1 => [2, 3, 5],
  2 => [1, 4, 6],
  3 => [2, 7],
  4 => [1, 3],
  5 => [6, 10],
  6 => [1, 12, 14],
  7 => [5, 9]
}

favorites.each do |user_id, post_ids|
  post_ids.each do |post_id|
    Favorite.find_or_create_by!(user_id: user_id, post_id: post_id)
  end
end

puts "favoritesの更新完了"

puts "toy_post_relationsの更新を開始"
post_toy_relations = {
  1 => [1],  
  2 => [3, 4, 5, 6],
  3 => [4, 6, 7],
  4 => [8],
  5 => [10, 11, 12],
  8 => [2],
  11 => [9]
}

post_toy_relations.each do |post_id, toy_ids|
  toy_ids.each do |toy_id|
    ToyPostRelation.find_or_create_by!(post_id: post_id, toy_id: toy_id)
  end
end

puts "toy_post_relationsの更新完了"

puts "commentsの作成を開始"

users = User.all
posts = Post.all

sample_comments = [
  "かわいいですね！",
  "とても癒されました。",
  "ぬいぐるみが素敵です！",
  "写真の雰囲気が好きです。",
  "お気に入りの一枚です！",
  "ほっこりしました。",
  "今度マネしてみたいです。",
  "いいね！をたくさん送りたいです！",
  "癒しの時間ですね。",
  "構図が最高です。"
]

users.each do |user|
  # 自分以外の投稿をランダムに1件取得
  post = posts.where.not(user_id: user.id).sample
  next unless post # 念のため nil チェック

  content = sample_comments.sample
  Comment.find_or_create_by!(user: user, post: post, comment: content)
end

puts "commentsの作成を完了"

puts "seedの実行が完了しました"