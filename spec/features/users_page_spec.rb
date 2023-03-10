require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    @user = FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "only own ratings are shown correctly on user page" do
    
    dude = FactoryBot.create(:user, username: "Guy")

    create_beers_with_many_ratings({user: @user}, 32, 12, 34, 22)
    create_beers_with_many_ratings({user: dude}, 22, 32, 14, 2, 11, 26)

    visit user_path(@user)

    expect(page).to have_content 'Has made 4 ratings'
  end
  
  it "Favorite style is shown on user page" do    
    create_beers_with_many_ratings({user: @user}, 32, 12, 34, 22)
    visit user_path(@user)
    expect(page).to have_content 'Favorite style: Lager'
  end
  it "Favorite brewery is shown on user page" do    
    create_beers_with_many_ratings({user: @user}, 32, 12, 34, 22)
    visit user_path(@user)
    expect(page).to have_content 'Favorite brewery is: anonymous'
  end
  

end