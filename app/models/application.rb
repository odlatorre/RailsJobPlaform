class Application < ApplicationRecord
  belongs_to :job_offer
  belongs_to :user

  validates :user_id, uniqueness: { scope: :job_offer_id, message: 'has already applied to this job offer' }
end
