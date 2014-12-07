require 'rails_helper'

RSpec.describe ConferencesController, type: :controller do
  describe 'GET #index' do
    let!(:conference1) { create :conference }
    let!(:conference2) { create :conference }

    specify do
      get :index

      expect(response).to be_success
      expect(response).to render_template :index
      expect(assigns(:conferences)).to match_array [conference1, conference2]
    end
  end

  describe 'GET #show' do
    let!(:conference) { create :conference }

    specify do
      get :show, id: conference.id

      expect(response).to be_success
      expect(response).to render_template :show
      expect(assigns(:conference)).to eq conference
    end
  end
end
