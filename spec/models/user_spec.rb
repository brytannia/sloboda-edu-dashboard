# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string           not null
#  last_name              :string           not null
#  speaker                :boolean
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

require 'spec_helper'

describe User do
  %i(first_name last_name email password password_confirmation).each do |f|
    it { expect(subject).to validate_presence_of f }
  end

  it { expect(subject).to have_many(:events).through(:user_events) }

  subject { FactoryGirl.build(:user) }
  it { expect(subject).to validate_uniqueness_of(:email).case_insensitive }

  describe '#admin?' do
    subject { user.admin? }
    context 'with admin' do
      let(:user) { build_stubbed :user, :admin }
      it { expect(subject).to be true }
    end
    context 'without admin' do
      let(:user) { build_stubbed :user, :reader }
      it { expect(subject).to be false }
    end
  end
end
