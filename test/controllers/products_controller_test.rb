require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select('a', 2)
  end

  test 'render a detailed product page' do
    get product_path(products(:ps4))
    assert_response :success
    assert_select('.title', 'PS4 fat')
    assert_select('.description', products(:ps4).description)
    assert_select('.price', products(:ps4).price.to_s)
  end
end
