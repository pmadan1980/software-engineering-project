class Default_Values < Sequel::Model
    def validate_popcorn_to_pounds(popcorn_to_pounds)
        return "Popcorn to pounds can't be empty" if popcorn_to_pounds.empty?
        return "Popcorn to pounds must be a number" if Float(popcorn_to_pounds, exception: false).nil?
        popcorn_to_pounds = popcorn_to_pounds.to_f
        return "Popcorn to pounds must be greater than 0.01" if popcorn_to_pounds < 0.01
        nil
    end

    def calculate_cost(popcorn)
        popcorn * self.popcorn_to_pounds
    end
end