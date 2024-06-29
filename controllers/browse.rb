get "/" do
    redirect "/login" unless session["logged_in"]
    @user = User.first(id: session["user_id"])
    @books = Book.all
    @link = request.url
    erb :index
end

post "/" do
    book_id = params["book_id"]
    share = params["share"]
    like = params["like"]
    bookmark = params["bookmark"]
    puts like
    puts share
    puts bookmark
    if (!share.nil?)
        book = Book.first(id: book_id)
        book.shares = book.shares + 1
        book.save
    elsif (!like.nil?)
        book = Book.first(id: book_id)
        if Like.first(user: session["user_id"], book: book.id).nil?
            book.likes = book.likes + 1
            book.save
            like = Like.new
            like.user = session["user_id"]
            like.book = book.id
            like.save
        end
    elsif (!bookmark.nil?)
        book = Book.first(id: book_id)
        if Bookmark.first(user: session["user_id"], book: book.id).nil?
            book.bookmarks = book.bookmarks + 1
            book.save
            bookmark = Bookmark.new
            bookmark.user = session["user_id"]
            bookmark.book = book.id
            bookmark.save
        end
    end
    redirect back
end

get "/search" do
    redirect "/login" unless session["logged_in"]
    search_query = "%#{params[:search]}%" 
    @books = Book.join(:users, id: :author) 
                 .where(Sequel.ilike(Sequel[:books][:name], search_query) |
                        Sequel.ilike(Sequel[:books][:genre], search_query) |
                        Sequel.ilike(Sequel[:users][:username], search_query))
                 .select_all(:books)
    @user = User.first(id: session["user_id"])
    @link = request.url
    erb :index
end

get "/likes" do
    likes = Like.where(user: session["user_id"])
    @user = User.first(id: session["user_id"])
    @link = request.url
    @books = []
    likes.each do |like|
        @books << Book.first(id: like.book)
    end
    erb :index
end

get "/bookmarks" do
    bookmarks = Bookmark.where(user: session["user_id"])
    @user = User.first(id: session["user_id"])
    @link = request.url
    @books = []
    bookmarks.each do |bookmark|
        @books << Book.first(id: bookmark.book)
    end
    erb :index
end