require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login # Sara
    @ps4 = products(:ps4)
    @switch = products(:switch)
  end

  test 'should show user favorites' do
    get favorites_url(favorites: true)
    assert_response(:success)
  end

  test 'should create a favorite' do
    assert_difference('Favorite.count') do
      post favorites_url(product_id: @ps4.id)
    end
    assert_redirected_to(product_path(@ps4))
  end

  test 'should destroy favorite' do
    assert_difference('Favorite.count', -1) do
      delete favorite_url(product_id: @switch.id)
    end
    assert_redirected_to(product_path(@switch))
  end
end
