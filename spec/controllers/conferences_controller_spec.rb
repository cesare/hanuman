require 'rails_helper'

RSpec.describe ConferencesController, type: :controller do
  describe 'GET #index' do
    let!(:conference1) { create :conference, :published }
    let!(:conference2) { create :conference, :published }
    let!(:conference3) { create :conference, :unpublished }

    specify do
      get :index

      expect(response).to be_success
      expect(response).to render_template :index
      expect(assigns(:conferences)).to match_array [conference1, conference2]
    end
  end

  describe 'GET #show' do
    context 'when the conference is published' do
      let!(:conference) { create :conference, :published }

      specify do
        get :show, id: conference.id

        expect(response).to be_success
        expect(response).to render_template :show
        expect(assigns(:conference)).to eq conference
      end
    end

    context 'when the conference is not published' do
      let!(:conference) { create :conference, :unpublished }

      specify do
        get :show, id: conference.id

        expect(response).to be_not_found
      end
    end
  end

  describe 'GET #show for non-existing conference' do
    specify do
      get :show, id: 999

      expect(response).to be_not_found
    end
  end
end
