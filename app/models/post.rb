class Post < ApplicationRecord
    belongs_to :author, class_name: 'User'
    has_many :comments, :dependent => :destroy
    validates :title, presence: true, length: {minimum: 5}

    scope :ordered, ->(direction = :desc) {
        order(created_at: direction)
    }
    scope :with_authors, -> {includes(:author)}
end
