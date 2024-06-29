get "/staff-dashboard" do
    user = User.first(id: session["user_id"])
    redirect "/" unless (session["logged_in"] && user.is_staff)
    @error = session[:error] if session[:error]
    @values = Default_Values.last
    @users = User
    @user_count = 0
    @premium_user_count = 0
    @users.each do |user|
        if user.premium == 1
            @premium_user_count += 1
            @user_count += 1
        else
            @user_count += 1
        end
    end

    @flagged_books = []

    @books = Book.all

    @books.each do |book|
        if book.flagged == 1 
            @flagged_books.append(book)
        end
    end

    @reports = Report.all

    @purchases = Purchase
    erb :staff_dashboard
end

post "/staff-dashboard" do
    price = params.fetch("change_popcorn_price", "").strip
    if !params.empty?
        new_values = Default_Values.new
        @error = new_values.validate_popcorn_to_pounds(price)
        if @error.nil? then
            @current_values = Default_Values.last
            new_values.popcorn_to_pounds = price.to_f.truncate(2)
            new_values.id = @current_values.id + 1
            new_values.premium_price = @current_values.premium_price
            new_values.save_changes
            
        end
        session[:error] = @error
        redirect "/staff-dashboard"
        erb :staff_dashboard
    end
end