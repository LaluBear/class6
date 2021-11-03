require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "Email", with: @user.email
    fill_in "Name", with: @user.name
    fill_in "Password", with: @user.password
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "Email", with: @user.email
    fill_in "Name", with: @user.name
    fill_in "Password", with: @user.password
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
  
  test "test login" do
    
    @user = users(:test_user_1)
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "Login"
  end
  
  test "test login wrong" do
    
    @user = users(:test_user_1)
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: 555
    click_on "Login"
    assert_text "Wrong Email or Password"
  end
  
  test "test like" do
    
    @user = users(:one)
    @post = @user.posts.first
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "Login"
    
    visit "/feed"
    assert_difference("@post.likes.count", 1) do
      click_on "like", match: :first
    end
    visit "/profile/#{@user.name}"
    assert_text "#{user.name}", match: :second
  end
  
end
