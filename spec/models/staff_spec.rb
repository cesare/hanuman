require 'rails_helper'

RSpec.describe Staff, type: :model do
  describe 'validations' do
    let(:conference) { create :conference }
    let(:person) { create :person }

    context 'given valid parameters' do
      let(:staff) { build :staff, conference: conference, person: person }

      it { expect(staff).to be_valid }
    end

    context 'when conference is missing' do
      let(:staff) { build :staff, person: person }

      it { expect(staff).to have_at_least(1).errors_on :conference }
    end

    context 'when person is missing' do
      let(:staff) { build :staff, conference: conference }

      it { expect(staff).to have_at_least(1).errors_on :person }
    end
  end
end
