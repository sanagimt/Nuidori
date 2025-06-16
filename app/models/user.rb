class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :toys, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, -> { where(is_active: true) }, through: :active_relationships, source: :followed
  has_many :followers, -> { where(is_active: true) }, through: :passive_relationships, source: :follower

  has_one_attached :profile_image

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: { message: "は既に使用されています" }, format: { with: /\A[a-zA-Z0-9-]+\z/, message: 'は半角英数字、ハイフン(-)のみで入力してください' }, length: { in: 4..15, message: 'は4～15文字で入力してください' }
  validates :nickname, presence: true, length: { maximum: 30, message: 'は30文字以内で入力してください' }
  validates :introduction, length: { maximum: 300, message: 'は300文字以内で入力してください' }
  validates :is_active, inclusion: { in: [true, false] }

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.last_name = "ゲスト"
      user.first_name = "さん"
      user.username = "guest"
      user.nickname = "ゲストさん"
    end
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_profile_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search_for(content, include_inactive: false)
    sanitized = sanitize_sql_like(content)

    scope = User.all
    scope = scope.where(is_active: true) unless include_inactive
  
    scope.where("username LIKE :keyword OR nickname LIKE :keyword", keyword: "%#{sanitized}%")
  end

  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
  
  def mutual_followings
    followings & followers
  end

end
