class Album < ActiveRecord::Base
  belongs_to :user
  has_many :images

  validates_presence_of :title
  before_create :create_secret
  def self.create_archive_path
    "#{Rails.root}/public/album_archives/#{SecureRandom.hex(10)}"
  end
  
  protected
  def create_secret
    self.secret =  SecureRandom.hex(10)
  end
end
