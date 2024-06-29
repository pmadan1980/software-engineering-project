RSpec.describe "Getting elapsed time from between two dates" do
    now = DateTime.parse("1st May 2024 17:45:00")
    context "given a book is being updated" do
        context "given the time is in format dd/mm/yyyy:HH:MM" do
            it "the difference is a year" do
                book = Book.first(id: 1)
                expect(book.get_last_updated(now)).to eql("1 year ago")
            end
            it "the difference is a month" do
                book = Book.first(id: 2)
                expect(book.get_last_updated(now)).to eql("1 month ago")
            end
            it "the difference is a week" do
                book = Book.first(id: 3)
                expect(book.get_last_updated(now)).to eql("1 week ago")
            end
            it "the difference is a day" do
                book = Book.first(id: 4)
                expect(book.get_last_updated(now)).to eql("1 day ago")
            end
            it "the difference is 2 hours" do
                book = Book.first(id: 6)
                expect(book.get_last_updated(now)).to eql("2 hours ago")
            end
            it "the difference is one minute" do
                book = Book.first(id: 5)
                expect(book.get_last_updated(now)).to eql("1 minute ago")
            end
        end
    end
end
