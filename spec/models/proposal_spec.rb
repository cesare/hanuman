require 'rails_helper'

RSpec.describe Proposal, type: :model do
  describe 'validations' do
    let(:conference) { create :conference }
    let(:person) { create :person }

    context 'given valid parameters' do
      let(:proposal) { build :proposal, conference: conference, person: person }

      it { expect(proposal).to be_valid }
    end

    context 'when conference is missing' do
      let(:proposal) { build :proposal, person: person }

      it { expect(proposal).to have_at_least(1).errors_on :conference }
    end

    context 'when person is missing' do
      let(:proposal) { build :proposal, conference: conference }

      it { expect(proposal).to have_at_least(1).errors_on :person }
    end

    context 'when title is missing' do
      let(:proposal) { build :proposal, title: nil, conference: conference, person: person }

      it { expect(proposal).to have_at_least(1).errors_on :title }
    end

    context 'when summary is missing' do
      let(:proposal) { build :proposal, summary: nil, conference: conference, person: person }

      it { expect(proposal).to have_at_least(1).errors_on :summary }
    end
  end
end
