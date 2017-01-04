class CreateOmniauthUserService
  attr_reader :oauth_user, :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    if existing_user
      true
    else
      if existing_email
        save_oauth_user
        true
      else
        build_oauth_user
        save_oauth_user
      end
    end
  end

  private

  def build_oauth_user
    @oauth_user = User.new
    @oauth_user.password = Devise.friendly_token[0,20]
    @oauth_user.email = @auth.info["email"]
    @oauth_user.uid = @auth.uid
  end

  def existing_user
    @oauth_user = User.find_by(uid: @auth.uid)
  end

  def existing_email
    @oauth_user = User.find_by(email: @auth.info.email)
    if @oauth_user.present?
      @oauth_user.uid = @auth.uid
    end
  end

  def save_oauth_user
    @oauth_user.save
  end
end
