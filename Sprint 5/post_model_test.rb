require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should not save post without content" do
    post = Post.new
    assert_not post.save
  end

  test "should not save post without content length > 0" do
    post = Post.new(:content => "")
    assert_not post.save
  end

  test "should not save post if content length > 256" do
    content = ""
    until content.length > 256
      content += "0123456789"
    end
    post = Post.new(:content => content)
    assert_not post.save
  end

  test "should save if all requirements are met" do
    post = Post.new(:content => "Acceptable #content.")
    assert post.save
  end
end
