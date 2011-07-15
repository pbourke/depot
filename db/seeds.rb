# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Product.delete_all
Product.create(:title => 'Foobar product',
               :description => %{<p>Here is the description for <b>Foobar Product</b></p>},
               :image_url => '/images/foobar.jpg',
               :price => 49.50)
