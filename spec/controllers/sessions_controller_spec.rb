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

  describe 'GET #create' do
    let(:person) { create :person }
    let(:user) { create :user, :github, person: person }

    before do
      request.env['omniauth.auth'] = {
        'provider' => 'github',
        'uid' => user.uid,
        'info' => {
          'name' => 'Test User',
          'email' => 'test001@example.com',
        }
      }

      expected_auth_info = {
        provider: 'github',
        uid: user.uid,
        name: 'Test User',
        email: 'test001@example.com',
      }
      expect(SigninService).to receive(:signin).with(expected_auth_info).and_return user
    end

    context 'given no origin' do
      specify do
        get :create, provider: 'github'

        expect(response).to redirect_to root_path
        expect(session[:person_id]).to eq person.id
      end
    end

    context 'given origin uri' do
      before do
        request.env['omniauth.origin'] = '/conferences/1'
      end

      specify do
        get :create, provider: 'github'

        expect(response).to redirect_to '/conferences/1'
        expect(session[:person_id]).to eq person.id
      end
    end

    context 'given invalid origin uri' do
      before do
        request.env['omniauth.origin'] = 'http://external.example.com/'
      end

      specify do
        get :create, provider: 'github'

        expect(response).to redirect_to root_path
        expect(session[:person_id]).to eq person.id
      end
    end
  end

  describe 'GET #destroy' do
    before do
      session[:person_id] = 123
    end

    specify do
      get :destroy

      expect(response).to redirect_to root_path
      expect(session).to be_empty
    end
  end
end
