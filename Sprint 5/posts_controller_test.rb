require 'test_helper'

class PostsControllerTest < ActionController::TestCase
 
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get show" do
    post = posts :post_one
    get(:show, {'id' => post.id})
    assert_response :success
    assert_not_nil assigns(:post)
  end

  test "should get new" do
    post = posts :post_one
    get :new
    assert_response :success
    assert_not_nil assigns(:post)
  end

  test "should get edit" do
    post = posts :post_one
    get(:edit, {'id' => post.id})
    assert_response :success
    assert_not_nil assigns(:post)
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: {content: 'Acceptable #content'}
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should create new hashtags for post" do
    assert_difference('Post.count') do
      post :create, post: {content: 'Acceptable #content'}
    end

    assert_not_nil Hashtag.where(["text = :t", { t: "#content" }]).first
    assert_redirected_to post_path(assigns(:post))
  end

  test "should reuse existing hashtags for post" do
    hashtag = hashtags :yay
    count = hashtag.posts.length
    
    assert_difference('Post.count') do
      post :create, post: {content: 'Acceptable #yay'}
    end
    hashtag = Hashtag.where(["text = :t", { t: "#yay" }]).first
    assert_not_nil hashtag
    assert hashtag.posts.length == count + 1
    assert_redirected_to post_path(assigns(:post))
  end

  test "should update post" do
    post = posts :post_one
    patch :update, id: post.id, post: {content: 'Acceptable #yay'}
    assert post.content = 'Acceptable'
    assert_redirected_to post_path(assigns(:post))
  end

  test "should remove unused hashtags on update" do
    post = posts :post_one
    patch :update, id: post.id, post: {content: 'Acceptable'}
    assert post.content = 'Acceptable'
    assert post.hashtags.length == 0
    assert_nil Hashtag.where(["text = :t", { t: "#first" }]).first
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    post = posts :post_two
    assert_difference('Post.count', -1) do
      delete :destroy, id: post.id
    end
    assert_not_nil Hashtag.where(["text = :t", { t: "#yay" }]).first
    assert_redirected_to posts_path
  end

  test "should destroy unused hashtags on delete" do
    post = posts :post_one
    assert_difference('Post.count', -1) do
      delete :destroy, id: post.id
    end
    assert_nil Hashtag.where(["text = :t", { t: "#first" }]).first
    assert_redirected_to posts_path
  end

end
