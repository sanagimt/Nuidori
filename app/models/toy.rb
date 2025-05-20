class Toy < ApplicationRecord
  belongs_to :user

  has_many :toy_post_relations, dependent: :destroy
  
end
