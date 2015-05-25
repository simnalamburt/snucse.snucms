require 'test_helper'

class CalendarControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @today = Date.today
    @year = @today.year
    @month = @today.month
    @start_wday = @today.at_beginning_of_month.wday

    @user = users(:one)
    sign_in :user, @user
  end

  test "should get index" do
    get :index
    doc = Nokogiri::HTML response.body
    assert_equal 1, doc.search("table.calendar td")[@start_wday].text.to_i
  end

end
