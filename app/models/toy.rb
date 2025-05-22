class Toy < ApplicationRecord
  belongs_to :user

  has_many :toy_post_relations, dependent: :destroy
  has_many :posts, through: :toy_post_relations

  has_one_attached :toy_image

  validates :name, presence: true,  length: { maximum: 30, message: 'は30文字以内で入力してください' }
  validates :introduction, length: { maximum: 300, message: 'は300文字以内で入力してください' }


  def get_toy_image(width, height)
    unless toy_image.attached?
      file_path = Rails.root.join('app/assets/images/no_toy_image.jpg')
      toy_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    toy_image.variant(resize_to_limit: [width, height]).processed
  end


  
end
