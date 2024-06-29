RSpec.describe "Switching from reader to writer mode" do
    context "given a user is logged into a reader account" do
        context "when they click the switch on the home page" do
            it "they can access the write page" do
                #logging in
                visit "/login"
                fill_in "username", with: "staff"
                fill_in "password", with: "staff"
                find(id: 'submit').click

                #opening home page
                visit "/home"
                
                #clicking switch button
                find(id: 'reader-toggle').click 

                #trying to access write page
                visit "/write"

                #checking if page can now access write page
                expect(page.current_path).to eql('/write')
            end
        end
    end
end