require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    context 'when auth_origin_uri is not set' do
      specify do
        get :new

        expect(response).to be_success
        expect(response).to render_template :new
        expect(assigns(:auth_origin_uri)).not_to be_present
      end
    end

    context 'when auth_origin_uri is set' do
      specify do
        get :new, {}, auth_origin_uri: '/test/uri'

        expect(response).to be_success
        expect(response).to render_template :new
        expect(assigns(:auth_origin_uri)).to eq '/test/uri'
        expect(session[:auth_origin_uri]).not_to be_present
      end
    end
  end
end
