RSpec.describe "Logging in after resetting password" do
    context "given a user has reset their password" do
        context "when they are trying to log in again" do
            it "allows them to login with new password" do
                #signing up
                visit "/sign-up"
                fill_in "email", with: "sanyaaneja10@gmail.com"
                fill_in "username", with: "test123"
                fill_in "password", with: "test123"
                find(id: 'submit').click

                #resetting password
                visit "/reset-password"
                fill_in "email", with: "sanyaaneja10@gmail.com"
                fill_in "password", with: "test2351"
                click_on "Reset password"

                #logging in
                visit "/login"
                fill_in "username", with: "test123"
                fill_in "password", with: "test2351"
                find(id: 'submit').click

                expect(page.current_path).to eql('/')
            end
        end
    end
end
