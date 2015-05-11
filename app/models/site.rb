
class Site < ActiveRecord::Base
  CRAWLING_TYPES = %w(googlesite xe gnuboard phpbb custom)

  belongs_to :course
  # http://stackoverflow.com/questions/4434451/rails-equivalent-to-djangos-choices
  validates_inclusion_of :crawling_type, in: CRAWLING_TYPES,
    message: "%{value} is not in valid crawling type. It must in #{CRAWLING_TYPES}"
  validates :name, presence: true
  validates :url, presence: true
  validates :course_id, presence: true

  def init
    self.crawling_type ||= 'custom'
  end
end
