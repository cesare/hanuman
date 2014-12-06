class SigninService
  attr_reader :provider, :uid, :name

  class << self
    def signin(provider:, uid:, name:)
      new(provider: provider, uid: uid, name: name).create
    end
  end

  def initialize(provider:, uid:, name:)
    @provider = provider
    @uid = uid
    @name = name
  end

  def create
    User.transaction do
      user = User.find_by(provider: provider, uid: uid)
      if user
        update_user(user)
      else
        user = create_user_and_person
      end

      user
    end
  end

  private

  def update_user(user)
    user.name = name
    user.save!
  end

  def create_user_and_person
    person = Person.create!(name: name)
    User.create!(provider: provider, uid: uid, name: name, person: person)
  end
end
