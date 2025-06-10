class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :toy_post_relations, dependent: :destroy
  has_many :toys, through: :toy_post_relations
  has_many :hashtag_post_relations, dependent: :destroy
  has_many :hashtags, through: :hashtag_post_relations

  has_one_attached :image

  validates :image, presence: true
  validates :title, presence: true, length: { in: 1..30, message: 'は1～30文字以内で入力してください' }
  validates :body, length: { maximum: 200, message: 'は200文字以内で入力してください' }

  after_create :assign_hashtags
  after_update :assign_hashtags

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_toy_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


  def get_image_original(max_width, max_height)
    if image.attached?
      image.variant(resize_to_limit: [max_width, max_height]).processed
    else
      nil
    end
  end

  def self.search_for(content, include_inactive_users: false)
    sanitized = sanitize_sql_like(content)

    scope = Post.joins(:user)
    scope = scope.where(users: { is_active: true }) unless include_inactive_users

    scope.where("title LIKE :keyword OR body LIKE :keyword", keyword: "%#{sanitized}%")
  
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  private

  def assign_hashtags
    hashtags.clear
    return unless body.present?

    tags = body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/).uniq
    tags.each do |tag|
      cleaned = tag.downcase.delete('#')
      hashtags << Hashtag.find_or_create_by(name: cleaned)
    end
  end

end