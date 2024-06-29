RSpec.describe "Redirecting to /edit page" do
    context "given the story has a chapter and the user is logged in" do
        context "when the user clicks on the edit icon" do
            it "redirects to edit page" do
                #logging in
                visit "/login"
                fill_in "username", with: "writer"
                fill_in "password", with: "writer"
                find(id: 'submit').click

                #enterring data in write page
                visit "/write"

                select 'Other (Enter Your Own)', from: 'book-name'
                fill_in "custom-book", with: "Book 3", visible: false
                fill_in "title", with: "Title 1"
                fill_in "box", with: "Text"
                find(id: 'button').click
                
                #going to home page 
                visit "/home"

                #visiting read page for book just added 
                click_on "Book 3"

                #clicking on edit icon
                click_on "Edit"

                #checking if the edit icon has redirected to edit page
                expect(page.current_path).to eql('/edit')

                #deleting newly added files afterwards
                visit "/home"

                click_on "Book 3"

                find(id: 'newForm').click_on "Yes"                
            end
        end
    end
end

RSpec.describe "Changing content in the edit changes it in the read page" do
    context "given the story has a chapter and the user is logged in" do
        context "when the user edits a chapter in the edit page" do
            it "updates in the read page as well" do
                #logging in
                visit "/login"
                fill_in "username", with: "writer"
                fill_in "password", with: "writer"
                find(id: 'submit').click

                #going to home page 
                visit "/home"

                #enterring data in write page
                visit "/write"

                select 'Other (Enter Your Own)', from: 'book-name'
                fill_in "custom-book", with: "Book 4", visible: false
                fill_in "title", with: "Title 1"
                fill_in "box", with: "Text"
                find(id: 'button').click

                #visiting home page
                visit "/home"

                #visiting 
                click_on "Book 4"

                click_on "Edit"

                fill_in "title", with: "!!!"
                find(id: 'button').click

                visit "/home"
                
                click_on "Book 4"
                
                expect(page).to have_content "!!!"
            end
        end
    end
end

RSpec.describe "Selecting yes in the delete icon pop up will delete the chapter" do
    context "given the story has a chapter and the user is logged in" do
        context "when the user clicks on the delete icon and selects yes" do
            it "deletes the chapter from the story" do
                #logging in
                visit "/login"
                fill_in "username", with: "writer"
                fill_in "password", with: "writer"
                find(id: 'submit').click

                #going to home page 
                visit "/home"

                #enterring data in write page
                visit "/write"

                select 'Other (Enter Your Own)', from: 'book-name'
                fill_in "custom-book", with: "Book 5", visible: false
                fill_in "title", with: "Title 1"
                fill_in "box", with: "Text"
                find(id: 'button').click

                visit "/home"

                click_on "Book 5"

                find(id: 'myForm').click_on "Yes"

                visit "/home"

                click_on "Book 5"
                
                expect(page).to have_content("Nothing to see here...")
            end
        end
    end
end

RSpec.describe "Selecting yes in the flag icon pop up will make the book no longer visible" do
    context "given the story has a chapter and the user is logged in" do
        context "when the user clicks on the flag icon and selects yes" do
            it "removes the book from the browse " do
                #logging in
                visit "/login"
                fill_in "username", with: "writer"
                fill_in "password", with: "writer"
                find(id: 'submit').click

                #going to home page 
                visit "/home"

                #enterring data in write page
                visit "/write"

                select 'Other (Enter Your Own)', from: 'book-name'
                fill_in "custom-book", with: "Book 6", visible: false
                fill_in "title", with: "Title 1"
                fill_in "box", with: "Text"
                find(id: 'button').click

                visit "/home"

                click_on "Book 6" 

                find(id: 'newForm').click_on "Yes"

                visit "/"
                
                expect(page).not_to have_content("Book 6")
            end
        end
    end
end

RSpec.describe "Comments enterred in the '/flag' page form show on staff dashboard" do
    context "given the user clicks on the flag icon and selects yes" do
        context "when the user is redirected to a form" do
            it "appears in the staff dashboard " do
                #logging in
                visit "/login"
                fill_in "username", with: "writer"
                fill_in "password", with: "writer"
                find(id: 'submit').click

                #going to home page 
                visit "/home"

                #enterring data in write page
                visit "/write"

                select 'Other (Enter Your Own)', from: 'book-name'
                fill_in "custom-book", with: "Book 8", visible: false
                fill_in "title", with: "Title 1"
                fill_in "box", with: "Text"
                find(id: 'button').click

                visit "/home"

                click_on "Book 8" 

                find(id: 'newForm').click_on "Yes"

                fill_in "reason", with: "this content was not appropriate"
                find(id: 'submit').click

                
            end
        end
    end
end