require 'rails_helper'

RSpec.describe Conference, type: :model do
  describe 'validations' do
    context 'given valid parameters' do
      let(:conference) { build :conference }

      it { expect(conference).to be_valid }
    end

    context 'when name is missing' do
      let(:conference) { build :conference, name: nil }

      it { expect(conference).to have_at_least(1).errors_on :name }
    end

    context 'when description is missing' do
      let(:conference) { build :conference, description: nil }

      it { expect(conference).to have_at_least(1).errors_on :description }
    end
  end
end
