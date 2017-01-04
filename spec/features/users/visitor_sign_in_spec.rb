feature "visitor signs in" do
  scenario "with invalid email" do
    sign_in_page = Page::User::Authentication::SignIn.new

    sign_in_page.visit
    sign_in_page.fill_in(email: Faker::Internet.email, password: "password")
    sign_in_page.submit

    expect(sign_in_page).to have_unsuccessful_sign_in_alert
  end

  scenario "with invalid password" do
    sign_in_page = Page::User::Authentication::SignIn.new
    create(:user, email: "first@user.email")

    sign_in_page.visit
    sign_in_page.fill_in(email: "first@user.email", password: "passwordd")
    sign_in_page.submit

    expect(sign_in_page).to have_unsuccessful_sign_in_alert
  end

  scenario "with valid credentials" do
    sign_in_page = Page::User::Authentication::SignIn.new
    home_page = Page::User::Home.new
    create(:user, email: "first@user.email", confirmed_at: Time.zone.now)

    sign_in_page.visit
    sign_in_page.fill_in(email: "first@user.email", password: "password")
    sign_in_page.submit

    expect(home_page).to have_successful_sign_in_notice
  end

  scenario "and signs out" do
    sign_in_page = Page::User::Authentication::SignIn.new
    home_page = Page::User::Home.new
    create(:user, email: "first@user.email", confirmed_at: Time.zone.now)

    sign_in_page.visit
    sign_in_page.fill_in(email: "first@user.email", password: "password")
    sign_in_page.submit

    home_page.sign_out

    expect(home_page).to have_successful_sign_out_notice
  end
end
