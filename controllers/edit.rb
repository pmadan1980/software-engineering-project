get "/edit" do
    book_id = params["id"]
    @book = Book.first(id: book_id)
    redirect "/read" if false
    chapter = (params["chapter"].nil?) ? 1 : params["chapter"] 
    @current_chapter = @book.get_chapter(chapter)
    @polls = @current_chapter.get_polls()
    erb :edit
end

post "/edit" do
    title = params["title"]
    content = params["content"]
    book_name = params["book-name"]
    genre = params["genre"]


    book_id = params["id"]
    puts book_id

    book = Book.first(id: book_id)
    puts book

    ch = (params["chapter"].nil?) ? 1 : params["chapter"] 
     
    chapter = book.get_chapter(ch)

    book.update_last_updated
    book.save

    chapter.title = title
    chapter.content = content
    chapter.book = book.id

    # Save the chapter
    chapter.save

    # Redirect back to the write page
    redirect back
end
