module UserLogin
  def create_user
    User.create!(name: "Name1", email: "email@domain.com", password: "Password1", password_confirmation: "Password1")
  end

  def login_user(user)
    visit root_path
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button :login
  end
end
