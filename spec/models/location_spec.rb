require 'spec_helper'

describe Location do
  %i(name address).each do |f|
    it { expect(subject).to validate_presence_of f }
  end

  it { expect(subject).to have_many(:events) }
end
