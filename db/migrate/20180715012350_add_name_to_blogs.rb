class AddNameToBlogs < ActiveRecord::Migration[5.1]
   def change
    add_reference :blogs, :user, index: true
   end
end
