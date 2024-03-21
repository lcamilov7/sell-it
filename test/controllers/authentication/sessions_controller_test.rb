require 'test_helper'

class Authentication::SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sara)
  end

  test 'should get new session form' do
    get new_session_url
    assert_response :success
  end

  test 'should login an user by email' do
    post sessions_url, params: { login: @user.email, password: 'testme' } # Una session no es un modelo entones no tenemos que enviar params: { session: {login...}}, sino q solo tenemos q poner params: { login:...}

    assert_redirected_to products_url
  end

  test 'should login an user by username' do
    post sessions_url, params: { login: @user.username, password: 'testme' } # Una session no es un modelo entones no tenemos que enviar params: { session: {login...}}, sino q solo tenemos q poner params: { login:...}

    assert_redirected_to products_url
  end

  test 'should log out' do
    login
    delete session_url(@user.id)
    assert_nil(session[:user_id])

    assert_redirected_to(products_url)
    assert_equal(flash[:notice], 'Logged out')
  end
end
