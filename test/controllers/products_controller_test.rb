require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select('.product', 3)
  end

  test 'render a detailed product page' do
    get product_path(products(:ps4))
    assert_response :success
    assert_select('.title', 'PS4 fat')
    assert_select('.description', products(:ps4).description)
    assert_select('.price', products(:ps4).price.to_s)
  end

  test 'render a new form' do
    get new_product_path
    assert_response :success
    assert_select('form', 1)
  end

  test 'create a product' do
    assert_difference('Product.count') do
      post products_path, params: {
        product: {
          title: 'Nintendo 64',
          description: 'Buen estado 9/10',
          price: 70,
          category_id: categories(:videogames).id
        }
      }
    end
    assert_equal(flash[:notice], 'Product created')
  end

  test 'does not allow to create a new product with null field' do
    post products_path, params: {
      product: {
        title: '',
        description: 'Buen estado 9/10',
        price: 70
      }
    }

    assert_response :unprocessable_entity
  end

  test 'render an edit form' do
    get edit_product_path(products(:ps4))
    assert_response :success
    assert_select('form', 1)
  end

  test 'update a product' do
    patch product_path(products(:ps4)), params: {
      product: {
        description: 'Nueva descripcion'
      }
    }

    assert_redirected_to(product_path(products(:ps4)))
    assert_equal(flash[:notice], 'Product edited')
  end

  test 'does not allow to update a product' do
    patch product_path(products(:ps4)), params: {
      product: {
        description: nil
      }
    }

    assert_response :unprocessable_entity
  end

  test 'destroy a product' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:ps4))
    end

    assert_redirected_to(products_path)
    assert_equal(flash[:notice], 'Product deleted')
  end
end
