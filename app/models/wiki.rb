class Wiki < ActiveRecord::Base
  belongs_to :user

  default_scope { order('created_at DESC') }
  scope :publicly_viewable, -> { where(private: false) }
  scope :privately_viewable, -> { where(private: true) }
  scope :visible_to, -> (user){ user ? all : publicly_viewable}

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true
end
