class User < ActiveRecord::Base
  scope :recent,  -> { order('created_at DESC') }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :recoverable, and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :friendships, foreign_key: "follower_id", dependent: :destroy
  has_many :blocks, foreign_key: "blocker_id", dependent: :destroy
  has_many :followed_users, through: :friendships, source: :followed
  has_many :reverse_blocks, foreign_key: "blocked_id",
                            class_name:  "Block",
                            dependent:   :destroy
  has_many :blocking_users, through: :reverse_blocks, source: :blocker
  
  # this hack allows to save profile without current 
  
  validates :username, format: { with: /\A[A-Za-z0-9\_]+\Z/ }, uniqueness: {case_sensitive: false}, length: { in: 3..10 }

  def update_with_password(params={}) 
    if params[:password].blank? 
      params.delete(:password) 
      params.delete(:password_confirmation) if params[:password_confirmation].blank? 
    end 
    result = update_attributes(params)
    clean_up_passwords
    result
  end

  
  def email_required?
    false
  end

  def email_changed?
    false
  end
    
  def following?(other_user)
    friendships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    friendships.create!(followed_id: other_user.id) unless other_user.blocking?self
  end
  
  def unfollow!(other_user)
    friendships.find_by(followed_id: other_user.id).destroy
  end

  def blocking?(other_user)
    blocks.find_by(blocked_id: other_user.id)
  end

  def block!(other_user)
    other_user.unfollow!(self) if other_user.following?(self)
    blocks.create!(blocked_id: other_user.id)
  end
  
  def unblock!(other_user)
    blocks.find_by(blocked_id: other_user.id).destroy
  end

end
