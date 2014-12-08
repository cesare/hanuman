module ControllerSpecHelpers
  def login_as(person)
    allow(controller).to receive(:current_person).and_return person
    expect(controller).to receive(:authenticate_person!).and_return person
  end
end

RSpec.configure do |config|
  config.include ControllerSpecHelpers, type: :controller
end
