# Assuming your User, Book, Chapter, Poll, Question, and Option models are defined appropriately

# Route to display the write page
get "/write" do
  user = User.first(id: session["user_id"])
  if !user.nil? && user.is_writer then 
      @books = Book.where(author: session["user_id"])
      erb :writerview
  else
      redirect "/"
  end
end

# Route to handle form submission for writing a new chapter
post "/write" do
  title = params["title"]
  content = params["content"]
  book_name = params["book-name"]
  custom_book = params["custom-book"]
  genre = params["genre"]
  langauge = params["langauge"]

  book = Book.first(name: book_name, author: session["user_id"])

  if book.nil?    #creates book if book doesn't exist
    book = Book.new
    book.name = custom_book
    book.genre = genre
    book.author = session["user_id"]
    book.flagged = 0
    book.cost = params["cost"]
  end
    
  book.update_last_updated
  book.save

  chapter = Chapter.new   # Creates new chapter
  chapter.title = title
  chapter.content = content
  chapter.book = book.id

  ch_count = book.get_chapter_count
  chapter.ch_number = ch_count + 1

  # Save the chapter
  chapter.save

  question = params["question-0"]
  options = params["option-0"]
  # Add questions and options to the chapter's poll
  if !question.nil? && !options.nil?
      poll = Poll.new   # Create a new poll
      poll.question = question

      poll.set_count

      (0..options.length).each do |i|
        case i
        when 0
            poll.option1 = options[i]
        when 1
            poll.option2 = options[i]
        when 2
            poll.option3 = options[i]
        when 3
            poll.option4 = options[i]
        when 4
            poll.option5 = options[i]
        else
            break
        end
        poll.chapter = chapter.id
        poll.save
      end
  end

  # Redirect back to the write page
  redirect "/write"
end
