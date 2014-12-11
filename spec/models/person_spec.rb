require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'validations' do
    context 'given valid parameters' do
      let(:person) { build :person }

      it { expect(person).to be_valid }
    end

    context 'when name is missing' do
      let(:person) { build :person, name: nil }

      it { expect(person).to have_at_least(1).errors_on :name }
    end
  end

  describe '#admin' do
    context 'ordinary people' do
      let(:person) { build :person }

      it { expect(person).not_to be_admin }
    end

    context 'person with the admin flag on' do
      let(:person) { build :person, admin: true }

      it { expect(person).to be_admin }
    end
  end
end
