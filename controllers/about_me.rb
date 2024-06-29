get "/about-me" do
    redirect "/login" if !session["logged_in"]
    erb :about_me
end

post "/about-me" do
    user = User.first(id: session["user_id"])
    name = params["name"]
    about_me = params["about_me"]
    @error = user.valid_username(name)
    if @error.nil? then
        @error = user.valid_about_me(about_me)
        if @error.nil? then
            user.name = name
            user.about_me = about_me
            user.save
            redirect "/home"
        end
    end
    erb :about_me
end
