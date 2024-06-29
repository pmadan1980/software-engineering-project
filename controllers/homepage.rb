get "/home" do
    @books = Book.all
    @purchases = Purchase.all

    @authors = [] 
    @author_link = []

    @books.each do |book| 
        if (!book.get_author.nil?) then
            author = book.get_author
            @authors.append(author)
        end
    end

    @authors = @authors.uniq
    
    redirect '/login' unless session["logged_in"]

    @user = User.first(id: session["user_id"])

    if @user.is_writer then
        erb :writer_home
    else
        erb :reader_home
    end
end

get "/view" do
    target_username = params["username"]
    @user = User.first(username: target_username)
    @books = Book.all
    @purchases = Purchase.all
    erb :writer_home
end