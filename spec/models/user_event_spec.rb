require 'spec_helper'

describe UserEvent do
  it { expect(subject).to belong_to(:event) }
  it { expect(subject).to belong_to(:user) }
end
