class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :collaborate_wikis, through: :collaborators, source: :wiki
  has_one :subscription, dependent: :destroy

  after_initialize :default_role

  def self.search(query)
     where("email like ?", "%#{query}%")
  end

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def standard?
    role == 'standard'
  end

  def default_role
    self.role ||= "standard"
  end

  
end