class Poll < Sequel::Model
    def set_count(count = 0)
        self.option1_count = count
        self.option2_count = count
        self.option3_count = count
        self.option4_count = count
        self.option5_count = count
    end

    def get_options()
        options = []
        options << self.option1 if (!self.option1.nil?)
        options << self.option2 if (!self.option2.nil?)
        options << self.option3 if (!self.option3.nil?)
        options << self.option4 if (!self.option4.nil?)
        options << self.option5 if (!self.option5.nil?)
        return options
    end

    def get_option_value(option)
        case option
        when self.option1
            return self.option1_count
        when self.option2
            return self.option2_count
        when self.option3
            return self.option3_count
        when self.option4
            return self.option4_count
        when self.option5
            return self.option5_count
        else
            return 0
        end
    end

    def increment_value(option)
        case option
        when self.option1
            self.option1_count = self.option1_count + 1
        when self.option2
            self.option2_count = self.option2_count + 1
        when self.option3
            self.option3_count = self.option3_count + 1
        when self.option4
            self.option4_count = self.option4_count + 1
        when self.option5
            self.option5_count = self.option5_count + 1
        else
            return
        end
    end
end