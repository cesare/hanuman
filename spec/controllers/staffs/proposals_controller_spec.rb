require 'rails_helper'

RSpec.describe Staffs::ProposalsController, type: :controller do
  let(:person) { create :person }
  let(:conference) { create :conference, :open_to_proposals }
  let(:proposal) { create :proposal, conference: conference, person: person }

  context 'without signing in' do
    describe 'GET #index' do
      specify do
        get :index, conference_id: conference.id

        expect(response).to redirect_to auth_path
      end
    end

    describe 'GET #show' do
      specify do
        get :show, conference_id: conference.id, id: proposal.id

        expect(response).to redirect_to auth_path
      end
    end
  end

  context 'with a non-staff person signing in' do
    before do
      login_as person
    end

    describe 'GET #index with a non-staff person' do
      specify do
        get :index, conference_id: conference.id

        expect(response).to be_not_found
      end
    end

    describe 'GET #show with a non-staff person' do
      specify do
        get :show, conference_id: conference.id, id: proposal.id

        expect(response).to be_not_found
      end
    end
  end

  context 'with a staff signing in' do
    let!(:staff) { create :staff, conference: conference, person: person }

    before do
      login_as person
    end

    describe 'GET #index with a staff of the conference' do
      let!(:proposals) { create_list :proposal, 3, conference: conference, person: create(:person) }
      let!(:vote) { create :vote, person: person, proposal: proposals.first }

      specify do
        get :index, conference_id: conference.id

        expect(response).to be_success
        expect(response).to render_template :index
        expect(assigns(:conference)).to eq conference
        expect(assigns(:proposals)).to match_array proposals
        expect(assigns(:votes_by_person)).to match_array [vote]
      end
    end

    describe 'GET #show' do
      specify do
        get :show, conference_id: conference.id, id: proposal.id

        expect(response).to be_success
        expect(response).to render_template :show
        expect(assigns(:proposal)).to eq proposal
      end
    end
  end
end
