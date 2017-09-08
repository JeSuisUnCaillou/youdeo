require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
   test "root path should exist" do
     get root_url
     assert_response :success
   end
end
