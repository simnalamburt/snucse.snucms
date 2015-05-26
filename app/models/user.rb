class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :courses
  has_many :sites, through: :courses
  has_many :schedules
  has_many :comments

  def timeline_initial(count = 10)
    timeline_older_than -1, count
  end

  # offset log id의 created_at보다 created_at이작은 로그를 count 갯수만큼 가져온다
  def timeline_older_than(offset = -1, count = 10)
    timeline = Log.includes(:course).where(site: self.sites).order('created_at desc').limit(count)

    if offset > 0 then
      offset_created_at = Log.find_by(id: offset).created_at
      timeline = timeline.where('created_at < ?', offset_created_at).where('id != ?', offset)
    end

    return timeline
  end

  def timeline_since(since)
    since_obj = Log.find_by(id: since)
    return [] if since_obj.nil?
    since_created_at = since_obj.created_at

    timeline = Log.includes(:course).where(site: self.sites).where('created_at > ?', since_created_at).where('id != ?', since).order('created_at desc')

    return timeline
  end
end
