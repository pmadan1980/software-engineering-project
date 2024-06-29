RSpec.describe "Logging in without an existing account" do
    context "given a user does not have an account" do
        context "when they are trying to login" do
            it "alerts the user they have to sign up" do
                #logging in
                visit "/login"
                fill_in "username", with: "user"
                fill_in "password", with: "password"
                find(id: 'submit').click

                expect(page).to have_content "Incorrect username"
            end
        end
    end
end

RSpec.describe "Logging in with an incorrect username" do
    context "given a user does not have an account" do
        context "when they are trying to login" do
            it "alerts the user the username is incorrect" do
                #logging in with incorrect username
                visit "/login"
                fill_in "username", with: "wrong_username"
                fill_in "password", with: "password"
                find(id: 'submit').click

                expect(page).to have_content "Incorrect username"
            end
        end
    end
end