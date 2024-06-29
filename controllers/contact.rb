get "/contact" do
    erb :contact_us
end

post "/contact" do
    @name = params["name"]
    @email = params["email"]
    @comments = params["comments"]

end