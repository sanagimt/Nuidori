class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :comment, presence: { message: 'を入力してください' }, length: { in: 1..100, message: 'は1～100文字以内で入力してください' }
  
end
