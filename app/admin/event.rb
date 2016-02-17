ActiveAdmin.register Event do
  permit_params :subject, :datetime, :confirmed, :location_id,
                :user_events, :users
  before_filter :set_users, only: [:update]

  before_filter :send_email, only: [:create, :update]

  controller do
    def set_users
      @event = Event.find(params[:id])
      @event.users = []
      params[:event][:user_ids].each do |id|
        @event.users << User.find(id) unless id == ''
      end
    end

    def send_email
      event = Event.find(params[:id])
      # binding.pry
      # event_time = (event.datetime.to_time - 5.seconds).to_datetime
      UserMailer.delay(run_at: 2.seconds.from_now).notification_email(current_user, event)
    end
  end

  index do
    selectable_column
    column :id
    column :subject
    column :datetime
    column :confirmed
    column :location
    column :created_at

    column :speakers do |event|
      table_for event.users.each do
        column do |user|
          link_to user.email, [:admin, user]
        end
      end
    end
    actions
  end

  show do
    attributes_table do
      row :subject
      row :location
      table_for event.users.each do
        column do |user|
          link_to user.email, [:admin, user]
        end
      end
    end
  end

  form do |f|
    f.inputs 'Event' do
      f.semantic_errors(*f.object.errors.keys)
      f.input :subject
      f.input :datetime, as: :datetime_picker
      f.input :location
      f.input :confirmed

      f.input :users,
              collection: User.all.map { |user| [user.email, user.id] },
              as: :select, multiple: true
    end
    f.actions
  end

  filter :confirmed, as: :check_boxes

  scope :all, default: true
  scope :today do |events|
    events.where(datetime: DateTime.now.beginning_of_day..
                 DateTime.now.end_of_day)
  end
  scope :this_week do |events|
    events.where(datetime: DateTime.now.beginning_of_day...1.week.from_now)
  end
  scope :past do |events|
    events.where('datetime < ?', DateTime.now)
  end
end
