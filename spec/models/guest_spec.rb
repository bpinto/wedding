require 'spec_helper'

describe Guest do
  subject { guest }

  let(:guest) { FactoryGirl.build :guest }

  its(:valid?) { should be_true }

  describe 'validations' do
    it 'requires a name' do
      expect { guest.name = nil }.to change{ guest.valid? }.from(true).to(false)
    end
  end
end
