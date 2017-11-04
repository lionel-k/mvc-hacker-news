require_relative '../models/post'

class PostsController
  def initialize
    @view = PostsView.new
  end

  def index
    # Listing all posts
    posts = Post.all
    @view.display_posts(posts)
  end

  def create
    # Creating a new post
    title = @view.ask_for("title")
    url = @view.ask_for("url")
    post = Post.new
    post.title = title
    post.url = url
    post.save
    @view.show_message("New Post created!!")
  end

  def update
    index
    post_id = @view.ask_for("id")
    post = Post.find(post_id.to_i)
    post.nil? ? update : update_post(post)
  end

  def destroy
    index
    post_id = @view.ask_for("id")
    post = Post.find(post_id.to_i)
    post.nil? ? destroy : destroy_post(post)
  end

  def upvote
    index
    post_id = @view.ask_for("id")
    post = Post.find(post_id.to_i)
    post.nil? ? upvote : upvote_post(post)
  end

  private

  def update_post(post)
    title = @view.ask_for("new title")
    url = @view.ask_for("new url")
    post.title = title
    post.url = url
    post.save
    @view.show_message("Post ID #{post.id} updated!!")
  end

  def destroy_post(post)
    post.destroy
    @view.show_message("Post ID #{post.id} destroyed!!")
  end

  def upvote_post(post)
    post.upvote!
    post.save
    @view.show_message("Post ID #{post.id} upvoted!!")
  end
end
