post "/report" do
    puts params
    book_id = params["id"]
    puts book_id

    reason = params["reason"]

    report = Report.new
    report.reason = reason
    report.user = session["user_id"]
    report.book = book_id

    report.save
    redirect "/"
end