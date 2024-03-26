require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get show user and list of their products' do
    get user_url(users(:sara).username)
    assert_response(:success)
    assert_select('h4', 'raticavivaz4')
  end
end
