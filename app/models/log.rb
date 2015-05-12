class Log < ActiveRecord::Base
  belongs_to :site
  has_one :course, through: :site
end
