class User < Sequel::Model
    READER = "reader"
    WRITER = "writer"

    def signup(username, password, email)            
        # check if user with the same email/username exists
        if User.first(email: email).nil? then
            if User.first(username: username).nil? then

                self.username = username
                self.email = email   
                self.set_defaults()             
                self.iv, self.salt, self.password = self.encrypt(password)
            else
                return "User already exists with that username"
            end
        else
            return "User already exists with that email"
        end
        nil
    end

    def valid_username(username)
        return "Username cannot be empty" if username.empty?
        return "Username can only be maximum 12 characters" if username.length > 12
        nil
    end
    
    def valid_password(password)
        return "Password cannot be empty" if password.empty?
        return "Password can only be maximum 28 characters" if password.length > 28
        nil
    end

    def valid_email(email)
        return "Email cannot be empty" if email.empty? 
        return "Email can only be maximum 64 characters" if email.length > 64
        nil
    end

    def valid_about_me(about_me)
        return "About me can only be maximum 128 characters" if about_me.length > 128
        nil
    end

    def login(password)
        aes = OpenSSL::Cipher::AES.new(128, :CBC).decrypt

        aes.iv = iv

        aes.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(password, salt, 20_000, 16)

        begin
            aes.update(self.password) + aes.final
        rescue OpenSSL::Cipher::CipherError
            nil
        end
    end

    def encrypt(data)
        aes = OpenSSL::Cipher::AES.new(128, :CBC).encrypt
        iv = Sequel.blob(aes.random_iv)
        salt = Sequel.blob(OpenSSL::Random.random_bytes(16))
        aes.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(data, salt, 20_000, 16)
        return iv, salt, Sequel.blob(aes.update(data) + aes.final)
    end

    def reset_password(new_password)
        return "Password cannot be empty" if new_password.empty?
        return "Password can only be maximum 28 characters" if password.length > 28
        self.iv, self.salt, self.password = encrypt(new_password)
        nil 
    end

    def set_defaults()
        self.staff = 0
        self.mode = "r"
        self.about_me = ""
        self.popcorn = 0
        self.premium = 0
    end

    def is_reader()
        return self.mode == "r"
    end

    def is_writer()
        return self.mode == "w"
    end

    def is_staff()
        return self.staff == 1
    end

    def is_premium()
        return self.premium == 1
    end

    def is_test_account()
        return self.username == READER || self.username == WRITER
    end

    def get_link()
        return "/view?username=#{self.username}"
    end

    def is_current_user(user_id)
        return user_id == self.id
    end

    def owns_book(book)
        return !Purchase.first(customer: self.id, product: book.id).nil?
    end
end