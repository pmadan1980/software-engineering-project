RSpec.describe "Content enterred on write page visible on browse page" do
    context "given a user logs into their account" do
        context "when they enter content into the write page" do
            it "the user can see the name of the book in the browse page" do
                #logging in
                visit "/login"
                fill_in "username", with: "writer"
                fill_in "password", with: "writer"
                find(id: 'submit').click

                #enterring data in write page
                visit "/write"

                select 'Other (Enter Your Own)', from: 'book-name'

                fill_in "custom-book", with: "Book 1", visible: false
                fill_in "title", with: "Title 1"
                fill_in "box", with: "Text"
                find(id: 'button').click

                #opening browse page
                visit "/"
            
                #checking if page displays Book Name enterred
                expect(page).to have_content "Book 1"                
            end
        end
    end
end

RSpec.describe "Content enterred on write page visible on read page" do
    context "given a user logs into their account" do
        context "when they enter content into the write page" do
            it "the user can see the enterred content in the read page" do
                #logging in
                visit "/login"
                fill_in "username", with: "writer"
                fill_in "password", with: "writer"
                find(id: 'submit').click

                #enterring data in write page
                visit "/write"

                select 'Other (Enter Your Own)', from: 'book-name'
                fill_in "custom-book", with: "Book 2", visible: false
                fill_in "title", with: "Title 1"
                fill_in "box", with: "Text"
                find(id: 'button').click

                #opening home page
                visit "/home"

                #going to read page for Book 2
                click_on "Book 2"

                #checking if page displays Book Name enterred
                expect(page).to have_content "Title 1"
            end
        end
    end
end

RSpec.describe "Book enterred on write page visible in dropdown when enterring a new book" do
    context "given a user is logged into their account" do
        context "when they enter content into the write page" do
            it "the user can see the book in the dropdown in the write page" do
                #logging in
                visit "/login"
                fill_in "username", with: "writer"
                fill_in "password", with: "writer"
                find(id: 'submit').click

                #enterring data in write page
                visit "/write"

                select 'Other (Enter Your Own)', from: 'book-name'
                fill_in "custom-book", with: "Book 7", visible: false
                fill_in "title", with: "Title 1"
                fill_in "box", with: "Text"
                find(id: 'button').click

                #visiting write page
                visit "/write"

                #selecting book added from dropdown
                select 'Book 7', from: 'book-name'

                #checking if dropdown displays added Book Name
                expect(page).to have_select 'book-name',
                selected: 'Book 7'            
            end
        end
    end
end