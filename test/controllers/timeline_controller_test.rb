require 'test_helper'
require 'nokogiri'

class TimelineControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @user = users(:one)
    sign_in :user, @user
    @user.courses = [courses(:one), courses(:two)]
  end

  test "should_index_normal_page" do
    get :index
    doc = Nokogiri::HTML response.body
    assert_equal 5, doc.search('.ui.fluid.card').size

    get :index, count: 3
    doc = Nokogiri::HTML response.body
    assert_equal 3, doc.search('.ui.fluid.card').size
  end

  test "older_than_should_work" do
    get :older_than, offset: 2
    doc = Nokogiri::HTML response.body
    assert_equal 1, doc.search('.ui.fluid.card').size
    get :older_than, offset: 1
    doc = Nokogiri::HTML response.body
    assert_equal 1, doc.search('.ui.fluid.card').size
    assert_equal "You don't describe any course or no course have notification!", doc.at_css('.ui.fluid.card .description').text.strip

  end

  test "older_than ajax" do
    get :older_than, offset: 1, ajax: "1"
    assert_equal '', response.body

    get :older_than, offset: 2, ajax: "1"
    doc = Nokogiri::HTML response.body
    assert_equal 1, doc.search('.ui.fluid.card').size
  end

  test "since test" do
    get :since, since_id: 1
    doc = Nokogiri::HTML response.body
    assert_equal 4, doc.search('.ui.fluid.card').size

    get :since, since_id: 5
    doc = Nokogiri::HTML response.body
    assert_equal 0, doc.search('.ui.fluid.card').size

    get :since, since_id: 'asdf'
    assert_equal '', response.body
  end
end
