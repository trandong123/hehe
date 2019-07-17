class CommentFood < ApplicationRecord
  belongs_to :user
  belongs_to :food

  validates :content, presence: true
end
