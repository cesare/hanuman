require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:person) { create :person }

    context 'given valid parameters' do
      let(:user) { build :user, person: person }

      it { expect(user).to be_valid }
    end

    context 'when name is missing' do
      let(:user) { build :user, name: nil, person: person }

      it { expect(user).to have_at_least(1).errors_on :name }
    end

    context 'when uid is missing' do
      let(:user) { build :user, uid: nil, person: person }

      it { expect(user).to have_at_least(1).errors_on :uid }
    end

    context 'when provider is missing' do
      let(:user) { build :user, provider: nil, person: person }

      it { expect(user).to have_at_least(1).errors_on :provider }
    end

    context 'when person is missing' do
      let(:user) { build :user, person: nil }

      it { expect(user).to have_at_least(1).errors_on :person }
    end

    context 'given non-existing person_id' do
      let(:user) { build :user, person_id: 987_654 }

      it { expect(user).to have_at_least(1).errors_on :person }
    end
  end
end
