get "/profile" do
    @books = Book.all
    @user = User.first
    
    erb :writer_profile
end