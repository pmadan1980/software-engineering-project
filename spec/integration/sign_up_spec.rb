RSpec.describe "Signing up to create a new account" do
    context "given a user has not signed up" do
        context "when they are trying to sign up" do
            it "adds the username to the database" do
                #signing up
                visit "/sign-up"
                fill_in "email", with: "test@gmail.com"
                fill_in "username", with: "test1234569"
                fill_in "password", with: "test12334345"
                find(id: 'submit').click

                #check the db
                user = User.first(username: "test1234569")
                
                expect(user).not_to eql(nil)
                expect(user.username).to eql("test1234569")
            end
            it "adds the email to the database" do
                #signing up
                visit "/sign-up"
                fill_in "email", with: "test@gmail.com"
                fill_in "username", with: "test1234569"
                fill_in "password", with: "test12334345"
                find(id: 'submit').click

                #check the db
                user = User.first(username: "test1234569")
                
                expect(user).not_to eql(nil)
                expect(user.email).to eql("test@gmail.com")
            end
            it "adds the password to the database" do
                #signing up
                visit "/sign-up"
                fill_in "email", with: "test@gmail.com"
                fill_in "username", with: "test1234569"
                fill_in "password", with: "test12334345"
                find(id: 'submit').click

                #check the db
                user = User.first(username: "test1234569")
                
                expect(user).not_to eql(nil)
                expect(user.login("test12334345")).not_to eql(nil)
            end
        end
    end
end