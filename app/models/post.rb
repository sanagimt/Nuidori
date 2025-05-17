class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_one_attached :image

  validates :image, presence: true
  validates :title, presence: true, length: { in: 1..30, message: 'は1～30文字以内で入力してください' }
  validates :body, length: { maximum: 200 }

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


  def get_image_original(max_width = 1000, max_height = 1000)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [max_width, max_height]).processed
  end

  def self.search_for(content)
    sanitized = sanitize_sql_like(content)
    Post.joins(:user)
        .where(users: { is_active: true })
        .where("title LIKE :keyword OR body LIKE :keyword", keyword: "%#{sanitized}%")
  end

end