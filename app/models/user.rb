class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy


  has_one_attached :profile_image

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9-]+\z/, message: 'は半角英数字、ハイフン(-)のみで入力してください' }, length: { in: 4..15, message: 'は4～15文字で入力してください' }
  validates :nickname, presence: true, length: { maximum: 30, message: 'は30文字以内で入力してください' }
  validates :introduction, length: { maximum: 300, message: 'は300文字以内で入力してください' }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search_for(content)
    sanitized = sanitize_sql_like(content)
   User.where(is_active: true)
       .where("username LIKE :keyword OR nickname LIKE :keyword", keyword: "%#{sanitized}%")
  end

end
