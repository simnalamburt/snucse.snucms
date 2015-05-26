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
end
