require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def new_product(image_url)
    Product.new(:title       => "Some Title",
                :description => "xyz",
                :price       => 1,
                :image_url   => image_url);
  end

  test "empty attributes should not pass validation" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "price must be positive" do
    product = Product.new(:title => "test title which should validate length",
                          :description => "foobar",
                          :image_url => "xyz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join('; ')

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join('; ')

    product.price = 1
    assert product.valid?
  end

  test "image url is validated" do
    valid_urls = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/Fred.gif }
    invalid_urls = %w{ fred.doc fred.gif/more fred.jpeg fred.gif.more }

    valid_urls.each do |url|
      assert new_product(url).valid?, "#{url} should be valid"
    end

    invalid_urls.each do |url|
      assert new_product(url).invalid?, "#{url} should not be valid"
    end
  end

  test "titles must be unique" do
    product = new_product("some_url.jpg")
    product.title = products(:bacon).title
    assert !product.save
    assert_equal I18n.translate("activerecord.errors.messages.taken"), product.errors[:title].join('; ');
  end

  test "no short titles" do
    product = new_product("some_url.jpg")
    product.title = "small"
    assert !product.save
  end
end
