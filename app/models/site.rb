class Site < ActiveRecord::Base
  enum crawling_type: [ :undefined, :google_site_recent_changes ]

  belongs_to :course
  has_many :logs
  validates :name, presence: true
  validates :url, presence: true
  validates :course_id, presence: true
  validates :crawling_type, presence: true

  def data
    Marshal.load Zlib::Inflate.inflate Base64.decode64 self[:data]
  end

  def data=(value)
    raw = Zlib::Deflate.deflate Marshal.dump value
    self[:data] = Base64.strict_encode64 raw
    self[:data_hash] = Digest::SHA1.base64digest raw
  end

  def data_hash
    Base64.decode64 self[:data_hash]
  end

  def data_hash=(value)
    self[:data_hash] = Base64.strict_encode64 value
  end
end
