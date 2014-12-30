require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe 'validations' do
    let(:conference) { create :conference }
    let(:proposal) { create :proposal, conference: conference, person: create(:person) }
    let(:person) { create :person }

    context 'given valid parameters' do
      let(:vote) { build :vote, proposal: proposal, person: person }

      it { expect(vote).to be_valid }
    end

    context 'when proposal is missing' do
      let(:vote) { build :vote, person: person }

      it { expect(vote).to have_at_least(1).errors_on :proposal }
    end

    context 'when person is missing' do
      let(:vote) { build :vote, proposal: proposal }

      it { expect(vote).to have_at_least(1).errors_on :person }
    end

    context 'when proposal has been already voted' do
      before do
        create :vote, person: person, proposal: proposal
      end

      let(:vote) { build :vote, proposal: proposal, person: person }

      it { expect(vote).to have_at_least(1).errors_on :proposal }
    end
  end
end
