RSpec.describe "Checking the number of users" do
    context "given the user is logged in as a staff member" do
        context "viewing the number of users" do
            it "will match accurately to the count in the database" do
                #logging in
                visit "/login"
                fill_in "username", with: "staff"
                fill_in "password", with: "staff"
                find(id: 'submit').click

                #going to staff dashboard
                visit "/staff-dashboard"

                total_users = find(id: "user-count").text
                
                # compare to db
                real_count = DB[:users].count

                #checking if the edit icon has redirected to edit page
                expect(total_users.to_i).to eql(real_count)
            end
        end
        context "viewing the number of premium users" do
            it "will match accurately to the count in the database" do
                #logging in
                visit "/login"
                fill_in "username", with: "staff"
                fill_in "password", with: "staff"
                find(id: 'submit').click

                #going to staff dashboard
                visit "/staff-dashboard"

                total_users = find(id: "total-premium").text
                
                # compare to db
                real_count = User.where(premium: 1).count

                #checking if the edit icon has redirected to edit page
                expect(total_users.to_i).to eql(real_count)
            end
        end
        context "viewing the popcorn price" do
            it "will match accurately to the value in the database" do
                #logging in
                visit "/login"
                fill_in "username", with: "staff"
                fill_in "password", with: "staff"
                find(id: 'submit').click

                #going to staff dashboard
                visit "/staff-dashboard"

                price_on_page = find(id: 'popcorn-value').text

                #compare to db
                popcorn_price = Default_Values.last.popcorn_to_pounds

                #checking if the edit icon has redirected to edit page
                expect(price_on_page.to_f).to eql(popcorn_price)
            end
        end
    end
end
