require 'rails_helper'

RSpec.describe Conferences::ProposalsController, type: :controller do
  let(:person) { create :person }
  let(:conference) { create :conference }
  let(:proposal) { create :proposal, conference: conference, person: person }

  context 'without signing in' do
    describe 'GET #show' do
      specify do
        get :show, conference_id: conference.id, id: proposal.id

        expect(response).to redirect_to '/auth'
      end
    end

    describe 'GET #new' do
      specify do
        get :new, conference_id: conference.id

        expect(response).to redirect_to '/auth'
      end
    end

    describe 'POST #create' do
      specify do
        post :create, conference_id: conference.id

        expect(response).to redirect_to '/auth'
      end
    end
  end

  context 'with signing in' do
    before do
      login_as person
    end

    describe 'GET #show' do
      specify do
        get :show, conference_id: conference.id, id: proposal.id

        expect(response).to be_success
        expect(response).to render_template :show
        expect(assigns(:conference)).to eq conference
        expect(assigns(:proposal)).to eq proposal
      end
    end

    describe 'GET #new' do
      specify do
        get :new, conference_id: conference.id

        expect(response).to be_success
        expect(response).to render_template :new
        expect(assigns(:conference)).to eq conference
        expect(assigns(:proposal)).to be_present
      end
    end

    describe 'POST #create with invalid parameters' do
      specify do
        post :create, conference_id: conference.id, proposal: { foo: 'bar' }

        expect(response).to have_http_status :unprocessable_entity
        expect(response).to render_template :new
      end
    end

    describe 'POST #create with valid paramters' do
      specify do
        post :create, conference_id: conference.id, proposal: { title: 'test', summary: 'Test' }

        new_proposal = conference.proposals(true).last
        expect(new_proposal.person).to eq person
        expect(new_proposal.title).to eq 'test'

        expect(response).to redirect_to conference_proposal_path(conference, new_proposal)
      end
    end
  end
end
