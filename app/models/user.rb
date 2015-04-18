class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :wikis, dependent: :destroy

  after_initialize do |user|
    user.role == 'standard'
  end
  

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

end