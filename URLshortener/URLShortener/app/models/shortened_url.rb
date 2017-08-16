class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  # attr_accessor :short_url, :long_url, :user_id

  def self.random_code
    return_string = SecureRandom::urlsafe_base64
    while exists?(:short_url => return_string)
      return_string = SecureRandom::urlsafe_base64
    end
    return_string
  end

  def self.create_with_user(user, long_url)
    ShortenedUrl.create!(short_url: ShortenedUrl.random_code, long_url: long_url, user_id: user.id)
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

end
