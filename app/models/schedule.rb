class Schedule < ActiveRecord::Base
  enum schedule_type: [ :assignment, :quiz, :exam, :project, :extra]

  belongs_to :course
  belongs_to :user
  validates :schedule_type: presence: true
  validates :name, presence: true
  validates :course_id, presence: true
  validates :user_id, presence: true
  validates :created_at, presence: true
  validates :due_date, presence: true
  validates :content, presence: true
end
