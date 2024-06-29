RSpec.describe "Changing settings on an existing account" do
    context "given a user is logged in" do
        context "given they want to change their name using a valid format" do
            it "will successfully change" do
                #logging in
                visit "/login"
                fill_in "username", with: "test"
                fill_in "password", with: "test"
                find(id: 'submit').click

                #go to settings page
                visit "/settings"
                fill_in "name-value", with: "Test-name"
                find(id: 'submit').click

                #compare to db
                user = User.first(username: "test")

                expect(user.name).to eql("Test-name")
            end
        end
        context "given they want to change their name to an empty input" do
            it "will not successfully change" do
                #logging in
                visit "/login"
                fill_in "username", with: "test"
                fill_in "password", with: "test"
                find(id: 'submit').click

                #go to settings page
                visit "/settings"
                fill_in "name-value", with: ""
                find(id: 'submit').click

                #compare to db
                user = User.first(username: "test")

                expect(user.name).to_not eql("")
            end
        end
        context "given they want to change their name to something too long" do
            it "will not successfully change" do
                #logging in
                visit "/login"
                fill_in "username", with: "test"
                fill_in "password", with: "test"
                find(id: 'submit').click

                #go to settings page
                visit "/settings"
                fill_in "name-value", with: "123456789101112"
                find(id: 'submit').click

                #compare to db
                user = User.first(username: "test")

                expect(user.name).to_not eql("123456789101112")
            end
        end
        context "given they want to change their email to an empty input" do
            it "will not successfully change" do
                #logging in
                visit "/login"
                fill_in "username", with: "test"
                fill_in "password", with: "test"
                find(id: 'submit').click

                #go to settings page
                visit "/settings"
                fill_in "email-value", with: ""
                find(id: 'submit').click

                #compare to db
                user = User.first(username: "test")

                expect(user.email).to_not eql("")
            end
        end
        context "given they want to change their email to something too long" do
            it "will not successfully change" do
                #logging in
                visit "/login"
                fill_in "username", with: "test"
                fill_in "password", with: "test"
                find(id: 'submit').click

                #go to settings page
                visit "/settings"
                fill_in "email-value", with: "1234567891011121314151617181920212223242526272829303132333435363738394041424344454647484950515253545556575859606162636465"
                find(id: 'submit').click

                #compare to db
                user = User.first(username: "test")

                expect(user.email).to_not eql("1234567891011121314151617181920212223242526272829303132333435363738394041424344454647484950515253545556575859606162636465")
            end
        end
        context "given they want to change their about me to something too long" do
            it "will not successfully change" do
                #logging in
                visit "/login"
                fill_in "username", with: "test"
                fill_in "password", with: "test"
                find(id: 'submit').click

                #go to settings page
                visit "/settings"
                fill_in "about_me", with: "123456789101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899100101102103104105106107108109110111112113114115116117118119120121122123124125126127128129"
                find(id: 'submit').click

                #compare to db
                user = User.first(username: "test")

                expect(user.about_me).to_not eql("123456789101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899100101102103104105106107108109110111112113114115116117118119120121122123124125126127128129")
            end
        end
    end
end