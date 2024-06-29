get "/read" do
    book_id = params["id"]
    @book = Book.first(id: book_id)
    redirect "/" if false
    chapter = (params["chapter"].nil?) ? 1 : params["chapter"] 
    @current_chapter = @book.get_chapter(chapter)
    @user = User.first(id: session["user_id"])
    erb :read
end

post "/read" do
    poll_id = params["poll_id"]
    choice = params["choice"]
    poll = Poll.first(id: poll_id)
    poll.increment_value(choice)
    poll.save
    redirect back
end

post "/purchase-book" do
    book = Book.first(id: params["book_id"])
    user = User.first(id: session["user_id"])
    @error = nil
    if user.owns_book(book)
        @error = "You already own this book."
        redirect back
    end
    if user.popcorn < book.cost
        @error = "You cannot afford to buy this book."
        redirect back
    else 
        # give the author 70% of the book cost & remove cost from user
        user.popcorn -= book.cost
        author = book.get_author
        author.popcorn += (book.cost * 0.7).floor()
        author.save
        # add the purchase to the table
        purchase = Purchase.new
        now = DateTime.now()
        purchase.date = now.strftime("%d/%m/%Y:%H:%M")
        purchase.type = 'b'
        purchase.cost = book.cost
        purchase.customer = user.id
        purchase.product = book.id
        purchase.save
        user.save
    end
    redirect back
end 

post "/delete" do
    if params["delete"] == "no" then 
        redirect back
    elsif params["delete"] == "yes" then
        book_id = params["id"]    
        puts book_id

        book = Book.first(id: book_id)
    
        ch = (params["chapter"].nil?) ? 1 : params["chapter"] 
        chapter = book.get_chapter(ch)

        puts "chapter: #{chapter.ch_number}"

        chapter.delete
        
        redirect "/"
    end 
end

get "/flag" do
    if params["flag"] == "no" then 
        redirect back
    elsif params["flag"] == "yes" then 
        book_id = params["id"]    
        puts book_id

        book = Book.first(id: book_id)

        book.flagged = 1
        book.save
        erb :report
    end
end