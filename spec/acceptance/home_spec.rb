RSpec.describe "Username visible on home page" do
    context "given a user logs into their account" do
        context "when they visit the home page" do
            it "the user can see the username in session" do
                #logging in
                visit "/login"
                fill_in "username", with: "reader"
                fill_in "password", with: "reader"
                find(id: 'submit').click

                #opening home page
                visit "/home"

                #checking if page displays username in session
                expect(page).to have_content "@reader"
            end
        end
    end
end
