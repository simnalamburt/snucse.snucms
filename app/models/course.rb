class Course < ActiveRecord::Base
  has_and_belongs_to_many :user
  has_many :sites
end
