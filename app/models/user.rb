class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :courses
  has_many :sites, through: :courses

  def timeline_initial(count = 10)
    timeline_older_than -1, count
  end

  # offset log id보다 작은 로그를 count 갯수만큼 가져온다
  def timeline_older_than(offset = -1, count = 10)
    timeline = Log.includes(:course).where(site: self.sites).order('id desc').limit(count)

    if offset > 0 then
      timeline = timeline.where('id < ?', offset)
    end

    return timeline
  end

  def timeline_since(since)
    timeline = Log.includes(:course).where(site: self.sites).where('id > ?', since).order('id desc')

    return timeline
  end
end
