require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "posts index" do
    get :index
    assert_template "posts/index"
    assert_select 'div.post', 2
  end

  test "get new post" do
    get :new
    assert_template 'posts/new'
    assert_select 'form[action=?]', posts_path
    assert_select 'input[type=submit]', value: "Add"
  end

  test "post new post" do
    assert_difference 'Post.count', 1 do
      post :create, post: {title: "new title", content: "new content"}
    end
    assert_redirected_to posts_url
  end

  test "invalid new post" do
    assert_no_difference 'Post.count' do
      post :create, post: {title: " ", content: "new content"}
    end
    post = assigns(:post)
    assert_not post.valid?
  end

  test "ajax post new" do
    assert_difference "Post.count", 1 do
      xhr :post, :create, post: {title: "new titleqqq", content: "new contentss"}
    end
    # assert_select '.result p', text: "Post added"
  end

  test "edit post" do
    first_post = posts(:first)
    title = "www"
    content = "ccc"
    patch :update, id: first_post, post: {title: title, content: content }
    first_post.reload
    assert_equal first_post.title, title
    assert_equal first_post.content, content
  end

  test "delete post" do
    first_post = posts(:first)
    assert_difference "Post.count", -1 do
      delete :destroy, id: first_post
    end
    assert_redirected_to posts_url
  end
end
