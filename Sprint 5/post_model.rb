class Post < ActiveRecord::Base
   has_and_belongs_to_many :hashtags, join_table:"posts_hashtags"
   validates :content, presence: true,
                       length: { maximum: 256 }
end
