class Hashtag < ApplicationRecord
  has_many :hashtag_post_relations, dependent: :destroy
  has_many :posts, through: :hashtag_post_relations
end