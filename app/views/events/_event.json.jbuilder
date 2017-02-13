json.extract! event, :id, :name, :description, :code, :award_points, :created_at, :updated_at
json.url event_url(event, format: :json)