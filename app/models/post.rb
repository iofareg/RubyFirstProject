class Post < ApplicationRecord
    belongs_to :author, class_name: 'User'
    has_many :comments, :dependent => :destroy
    validates :title, presence: true, length: {minimum: 5}
    has_one_attached :image
    scope :ordered, ->(direction = :desc) {
        order(created_at: direction)
    }
    scope :with_authors, -> {includes(:author)}

    scope :search, ->(query) do 
        return if query.blank?
        where('title LIKE ?', "%#{query.squish}%")
    end
end
