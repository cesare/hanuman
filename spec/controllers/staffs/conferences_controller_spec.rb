require 'rails_helper'

RSpec.describe Staffs::ConferencesController, type: :controller do
  context 'without signing in' do
    let(:conference) { create :conference, name: 'Testing Conference' }

    describe 'GET #show' do
      specify do
        get :show, id: conference.id

        expect(response).to redirect_to auth_path
      end
    end

    describe 'GET #edit' do
      specify do
        get :edit, id: conference.id

        expect(response).to redirect_to auth_path
      end
    end

    describe 'PUT #update' do
      let(:parameters) do
        {
          id: conference.id,
          conference: {
            name: 'name changed',
            description: 'description changed',
          }
        }
      end

      specify do
        put :update, parameters

        conference.reload
        expect(response).to redirect_to auth_path
        expect(conference.name).to eq 'Testing Conference'
      end
    end
  end

  context 'with a non-staff person signing in' do
    let(:conference) { create :conference, name: 'Testing Conference' }
    let(:person) { create :person }

    before do
      login_as person
    end

    describe 'GET #show' do
      specify do
        get :show, id: conference.id

        expect(response).to be_not_found
      end
    end

    describe 'GET #edit' do
      specify do
        get :edit, id: conference.id

        expect(response).to be_not_found
      end
    end

    describe 'PUT #edit' do
      let(:parameters) do
        {
          id: conference.id,
          conference: {
            name: 'name changed',
            description: 'description changed',
          }
        }
      end

      specify do
        put :update, parameters

        conference.reload
        expect(response).to be_not_found
        expect(conference.name).to eq 'Testing Conference'
      end
    end
  end

  context 'with a staff signing in' do
    let(:conference) { create :conference }
    let(:person) { create :person }
    let!(:staff) { create :staff, person: person, conference: conference }

    before do
      login_as person
    end

    describe 'GET #show' do
      specify do
        get :show, id: conference.id

        expect(response).to be_success
        expect(response).to render_template :show
        expect(assigns(:conference)).to eq conference
      end
    end

    describe 'GET #edit' do
      specify do
        get :edit, id: conference.id

        expect(response).to be_success
        expect(response).to render_template :edit
        expect(assigns(:conference)).to eq conference
      end
    end

    describe 'PUT #update' do
      let(:parameters) do
        {
          id: conference.id,
          conference: {
            name: 'name changed',
            description: 'description changed',
          }
        }
      end

      specify do
        put :update, parameters

        conference.reload
        expect(response).to redirect_to staff_conference_path(conference)
        expect(conference.name).to eq 'name changed'
        expect(conference.description).to eq 'description changed'
      end
    end
  end
end
