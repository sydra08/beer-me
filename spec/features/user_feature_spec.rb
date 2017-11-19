describe 'Feature Test: User', :type => :feature do
  describe 'Registration' do
    before do
      # visit sign up page
      visit new_user_path
      # fill in first name
      fill_in "First name", with: "Sydney"
      # fill in last name
      fill_in "Last name", with: "C"
      # fill in email address
      fill_in "Email", with: "test@example.com"
      # fill in password
      fill_in "Password", with: "password"
      # click "Register"
      click_button "Register"
    end

    let(:user) {User.find_by(email: "test@example.com")}

    it 'creates a valid user' do
      # expect new user to exist
      expect(user).not_to be_nil
    end

    it 'redirects to the new user page' do
      # redirect to user homepage
      expect(current_path).to eq(user_path(user))
    end

    it 'correctly stores the user id in the session hash' do
      # expect session[:user_id] == user.id
      # need to add rack_session_access gem
    end


    it 'displays errors if email is invalid'
      # do you need this if you have validation tests in the model?
      # visit sign up page
      # enter invalid email
      # expect page to have content ("email has already been taken")
    it 'displays errors if password is invalid'
      # visit sign up page
      # enter invalid email
      # expect page to have content ("something about invalid password")

    context "logged in" do
      it 'redirects to user homepage if session[:user_id]'
        # log in
        # visit sign up page
        # expect to be redirected to user homepage
    end
  end

  describe "Login" do
    before do
      @user = User.create(
        first_name: "Sydney",
        last_name: "C",
        email: "sydney@example.com",
        password: "password"
      )
      # visit sign up page
      visit new_session_path
      # fill in first name
      fill_in "user[email]", with: @user.email
      # fill in password
      fill_in "user[password]", with: @user.password
      # click "Register"
      click_button "Log In"
    end

    it 'sets session[:user_id]'

    it 'redirects to user page' do
      expect(current_path).to eq(user_path(@user))
    end
  end

  describe "Logout" do
    it 'clears session[:user_id]'
    it 'redirects to root path'
  end

end
