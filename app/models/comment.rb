class Comment < ApplicationRecord
validates :comment, presence: true

belongs_to :user, dependent: :destroy
belongs_to :prototype

end
