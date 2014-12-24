require 'rails_helper'

RSpec.describe Staffs::ConferencesController, type: :controller do
  context 'without signing in' do
    describe 'GET #show' do
      let(:conference) { create :conference }

      specify do
        get :show, id: conference.id

        expect(response).to redirect_to auth_path
      end
    end
  end

  context 'with a non-staff person signing in' do
    describe 'GET #show' do
      let(:conference) { create :conference }
      let(:person) { create :person }

      before do
        login_as person
      end

      specify do
        get :show, id: conference.id

        expect(response).to be_not_found
      end
    end
  end

  context 'with a staff signing in' do
    describe 'GET #show' do
      let(:conference) { create :conference }
      let(:person) { create :person }
      let!(:staff) { create :staff, person: person, conference: conference }

      before do
        login_as person
      end

      specify do
        get :show, id: conference.id

        expect(response).to be_success
        expect(response).to render_template :show
        expect(assigns(:conference)).to eq conference
      end
    end
  end
end
