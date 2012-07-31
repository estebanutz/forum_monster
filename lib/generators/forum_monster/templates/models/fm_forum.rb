class FmForum < ActiveRecord::Base
  
  # Associations
  has_many :fm_topics, :dependent => :destroy
  has_many :fm_posts, :through => :topics
  
  belongs_to :fm_category
  
  # Accessors
  attr_accessible :title, :description, :state, :position, :fm_category_id
  
  # Scopes
  default_scope :order => 'position ASC'
  
  # Validations
  validates :title,       :presence => true
  validates :description, :presence => true
  validates :fm_category_id, :presence => true
end