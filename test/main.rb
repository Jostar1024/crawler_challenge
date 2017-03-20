$:.unshift File.dirname(__FILE__)     # adds current directory to load path
require "minitest/autorun"

require 'main'

class TestMain < Minitest::Test

  def test_that_something_works
    # what would you actually want to test ?
    assert_equal 'test', 'test'
  end

end