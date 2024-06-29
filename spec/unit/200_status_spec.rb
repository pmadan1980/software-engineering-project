RSpec.describe "Login Page" do
  describe "GET /login" do
    it "has a status code of 200 (OK)" do
      get "/login"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Sign Up Page" do
  describe "GET /sign-up" do
    it "has a status code of 200 (OK)" do
      get "/sign-up"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Reset Password Page" do
  describe "GET /reset-password" do
    it "has a status code of 200 (OK)" do
      get "/reset-password"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Writer Page" do
  describe "GET /write" do
    it "has a status code of 200 (OK)" do
      get "/write"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Home Page" do
  describe "GET /home" do
    it "has a status code of 200 (OK)" do
      get "/home"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Staff Dashboard Page" do
  describe "GET /staff-dashboard" do
    it "has a status code of 200 (OK)" do
      get "/staff-dashboard"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Contact Us Page" do
  describe "GET /contact" do
    it "has a status code of 200 (OK)" do
      get "/contact"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Report Stories Page" do
  describe "GET /flag" do
    it "has a status code of 200 (OK)" do
      get "/flag"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Settings Page" do
  describe "GET /settings" do
    it "has a status code of 200 (OK)" do
      get "/settings"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "About Me Page" do
  describe "GET /about-me" do
    it "has a status code of 200 (OK)" do
      get "/about-me"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Read Page" do
  describe "GET /read?id=1" do
    it "has a status code of 200 (OK)" do
      get "/read?id=1"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Browse Page" do
  describe "GET /" do
    it "has a status code of 200 (OK)" do
      get "/"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Purchase Page" do
  describe "GET /purchase" do
    it "has a status code of 200 (OK)" do
      get "/purchase"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Confirm Purchase Page" do
  describe "GET /confirm" do
    it "has a status code of 200 (OK)" do
      get "/confirm"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Bookmarks Page" do
  describe "GET /bookmarks" do
    it "has a status code of 200 (OK)" do
      get "/bookmarks"
      expect(last_response.status).to eq(200)
    end
  end
end

RSpec.describe "Saves Page" do
  describe "GET /saves" do
    it "has a status code of 200 (OK)" do
      get "/saves"
      expect(last_response.status).to eq(200)
    end
  end
end
