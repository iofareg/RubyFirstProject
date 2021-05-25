class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :rememberable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable
  has_many :posts, foreign_key: :author_id, :dependent => :destroy
  has_many :comments, foreign_key: :author_id, :dependent => :destroy
end
