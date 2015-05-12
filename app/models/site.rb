class Site < ActiveRecord::Base
  enum crawling_type: [ :undefined, :google_site_recent_changes ]

  belongs_to :course
  has_many :logs
  validates :name, presence: true
  validates :url, presence: true
  validates :course_id, presence: true
  validates :crawling_type, presence: true
end
