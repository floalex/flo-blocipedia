class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :collaborate_users, through: :collaborators, source: :user
  after_initialize :default_scope
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true
  default_scope { order('created_at DESC') }
  scope :publicly_viewable, -> { where(private: false) }
  scope :privately_viewable, -> { where(private: true) }
  # Call user before user.role to make sure the value of user exists, so user who not logged in 
  # can still see the public wikis
  scope :visible_to, -> (user) { 
    if user && (user.role == 'admin' || user.role == 'premium') 
     all 
    else
      publicly_viewable
    end 
  }

  def default_scope
    self.private ||= false
  end

  def public
    self.private == false
  end
  
end
