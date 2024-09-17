json.extract! job_offer, :id, :title, :description, :user_id, :created_at, :updated_at
json.url job_offer_url(job_offer, format: :json)
