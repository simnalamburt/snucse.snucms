class Comment < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :user
  validates :schedule_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
end
