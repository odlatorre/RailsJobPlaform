class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image, dependent: :destroy
  has_many :job_offers
  has_many :applications
  def admin?
    role = "admin"
  end
end
