get "/" do
    redirect "/login" unless session["logged_in"]
    erb :index
end

get "/login" do
    redirect "/" if session["logged_in"]
    erb :login
end

post "/login" do 
    username = params.fetch("username", "").strip
    password = params.fetch("password", "").strip
    if !params.empty?

        user = User.first(username: username)
        if not user.nil? then
            @error = user.valid_username(password)
            if @error.nil? then
                @error = user.valid_password(password)
                if @error.nil? then
                    if user.login(password)
                        session["user_id"] = user.id
                        session["logged_in"] = true
                        redirect "/"
                    else
                        @error = "Incorrect password"
                    end
                end
            end
        else
            @error = "Incorrect username"
        end
    end
    erb :login
end

get "/logout" do
    session.clear
    erb :login
end

get "/reset-password" do
    erb :reset_password
end

post "/reset-password" do
    # make it so it autofills with the user data if they are logged in
    email = params.fetch("email", "").strip
    new_password = params.fetch("password", "").strip
    if !params.empty?
        user = User.first(email: email)
        if not user.nil? then
            @error = user.reset_password(new_password)
            # successful password reset
            if @error.nil? then
                @error = "Successful password reset"
                user.save
                erb :login
            end
        else
            @error = "There is no account linked to that email address"
        end
    end
end