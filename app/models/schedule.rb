class Schedule < ActiveRecord::Base
  enum schedule_type: [ :assignment, :quiz, :exam, :project, :extra]

  belongs_to :course
  belongs_to :user
  has_many :comments
  validates :schedule_type, presence: true
  validates :name, presence: true
  validates :course, presence: true
  validates :user, presence: true
  validates :due_date, presence: true
  validates :content, presence: true

  def self.of_month(user, month=nil)
    if month.nil?
      month = Date.today.month
    end
    month = month.to_i
    query = self.includes(:course).where('strftime("%m", due_date) + 0 = ?', month)
    result = Hash.new
    query.each do |q|
      if not user.courses.include? q.course then
        next
      end

      date_str = q.due_date.strftime('%Y-%m-%d')
      if result[date_str].nil? then
        result[date_str] = [q]
      else
        result[date_str] << q
      end
    end
    return result
  end
end
