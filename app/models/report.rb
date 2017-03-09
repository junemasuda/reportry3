class Report < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true
  validates :artist, presence: true
  validates :content, presence: true
end
