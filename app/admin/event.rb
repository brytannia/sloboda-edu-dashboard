ActiveAdmin.register Event do
	permit_params :subject, :datetime, :confirmed, :location_id
  index do
    selectable_column
    column :subject
    column :datetime
    column :confirmed
    column :location
    column :created_at
    actions
  end
  form do |f|
    f.inputs "Event" do
      f.input :subject
      f.input :datetime, as: :datetime_picker
      f.input :location
      f.input :confirmed
    end
    f.actions
  end

  filter :confirmed, as: :check_boxes

  scope :all, :default => true
  scope :today do |events|
    events.where('? < datetime and datetime < ?', DateTime.now.to_date - 1.days, DateTime.now.to_date + 1.days + 1)
  end
  scope :this_week do |events|
    events.where('datetime > ? and datetime < ?', DateTime.now.to_date, 1.week.from_now)
  end
  scope :past do |events|
    events.where('datetime < ?', DateTime.now.to_date)
  end
end
