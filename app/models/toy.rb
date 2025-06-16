class Toy < ApplicationRecord
  belongs_to :user

  has_many :toy_post_relations, dependent: :destroy
  has_many :posts, through: :toy_post_relations

  has_one_attached :toy_image

  validates :name, presence: true,  length: { maximum: 30, message: 'は30文字以内で入力してください' }
  validates :introduction, length: { maximum: 300, message: 'は300文字以内で入力してください' }


  def get_toy_image(width, height)
    if toy_image.attached?
      toy_image.variant(resize_to_limit: [width, height]).processed
    else
      ActionController::Base.helpers.asset_path("no_toy_image.jpg")
    end
  end

  def display_name_with_owner
    "#{name}（by #{user.nickname}(#{user.username}))"
  end

end
