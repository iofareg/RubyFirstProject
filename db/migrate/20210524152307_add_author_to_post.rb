class AddAuthorToPost < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :author, foreign_key: true
  end
end
