require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:amybobamy)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_not_nil session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    delete logout_path
    follow_redirect!
    log_in_as(@user)
    assert_nil session[:forwarding_url]
    assert_redirected_to @user
    name  =  "Foo Bar"
    email =  "foo@bar.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email, 
                                              password:              "", 
                                              password_confirmation: ""} }

    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal  name, @user.name
    assert_equal email, @user.email
  end
end
