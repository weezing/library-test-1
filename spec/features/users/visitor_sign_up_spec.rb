feature "visitor signs up" do
  scenario "with blank email" do
    sign_up_page = Page::User::Authentication::SignUp.new

    sign_up_page.visit
    sign_up_page.fill_in(
      email: "",
      password: "password",
      password_confirmation: "password"
    )
    sign_up_page.submit

    expect(sign_up_page).to have_blank_email_alert
  end

  scenario "with invalid email" do
    sign_up_page = Page::User::Authentication::SignUp.new

    sign_up_page.visit
    sign_up_page.fill_in(
      email: "first@",
      password: "password",
      password_confirmation: "password"
    )
    sign_up_page.submit

    expect(sign_up_page).to have_invalid_email_alert
  end

  scenario "with blank password" do
    sign_up_page = Page::User::Authentication::SignUp.new

    sign_up_page.visit
    sign_up_page.fill_in(
      email: "first@user.email",
      password: "",
      password_confirmation: "password"
    )
    sign_up_page.submit

    expect(sign_up_page).to have_blank_password_alert
  end

  scenario "with invalid password" do
    sign_up_page = Page::User::Authentication::SignUp.new

    sign_up_page.visit
    sign_up_page.fill_in(email: "first@user.email", password: "passwor", password_confirmation: "password")
    sign_up_page.submit

    expect(sign_up_page).to have_no_match_password_alert
  end

  scenario "with blank password confirmation" do
    sign_up_page = Page::User::Authentication::SignUp.new

    sign_up_page.visit
    sign_up_page.fill_in(
      email: "first@user.email",
      password: "password",
      password_confirmation: ""
    )
    sign_up_page.submit

    expect(sign_up_page).to have_invalid_password_confirmation_alert
  end

  scenario "with invalid password" do
    sign_up_page = Page::User::Authentication::SignUp.new

    sign_up_page.visit
    sign_up_page.fill_in(
      email: "first@user.email",
      password: "password",
      password_confirmation: "passwordd"
    )
    sign_up_page.submit

    expect(sign_up_page).to have_invalid_password_confirmation_alert
  end

  scenario "with valid credentials" do
    sign_up_page = Page::User::Authentication::SignUp.new

    sign_up_page.visit
    sign_up_page.fill_in(
      email: "first@user.email",
      password: "password",
      password_confirmation: "password"
    )
    sign_up_page.submit

    expect(sign_up_page).to have_successful_sign_up_notice
  end
end
