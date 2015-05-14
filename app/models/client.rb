class Client < ActiveRecord::Base
  devise :database_authenticatable, :recoverable#, :validatable

  after_create :update_access_token!  

  validates :username, presence: true
  validates :email, presence: true

  private

  def update_access_token!
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end

  def generate_access_token
    loop do
      token = "#{self.id}:#{Devise.friendly_token}"
      break token unless Client.where(access_token: token).first
    end
  end

end
