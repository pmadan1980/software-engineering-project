get "/settings" do
    @user = User.first(id: session["user_id"])
    erb :settings
end

post "/settings" do
   name = params[:name]
   email = params[:email]
   about_me = params[:about_me]
   mode = params[:mode]
   user = User.first(id: session["user_id"])
   if !name.nil? && (@error = user.valid_username(name)).nil? then
        user.name = name
   end
   if !email.nil?  && (@error = user.valid_email(email)).nil? then
        user.email = email
   end
   if !about_me.nil? && (@error = user.valid_about_me(about_me)).nil? then
        user.about_me = about_me
   end
   if !mode.nil? && !user.is_test_account then
        user.mode = (mode == "on") ? 'w' : 'r'
   end
   user.save
   redirect back
end


