module FeatureHelpers
  include Warden::Test::Helpers
  Warden.test_mode!

  def sign_in(user)
    login_as(user, :scope => user.class.to_s.underscore.to_sym)
  end
end
