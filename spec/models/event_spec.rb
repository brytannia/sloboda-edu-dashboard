require 'spec_helper'

describe Event do
  it { expect(subject).to validate_presence_of :subject }

  it { expect(subject).to have_many(:user_events) }
  it { expect(subject).to have_many(:users).through(:user_events) }
  it { expect(subject).to belong_to(:location) }
end
