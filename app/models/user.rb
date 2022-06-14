class User < ApplicationRecord
  before_create :generate_nickname

  scope :online, -> { where('connection_counter > 0') }

  def generate_nickname
    self.nickname = Faker::Name.first_name.downcase
  end
end
