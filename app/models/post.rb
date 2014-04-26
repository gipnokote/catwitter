class Post < ActiveRecord::Base
  belongs_to :user
  
  scope :recent,  -> { order('created_at DESC') }
  
  validates :title, length: { in: 1..64 }
  validates :body, length: { in: 1..256 }
  
  acts_as_commentable
  
  def self.from_users_followed_by(user)
    blocking_user_ids = user.blocking_user_ids
    followed_user_ids = user.followed_user_ids
    followed_user_ids = followed_user_ids - blocking_user_ids
    where("user_id IN (?)", followed_user_ids)
  end

end
