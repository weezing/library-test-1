module Page
  module User
    class Home < Page::Base
      def visit
        super "/"
      end

      def has_successful_sign_in_notice?
        page.has_text? "Signed in successfully"
      end

      def sign_out
        click_on "Sign out"
      end

      def has_successful_sign_out_notice?
        page.has_text? "Signed out successfully"
      end

      def has_successful_change_password_notice?
        page.has_text? "Your password has been changed successfully. You are now signed in."
      end
    end
  end
end
