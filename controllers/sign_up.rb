get "/sign-up" do
    redirect "/" if session["logged_in"]
    erb :sign_up
end

post "/sign-up" do
    username = params.fetch("username", "").strip
    password = params.fetch("password", "").strip
    email = params.fetch("email", "").strip

    if !params.empty?
        user = User.new
        @error = user.valid_username(username)
        if @error.nil? then
            @error = user.valid_password(password)
            if @error.nil? then
                @error = user.valid_email(email)
                if @error.nil? then
                    @error = user.signup(username, password, email)
                    if @error.nil? then
                        user.save
                        session["user_id"] = user.id
                        session["logged_in"] = true
                        redirect "/about-me"
                    end
                end
            end
        end
    end
    erb :sign_up
end