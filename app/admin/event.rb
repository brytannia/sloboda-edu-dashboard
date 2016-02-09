ActiveAdmin.register Event do
	permit_params :datetime, :subject, :confirmed, :location_id
end
