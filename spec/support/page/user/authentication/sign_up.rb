module Page
  module User
    module Authentication
      class SignUp < Page::Base
        form_resource :user

        def visit
          super new_user_registration_path
        end

        def submit
          click_button "Sign up"
        end

        def has_successful_sign_up_notice?
          page.has_text? "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."
        end

        def has_invalid_email_alert?
          within ".form-inputs" do
            page.has_text? "is invalid"
          end
        end

        def has_blank_email_alert?
          within ".form-inputs" do
            page.has_text? "can't be blank"
          end
        end

        def has_taken_email_alert?
          page.has_text? "taken"
        end

        def has_invalid_password_alert?
          within ".form-inputs" do
            page.has_text? "too short"
          end
        end

        def has_blank_password_alert?
          within ".form-inputs" do
            page.has_text? "can't be blank"
          end
        end

        def has_invalid_password_confirmation_alert?
          within ".form-inputs" do
            page.has_text? "match"
          end
        end

        def has_no_match_password_alert?
          within ".form-inputs" do
            page.has_text? "doesn't match"
          end
        end
      end
    end
  end
end
