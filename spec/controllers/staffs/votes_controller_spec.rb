require 'rails_helper'

RSpec.describe Staffs::VotesController, type: :controller do
  let(:person) { create :person }
  let(:conference) { create :conference, :open_to_proposals }
  let(:proposal) { create :proposal, conference: conference, person: person }

  context 'without signing in' do
    describe 'POST #create' do
      specify do
        post :create, conference_id: conference.id, vote: { proposal_id: proposal.id }

        expect(response).to redirect_to auth_path
      end
    end

    describe 'DELETE #destroy' do
      specify do
        delete :destroy, conference_id: conference.id, id: proposal.id

        expect(response).to redirect_to auth_path
      end
    end
  end

  context 'with a non-staff person signing in' do
    before do
      login_as person
    end

    describe 'POST #create' do
      specify do
        post :create, conference_id: conference.id, vote: { proposal_id: proposal.id }

        expect(response).to be_not_found
      end
    end

    describe 'DELETE #destroy' do
      specify do
        delete :destroy, conference_id: conference.id, id: proposal.id

        expect(response).to be_not_found
      end
    end
  end

  context 'with a staff signing in' do
    let!(:staff) { create :staff, conference: conference, person: person }

    before do
      login_as person
    end

    describe 'POST #create' do
      specify do
        post :create, conference_id: conference.id, vote: { proposal_id: proposal.id }

        expect(response).to redirect_to staff_conference_proposals_path(conference)
        expect(person.votes(true).find_by proposal: proposal).to be_present
      end
    end

    describe 'DELETE #destroy' do
      before do
        create :vote, person: person, proposal: proposal
      end

      specify do
        delete :destroy, conference_id: conference.id, id: proposal.id

        expect(response).to redirect_to staff_conference_proposals_path(conference)
        expect(person.votes(true).find_by proposal: proposal).not_to be_present
      end
    end

    describe 'DELETE #destroy to a proposal that is not voted by the person' do
      specify do
        delete :destroy, conference_id: conference.id, id: proposal.id

        expect(response).to be_not_found
      end
    end
  end
end
