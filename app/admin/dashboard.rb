ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Last Registered Users' do
          ul do
            User.last(5).map do |user|
              li link_to(user.email, admin_user_path(user))
            end
          end
        end
      end

      column do
        panel 'Info' do
          para 'Welcome to ActiveAdmin.'
        end
      end
    end

    section 'This month' do
      table_for Event.where('datetime > ? and datetime < ?',
                                DateTime.now.to_date, 1.month.from_now) do |t|
        t.column('Subject') { |event| event.subject }
        t.column('Date') { |event| event.datetime.strftime('%B %d, %Y') }
        t.column('Time') { |event| event.datetime.strftime('%H:%M') }
        t.column('Location') { |event| event.location.name }
      end
    end
  end
end
