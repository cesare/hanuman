require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'given valid parameters' do
      let(:user) { build :user, person_id: 123 }

      it { expect(user).to be_valid }
    end

    context 'when name is missing' do
      let(:user) { build :user, name: nil, person_id: 123 }

      it { expect(user).to have_at_least(1).errors_on :name }
    end

    context 'when uid is missing' do
      let(:user) { build :user, uid: nil, person_id: 123 }

      it { expect(user).to have_at_least(1).errors_on :uid }
    end

    context 'when provider is missing' do
      let(:user) { build :user, provider: nil, person_id: 123 }

      it { expect(user).to have_at_least(1).errors_on :provider }
    end
  end
end
