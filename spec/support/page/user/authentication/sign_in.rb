module Page
  module User
    module Authentication
      class SignIn < Page::Base
        form_resource :user

        def visit
          super new_user_session_path
        end

        def submit
          click_button "Log in"
        end

        def has_unsuccessful_sign_in_alert?
          page.has_text? "Invalid Email or password"
        end

        def has_successful_reset_password_notice?
          page.has_text? "You will receive an email with instructions on how to reset your password in a few minutes."
        end

        def has_authentication_alert?
          page.has_text? "You need to sign in or sign up before continuing."
        end
      end
    end
  end
end
