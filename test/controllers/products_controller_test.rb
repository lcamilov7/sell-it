require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login # Este metodo lo definimos en test_helper.rb
  end

  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select('.product', 12)
    assert_select('.category', 9)
  end

  test 'render a list of products fileterd by category' do
    get products_path(category_id: categories(:videogames).id)
    assert_response :success
    assert_select('.product', 7)
  end

  test 'render a list of products fileterd by price' do
    get products_path(min_price: 130, max_price: 160)
    assert_response :success
    assert_select('.product', 3)
  end

  test 'render a list of products fileterd by search' do
    get products_path(min_price: 130, max_price: 200, query: 'switch')
    assert_response :success
    assert_select('.product', 1)
  end

  test 'render a list of products fileterd by expensive' do
    get products_path(order: 'expensive')
    assert_response :success
    assert_select('.product', 12)

    # nos encuentra el primer producto
    assert_select('.products .product:first-child h2', 'Seat Panda clásico')
  end

  test 'render a list of products fileterd by cheap' do
    get products_path(order: 'cheap')
    assert_response :success
    assert_select('.product', 12)

    # nos encuentra el primer producto
    assert_select('.products .product:first-child h2', 'El hobbit')
  end

  test 'render a detailed product page' do
    get product_path(products(:ps4))
    assert_response :success
    assert_select('.title', 'PS4 Fat')
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
