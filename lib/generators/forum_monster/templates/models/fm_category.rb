class FmCategory < ActiveRecord::Base
  
  # Associations
  has_many :fm_forums, :dependent => :destroy
  
  # Accessors
  attr_accessible :title, :state, :position, :fm_category_id
  
  # Scopes
  default_scope :order => 'position ASC'
  
  # Validations
  validates :title,       :presence => true
end