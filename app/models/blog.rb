class Blog < ApplicationRecord
    validates :title,:content, presence: true
    validates :content, length:  { in: 1..140 }
end
