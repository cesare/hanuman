require 'rails_helper'

RSpec.describe Conferences::ProposalsController, type: :controller do
  let(:person) { create :person }
  let(:conference) { create :conference, :open_to_proposals }
  let(:proposal) { create :proposal, conference: conference, person: person }

  context 'without signing in' do
    describe 'GET #show' do
      specify do
        get :show, conference_id: conference.id, id: proposal.id

        expect(response).to redirect_to auth_path
      end
    end

    describe 'GET #new' do
      specify do
        get :new, conference_id: conference.id

        expect(response).to redirect_to auth_path
      end
    end

    describe 'POST #create' do
      specify do
        post :create, conference_id: conference.id

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
        post :create, conference_id: conference.id, proposal: { title: 'test', summary: 'Test', notes: 'test notes' }

        new_proposal = conference.proposals(true).last
        expect(new_proposal.person).to eq person
        expect(new_proposal.title).to eq 'test'

        expect(response).to redirect_to conference_proposal_path(conference, new_proposal)
      end
    end

    describe 'GET #edit' do
      specify do
        get :edit, conference_id: conference.id, id: proposal.id

        expect(response).to be_success
        expect(response).to render_template :edit
        expect(assigns(:conference)).to eq conference
        expect(assigns(:proposal)).to eq proposal
      end
    end

    describe 'PUT #update with invalid parameters' do
      let(:parameters) do
        {
          conference_id: conference.id,
          id: proposal.id,
          proposal: {
            title: '',
            summary: '',
          }
        }
      end

      specify do
        put :update, parameters

        expect(response).to have_http_status :unprocessable_entity
        expect(response).to render_template :edit
      end
    end

    describe 'PUT #update with valid parameters' do
      let(:parameters) do
        {
          conference_id: conference.id,
          id: proposal.id,
          proposal: {
            title: 'changed title',
            summary: 'changed summary',
            notes: 'notes also changed',
          }
        }
      end

      specify do
        put :update, parameters

        proposal.reload
        expect(response).to redirect_to conference_proposal_path(conference, proposal)
        expect(proposal.title).to eq 'changed title'
        expect(proposal.summary).to eq 'changed summary'
        expect(proposal.notes).to eq 'notes also changed'
      end
    end

    describe 'DELETE #destroy' do
      specify do
        delete :destroy, conference_id: conference.id, id: proposal.id

        expect(response).to redirect_to conference_path conference
        expect(Proposal.exists? proposal.id).to be false
      end
    end
  end

  context 'with another person signing in' do
    before do
      login_as create(:person)
    end

    describe 'GET #show' do
      specify do
        get :show, conference_id: conference.id, id: proposal.id

        expect(response).to have_http_status :not_found
      end
    end

    describe 'GET #edit' do
      specify do
        get :edit, conference_id: conference.id, id: proposal.id

        expect(response).to have_http_status :not_found
      end
    end

    describe 'DELETE #destroy' do
      specify do
        delete :destroy, conference_id: conference.id, id: proposal.id

        expect(response).to be_not_found
      end
    end
  end

  context 'when the conference is not open to proposals' do
    let(:conference) { create :conference, :settled }

    before do
      login_as create(:person)
    end

    describe 'GET #new' do
      specify do
        get :new, conference_id: conference.id

        expect(response).to redirect_to conference_path(conference)
      end
    end

    describe 'POST #create' do
      specify do
        post :create, conference_id: conference.id, proposal: { title: 'test', summary: 'Test' }

        expect(response).to redirect_to conference_path(conference)
        expect(conference.proposals(true)).to be_empty
      end
    end
  end
end
