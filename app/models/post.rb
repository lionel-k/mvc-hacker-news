class Post
  attr_accessor :title, :url
  attr_reader :id, :votes

  def initialize(attributes = {})
    @id = attributes[:id]
    @title = attributes[:title]
    @url = attributes[:url]
    @votes = attributes[:votes] || 0
  end

  def self.find(post_id)
    DB.results_as_hash = true
    results = DB.execute("select * from posts where id = ?", post_id)
    results.empty? ? nil : load_post(results.first)
  end

  def self.all
    DB.results_as_hash = true
    results = DB.execute("select * from posts")
    results.size.zero? ? [] : load_all_posts(results)
  end

  def destroy
    # Destroy the current instance from the database
    DB.execute("delete from posts where id = ?", @id)
  end

  def save
    @id.nil? ? create : update
  end

  def upvote!
    @votes += 1
  end

  def self.load_post(results)
    post_id = results["id"]
    title = results["title"]
    url = results["url"]
    votes = results["votes"]
    Post.new(id: post_id, title: title, url: url, votes: votes)
  end

  def self.load_all_posts(results)
    results.map { |result| load_post(result) }
  end

  def create
    DB.execute("INSERT INTO posts (title, url, votes) VALUES (?, ?, ?)", @title, @url, @votes)
    @id = DB.last_insert_row_id
  end

  def update
    DB.execute("UPDATE posts set title = ?, url = ?, votes = ? where id = ?", @title, @url, @votes, @id)
    Post.new(id: id, url: url, votes: votes, title: title)
  end
end
