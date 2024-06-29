get "/purchase" do
    @defaultValues = Default_Values.first(id: 1)
    erb :purchase
end

get "/confirm" do
    @total_popcorn = 0
    @total_popcorn += (params["popcorn100"].nil?) ? 0 : 100
    @total_popcorn += (params["popcorn500"].nil?) ? 0 : 100
    @total_popcorn += (params["popcorn1500"].nil?) ? 0 : 100
    @total_popcorn += (params["popcorn5000"].nil?) ? 0 : 100
    @total_popcorn += (params["popcorn1000"].nil?) ? 0 : 100
    @total_popcorn += (params["popcorn25000"].nil?) ? 0 : 100
    @premium = params["premium"]

    defaultValues = Default_Values.first(id: 1)

    @cost = defaultValues.calculate_cost(@total_popcorn) 
    if (!(@premium.nil?)) 
        @cost += defaultValues.premium_price
    end
    redirect back if (@cost == 0)

    erb :purchase_credentials
end


post "/purchase" do 
    cost = params["cost"]
    total_popcorn = params["popcorn"]
    premium = params["premium"]
    TOTAL_BALANCE = 10000
    user = User.first(id: session["user_id"])
    if (cost > TOTAL_BALANCE) then
        @error = "You do not have enough balance, you currently have ${TOTAL_BALANCE}"
    elsif (user.is_premium) then
        @error = "You already have premium, please remove it from your basket"
    else
        TOTAL_BALANCE -= cost
        user.popcorn +=  total_popcorn
        user.premium = 1
        user.save
    end
end