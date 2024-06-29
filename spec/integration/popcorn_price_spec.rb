RSpec.describe "Changing the price of popcorn" do
    context "given the user is logged in as a staff member" do
        context "when the user edits the price on the staff dashboard with a valid value" do
            it "updates the price of popcorn" do
                #logging in
                visit "/login"
                fill_in "username", with: "staff"
                fill_in "password", with: "staff"
                find(id: 'submit').click

                #going to staff dashboard
                visit "/staff-dashboard"

                fill_in "change_popcorn_price", with: "2"
                find(id: "confirm_popcorn_price").click
                
                # compare to db
                default_values = Default_Values.last

                #checking if the edit icon has redirected to edit page
                expect(default_values.popcorn_to_pounds).to eql(2.0)
            end
        end
        context "when the user edits the price on the staff dashboard with a string value" do
            it "does not update the price of popcorn" do
                #logging in
                visit "/login"
                fill_in "username", with: "staff"
                fill_in "password", with: "staff"
                find(id: 'submit').click

                #going to staff dashboard
                visit "/staff-dashboard"

                fill_in "change_popcorn_price", with: "incorrect value"
                find(id: "confirm_popcorn_price").click
                
                expect(page).to have_content "Popcorn to pounds must be a number"
            end
        end
        context "when the user edits the price on the staff dashboard with an empty value" do
            it "does not update the price of popcorn" do
                #logging in
                visit "/login"
                fill_in "username", with: "staff"
                fill_in "password", with: "staff"
                find(id: 'submit').click

                #going to staff dashboard
                visit "/staff-dashboard"

                fill_in "change_popcorn_price", with: ""
                find(id: "confirm_popcorn_price").click
                
                expect(page).to have_content "Popcorn to pounds can't be empty"
            end
        end
        context "when the user edits the price on the staff dashboard with a value too small" do
            it "does not update the price of popcorn" do
                #logging in
                visit "/login"
                fill_in "username", with: "staff"
                fill_in "password", with: "staff"
                find(id: 'submit').click

                #going to staff dashboard
                visit "/staff-dashboard"

                fill_in "change_popcorn_price", with: "0.001"
                find(id: "confirm_popcorn_price").click
                
                expect(page).to have_content "Popcorn to pounds must be greater than 0.01"
            end
        end
    end
end