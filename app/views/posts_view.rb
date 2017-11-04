class PostsView
  def display_posts(posts)
    puts ""
    puts "All Posts"
    posts.each do |post|
      puts "Post ID: #{post.id} - #{post.title} - #{post.url} - Votes: #{post.votes}"
    end
    puts ""
  end

  def ask_for(item)
    puts "What is the #{item} of the post:"
    print "> "
    gets.chomp
  end

  def show_message(message)
    puts "\n#{message}\n"
  end
end
