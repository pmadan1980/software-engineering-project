RSpec.describe "Signing up after having signed up earlier" do
    context "given a user has signed up" do
        context "when they are trying to sign up again" do
            it "alerts the user they have already signed up" do
                #signing up
                visit "/sign-up"
                fill_in "email", with: "sanyaaneja10@gmail.com"
                fill_in "username", with: "test123"
                fill_in "password", with: "test123"
                find(id: 'submit').click

                #signing up again
                visit "/sign-up"
                fill_in "email", with: "sanyaaneja10@gmail.com"
                fill_in "username", with: "test123"
                fill_in "password", with: "test123"
                find(id: 'submit').click
                
                #check the user is alerted
                expect(page).to have_content "User already exists with that email"
            end
        end
    end
end