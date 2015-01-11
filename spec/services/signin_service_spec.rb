RSpec.describe SigninService, type: :service do
  describe '.signin' do
    context 'when the user is not registered' do
      let(:user) { SigninService.signin provider: 'github', uid: '1234', name: 'Test User', email: 'test001@example.com' }

      specify do
        expect(user).to be_a User
        expect(user.provider).to eq 'github'
        expect(user.uid).to eq '1234'
        expect(user.name).to eq 'Test User'

        person = user.person
        expect(person.name).to eq 'Test User'
      end
    end

    context 'when the user has been registered' do
      let(:person) { create :person, email: 'test001@example.com' }
      let!(:user) { create :user, person: person, provider: 'github', uid: '1234' }

      specify do
        results = SigninService.signin provider: 'github', uid: '1234', name: 'Changed Name', email: 'another@example.com'
        user.reload

        expect(results).to eq user
        expect(results.name).to eq 'Changed Name'

        person.reload
        expect(person.email).to eq 'test001@example.com'
      end
    end
  end
end
