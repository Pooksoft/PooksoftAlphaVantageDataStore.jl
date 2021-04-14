
function process_raw_csv_api_data(api_call_raw_data::String)::PSResult

    # check: do we have an empty string?
    # check: legit string?

    # need to check to see if legit data is coming back from the service -
    if (is_valid_json(api_call_raw_data) == true)
        api_data_dictionary = JSON.parse(api_call_raw_data)
        if (haskey(api_data_dictionary,"Error Message") == true)

            # grab the error mesage -
            error_message = api_data_dictionary["Error Message"]

            # throw -
            return PSResult{PSError}(PSError(error_message))
        else

            # formulate an error message -
            error_message = "Error: CSV type returns JSON without error message"

            # throw -
            return PSResult{PSError}(PSError(error_message))
        end
    end

    # create a data table from the CSV data -
    tmp_data_table = CSV.read(IOBuffer(api_call_raw_data), DataFrame)

    # sort the table according to the timestamps -
    idx_sort = sortperm(tmp_data_table[:,1])

    # create a sorted data table -
    sorted_data_table = tmp_data_table[idx_sort,:]

    # return the sorted table -
    return PSResult{DataFrame}(sorted_data_table)
end

function process_raw_json_api_data_sts(api_call_raw_data::String, data_series_key::String)::(Union{PSResult{T}, Nothing} where T<:Any)

    # is the data coming back well formed, and does it contain valid data?
    check_result = check_json_api_return_data(api_call_raw_data)
    if check_result != nothing
        return check_result
    end

    # TODO - check for missing data series key -
    # ...

    # if we get here, we have valid JSON. Build dictionary -
    api_data_dictionary = JSON.parse(api_call_raw_data)

    # grab the time series data -
    time_series_key = data_series_key
    if (haskey(api_data_dictionary, time_series_key) == false)

        # throw an error -
        error_message = "Error: Missing the Time series key = $(time_series_key)"

        # throw -
        return PSError(error_message)
    end

    # array of keys -
    data_key_label_array = ["1. open", "2. high", "3. low", "4. close", "5. volume"]
    number_of_fields = length(data_key_label_array)

    # initialize storage for the fields -
    timestamp_array = Dates.Date[]
    open_price_array = Float64[]
    high_price_array = Float64[]
    low_price_array = Float64[]
    close_price_array = Float64[]
    volume_array = Int64[]

    # ok, we have the time series key, go through the data and load into the table -
    time_series_dictionary = api_data_dictionary[time_series_key]
    time_series_key_array = collect(keys(time_series_dictionary))
    for timestamp_value in time_series_key_array

        # get the local_dictionary -
        local_dictionary = time_series_dictionary[timestamp_value]

        # cache -
        push!(timestamp_array, Dates.Date(timestamp_value,"yyyy-mm-dd"))

        # add the price data -
        for key_index = 1:number_of_fields

            # grab key -
            local_key = data_key_label_array[key_index]
            value = local_dictionary[local_key]

            # populate the array's -
            if (key_index == 1)
                push!(open_price_array, parse(Float64, value))
            elseif (key_index == 2)
                push!(high_price_array, parse(Float64, value))
            elseif (key_index == 3)
                push!(low_price_array, parse(Float64, value))
            elseif (key_index == 4)
                push!(close_price_array, parse(Float64, value))
            else
                push!(volume_array, parse(Int64, value))
            end
        end
    end

    # we need to sort the timestamps, to make them in reverse order -
    idx_sort = sortperm(timestamp_array)

    # build the data frame -
    data_frame = DataFrame(timestamp=timestamp_array[idx_sort], open=open_price_array[idx_sort], high=high_price_array[idx_sort], low=low_price_array[idx_sort], close=close_price_array[idx_sort], volume=volume_array[idx_sort])

    # return the data back to the caller -
    return PSResult{DataFrame}(data_frame)
end

function process_raw_json_api_data_sts_adjusted(api_call_raw_data::String, data_series_key::String)::(Union{PSResult{T}, Nothing} where T<:Any)
    
    # is the data coming back well formed, and does it contain valid data?
    check_result = check_json_api_return_data(api_call_raw_data)
    if check_result != nothing
        return check_result
    end

    # if we get here, we have valid JSON. Build dictionary -
    api_data_dictionary = JSON.parse(api_call_raw_data)

    # grab the time series data -
    time_series_key = data_series_key
    if (haskey(api_data_dictionary, time_series_key) == false)

        # throw an error -
        error_message = "Error: Missing the Time series key = $(time_series_key)"

        # throw -
        return PSError(error_message)
    end
    #all repeated up to here possibly look to make the above a function for just checking data
    # array of keys -- this is changed per function
    data_key_label_array = ["1. open", "2. high", "3. low", "4. close", "5. adjusted close", "6. volume", "7. dividend amount"]
    number_of_fields = length(data_key_label_array)

    #initialize arrays to hold these fields for all dates
    timestamp_array = Dates.Date[]
    open_price_array = Float64[]
    high_price_array = Float64[]
    low_price_array = Float64[]
    close_price_array = Float64[]
    adjusted_close_array = Float64[]
    volume_array = Int64[]
    dividend_amount_array = Float64[]

    # ok, we have the time series key, go through the data and load into the table -
    time_series_dictionary = api_data_dictionary[time_series_key]
    time_series_key_array = collect(keys(time_series_dictionary))
    for timestamp_value in time_series_key_array

        # get the local_dictionary -
        local_dictionary = time_series_dictionary[timestamp_value]

        # cache -
        push!(timestamp_array, Dates.Date(timestamp_value,"yyyy-mm-dd"))

        # add the price data -
        for key_index = 1:number_of_fields

            # grab key -
            local_key = data_key_label_array[key_index]
            value = local_dictionary[local_key]

            # populate the array's -
            if (key_index == 1)
                push!(open_price_array, parse(Float64, value))
            elseif (key_index == 2)
                push!(high_price_array, parse(Float64, value))
            elseif (key_index == 3)
                push!(low_price_array, parse(Float64, value))
            elseif (key_index == 4)
                push!(close_price_array, parse(Float64, value))
            elseif (key_index == 5)
                push!(adjusted_close_array, parse(Float64, value))
            elseif (key_index == 6)
                push!(volume_array, parse(Int64, value))
            else
                push!(dividend_amount_array, parse(Float64, value))
            end
        end
    end
    # we need to sort the timestamps, to make them in reverse order -
    idx_sort = sortperm(timestamp_array)

    # build the data frame -
    data_frame = DataFrame(timestamp=timestamp_array[idx_sort], open=open_price_array[idx_sort], high=high_price_array[idx_sort], low=low_price_array[idx_sort], close=close_price_array[idx_sort], adjusted_close = adjusted_close_array[idx_sort], volume=volume_array[idx_sort], dividend_amount = dividend_amount_array[idx_sort])

    # return the data back to the caller -
    return PSResult{DataFrame}(data_frame)
end

function process_raw_json_api_data_sts_daily_adjusted(api_call_raw_data::String, data_series_key::String)::(Union{PSResult{T}, Nothing} where T<:Any)
    
    # is the data coming back well formed, and does it contain valid data?
    check_result = check_json_api_return_data(api_call_raw_data)
    if check_result !== nothing
        return check_result
    end

    # if we get here, we have valid JSON. Build dictionary -
    api_data_dictionary = JSON.parse(api_call_raw_data)

    # grab the time series data -
    time_series_key = data_series_key
    if (haskey(api_data_dictionary, time_series_key) == false)

        # throw an error -
        error_message = "Error: Missing the Time series key = $(time_series_key)"

        # throw -
        return PSError(error_message)
    end
    #all repeated up to here possibly look to make the above a function for just checking data
    # array of keys -- this is changed per function
    data_key_label_array = ["1. open", "2. high", "3. low", "4. close", "5. adjusted close", "6. volume", "7. dividend amount", "8. split coefficient"]
    number_of_fields = length(data_key_label_array)

    #initialize arrays to hold these fields for all dates
    timestamp_array = Dates.Date[]
    open_price_array = Float64[]
    high_price_array = Float64[]
    low_price_array = Float64[]
    close_price_array = Float64[]
    adjusted_close_array = Float64[]
    volume_array = Int64[]
    dividend_amount_array = Float64[]
    split_coefficient = Float64[]

    # ok, we have the time series key, go through the data and load into the table -
    time_series_dictionary = api_data_dictionary[time_series_key]
    time_series_key_array = collect(keys(time_series_dictionary))
    for timestamp_value in time_series_key_array

        # get the local_dictionary -
        local_dictionary = time_series_dictionary[timestamp_value]

        # cache -
        push!(timestamp_array, Dates.Date(timestamp_value,"yyyy-mm-dd"))

        # add the price data -
        for key_index = 1:number_of_fields

            # grab key -
            local_key = data_key_label_array[key_index]
            value = local_dictionary[local_key]

            # populate the array's -
            if (key_index == 1)
                push!(open_price_array, parse(Float64, value))
            elseif (key_index == 2)
                push!(high_price_array, parse(Float64, value))
            elseif (key_index == 3)
                push!(low_price_array, parse(Float64, value))
            elseif (key_index == 4)
                push!(close_price_array, parse(Float64, value))
            elseif (key_index == 5)
                push!(adjusted_close_array, parse(Float64, value))
            elseif (key_index == 6)
                push!(volume_array, parse(Int64, value))
            elseif (key_index == 7)
                push!(dividend_amount_array, parse(Float64, value))
            else
                push!(split_coefficient, parse(Float64, value))
            end
        end
    end
    # we need to sort the timestamps, to make them in reverse order -
    idx_sort = sortperm(timestamp_array)

    # build the data frame -
    data_frame = DataFrame(timestamp=timestamp_array[idx_sort], open=open_price_array[idx_sort], high=high_price_array[idx_sort], low=low_price_array[idx_sort], close=close_price_array[idx_sort], adjusted_close = adjusted_close_array[idx_sort], volume=volume_array[idx_sort], dividend_amount = dividend_amount_array[idx_sort])

    # return the data back to the caller -
    return PSResult{DataFrame}(data_frame)
end

function process_raw_json_data_sts_global_quote(api_call_raw_data::String, data_series_key::String)::(Union{PSResult{T}, Nothing} where T<:Any)

     # is the data coming back well formed, and does it contain valid data?
     check_result = check_json_api_return_data(api_call_raw_data)
     if check_result !== nothing
         return check_result
     end
 
     # if we get here, we have valid JSON. Build dictionary -
     api_data_dictionary = JSON.parse(api_call_raw_data)
 
     # grab the time series data -
     time_series_key = data_series_key
     if (haskey(api_data_dictionary, time_series_key) == false)
 
         # throw an error -
         error_message = "Error: Missing the Time series key = $(time_series_key)"
 
         # throw -
         return PSError(error_message)
     end

     #all repeated up to here possibly look to make the above a function for just checking data
     # array of keys -- this is changed per function
     data_key_label_array = ["01. symbol", "02. open", "03. high", "04. low", "05. price", "06. volume", "07. latest trading day", "08. previous close", "09. change", "10. change percent"]
     number_of_fields = length(data_key_label_array)
 
     #initialize arrays to hold these fields for all dates
     symbol_array = String[]
     open_price_array = Float64[]
     high_price_array = Float64[]
     low_price_array = Float64[]
     price_array = Float64[]
     volume_array = Int64[]
     latest_trading_day = Dates.Date[]
     previous_close_array = Float64[]
     change_array = Float64[]
     change_percentage_array = String[]
 
     # ok, we have the time series key, go through the data and load into the table -
     data_dictionary = api_data_dictionary[time_series_key]
     for key_index = 1:number_of_fields
 
        # grab key -
        local_key = data_key_label_array[key_index]
        value = data_dictionary[local_key]

        # populate the array's -
        if (key_index == 1)
            push!(symbol_array, value)
        elseif (key_index == 2)
            push!(open_price_array, parse(Float64, value))
        elseif (key_index == 3)
            push!(high_price_array, parse(Float64, value))
        elseif (key_index == 4)
            push!(low_price_array, parse(Float64, value))
        elseif (key_index == 5)
            push!(price_array, parse(Float64, value))
        elseif (key_index == 6)
            push!(volume_array, parse(Int64, value))
        elseif (key_index == 7)
            push!(latest_trading_day, Dates.Date(value,"yyyy-mm-dd"))
       elseif (key_index == 8)
           push!(previous_close_array, parse(Float64, value))
       elseif (key_index == 9)
           push!(change_array, parse(Float64, value))
       else
            push!(change_percentage_array, value)
        end
    end

    # build the data frame -
    data_frame = DataFrame(symbol=symbol_array, open=open_price_array, high=high_price_array, low=low_price_array, price=price_array, 
        volume=volume_array, timestamp=latest_trading_day, previous_close = previous_close_array, change=change_array, change_percentage = change_percentage_array)
 
    # return the data back to the caller -
    return PSResult{DataFrame}(data_frame)
end

function process_raw_json_data_sts_search_data(api_call_raw_data::String, data_series_key::String)::(Union{PSResult{T}, Nothing} where T<:Any)

    # is the data coming back well formed, and does it contain valid data?
    check_result = check_json_api_return_data(api_call_raw_data)
    if check_result !== nothing
        return check_result
    end

    # if we get here, we have valid JSON. Build dictionary -
    api_data_dictionary = JSON.parse(api_call_raw_data)

    # grab the time series data -
    time_series_key = data_series_key
    if (haskey(api_data_dictionary, time_series_key) == false)

        # throw an error -
        error_message = "Error: Missing data series key = $(time_series_key)"

        # throw -
        return PSError(error_message)
    end
    #all repeated up to here possibly look to make the above a function for just checking data
    # array of keys -- this is changed per function
    data_key_label_array = ["1. symbol", "2. name", "3. type", "4. region", "5. marketOpen", "6. marketClose", "7. timezone", "8. currency", "9. matchScore"]
    number_of_fields = length(data_key_label_array)

    #initialize arrays to hold these fields for all dates
    symbol_array = String[]
    name_array = String[]
    type_array = String[]
    region_array = String[]
    market_open_array = String[]
    market_close_array = String[]
    timezone_array = String[]
    currency_array = String[]
    match_score_array = Float64[]

    # ok, we have the time series key, go through the data and load into the table -
    time_series_dictionary = api_data_dictionary[time_series_key]
    time_series_key_array = collect(keys(time_series_dictionary))
    for timestamp_value in time_series_key_array

        # get the local_dictionary -
        local_dictionary = time_series_dictionary[timestamp_value]

        # add the price data -
        for key_index = 1:number_of_fields

            # grab key -
            local_key = data_key_label_array[key_index]
            value = local_dictionary[local_key]

            # populate the array's -
            if (key_index == 1)
                push!(symbol_array, value)
            elseif (key_index == 2)
                push!(name_array, value)
            elseif (key_index == 3)
                push!(type_array, value)
            elseif (key_index == 4)
                push!(region_array, value)
            elseif (key_index == 5)
                push!(market_open_array, value)
            elseif (key_index == 6)
                push!(market_close_array, value)
            elseif (key_index == 7)
                push!(timezone_array, value)
            elseif (key_index == 8)
                push!(currency_array, value)
            elseif (key_index == 9)
                push!(match_score_array, parse(Float64,value))
            end
        end
    end

    # build the data frame -
    data_frame = DataFrame(symbol=symbol_array, name=name_array, type=type_array, region=region_array, marketOpen=market_open_array, marketClose = market_close_array, 
        timezone=timezone_array, currency = currency_array, match = match_score_array)

    # return the data back to the caller -
    return PSResult{DataFrame}(data_frame)
end

function process_raw_json_data_ti_sma_data(api_call_raw_data::String, data_series_key::String)::PSResult

    # if we get here, we have valid JSON. Build dictionary -
    api_data_dictionary = JSON.parse(api_call_raw_data)

    # grab the time series data -
    time_series_key = data_series_key
    if (haskey(api_data_dictionary, time_series_key) == false)

        # throw an error -
        error_message = "Error: Missing the series key = $(time_series_key)"

        # throw -
        return PSError(error_message)
    end

    # initialize -
    data_key_label_array = ["SMA"]
    number_of_fields = length(data_key_label_array)
    timestamp_array = Dates.Date[]
    sma_value_array = Float64[]

    # ok, get the data for each time point -
    time_series_dictionary = api_data_dictionary[time_series_key]
    time_series_key_array = collect(keys(time_series_dictionary))
    for timestamp_value in time_series_key_array

        # get the local_dictionary -
        local_dictionary = time_series_dictionary[timestamp_value]

        # cache -
        push!(timestamp_array, Dates.Date(timestamp_value,"yyyy-mm-dd"))

        # add the price data -
        for key_index = 1:number_of_fields

            # grab key -
            local_key = data_key_label_array[key_index]
            value = local_dictionary[local_key]
            
            if (key_index == 1)
                push!(sma_value_array, parse(Float64,value))
            end
        end
    end

    # we need to sort the timestamps, to make them in reverse order -
    idx_sort = sortperm(timestamp_array)

    # build the data frame -
    data_frame = DataFrame(timestamp=timestamp_array[idx_sort], sma=sma_value_array[idx_sort])

    # return the data back to the caller -
    return PSResult{DataFrame}(data_frame)
end

function process_raw_json_data_ti_ema_data(api_call_raw_data::String, data_series_key::String)::PSResult

    # if we get here, we have valid JSON. Build dictionary -
    api_data_dictionary = JSON.parse(api_call_raw_data)

    # grab the time series data -
    time_series_key = data_series_key
    if (haskey(api_data_dictionary, time_series_key) == false)

        # throw an error -
        error_message = "Error: Missing the series key = $(time_series_key)"

        # throw -
        return PSError(error_message)
    end

    # initialize -
    data_key_label_array = ["EMA"]
    number_of_fields = length(data_key_label_array)
    timestamp_array = Dates.Date[]
    ema_value_array = Float64[]

    # ok, get the data for each time point -
    time_series_dictionary = api_data_dictionary[time_series_key]
    time_series_key_array = collect(keys(time_series_dictionary))
    for timestamp_value in time_series_key_array

        # get the local_dictionary -
        local_dictionary = time_series_dictionary[timestamp_value]

        # cache -
        push!(timestamp_array, Dates.Date(timestamp_value,"yyyy-mm-dd"))

        # add the price data -
        for key_index = 1:number_of_fields

            # grab key -
            local_key = data_key_label_array[key_index]
            value = local_dictionary[local_key]
            
            if (key_index == 1)
                push!(ema_value_array, parse(Float64,value))
            end
        end
    end

    # we need to sort the timestamps, to make them in reverse order -
    idx_sort = sortperm(timestamp_array)

    # build the data frame -
    data_frame = DataFrame(timestamp=timestamp_array[idx_sort], ema=ema_value_array[idx_sort])

    # return the data back to the caller -
    return PSResult{DataFrame}(data_frame)
end

function process_raw_json_data_ti_rsi_data(api_call_raw_data::String, 
    data_series_key_array::String)::PSResult

    # if we get here, we have valid JSON. Build dictionary -
    api_data_dictionary = JSON.parse(api_call_raw_data)

    # grab the time series data -
    time_series_key = data_series_key
    if (haskey(api_data_dictionary, time_series_key) == false)

        # throw an error -
        error_message = "Error: Missing the series key = $(time_series_key)"

        # throw -
        return PSError(error_message)
    end

    # initialize -
    data_key_label_array = ["RSI"]
    number_of_fields = length(data_key_label_array)
    timestamp_array = Dates.Date[]
    rsi_value_array = Float64[]

    # ok, get the data for each time point -
    time_series_dictionary = api_data_dictionary[time_series_key]
    time_series_key_array = collect(keys(time_series_dictionary))
    for timestamp_value in time_series_key_array

        # get the local_dictionary -
        local_dictionary = time_series_dictionary[timestamp_value]

        # cache -
        push!(timestamp_array, Dates.Date(timestamp_value,"yyyy-mm-dd"))

        # add the price data -
        for key_index = 1:number_of_fields

            # grab key -
            local_key = data_key_label_array[key_index]
            value = local_dictionary[local_key]
            
            if (key_index == 1)
                push!(rsi_value_array, parse(Float64,value))
            end
        end
    end

    # we need to sort the timestamps, to make them in reverse order -
    idx_sort = sortperm(timestamp_array)

    # build the data frame -
    data_frame = DataFrame(timestamp=timestamp_array[idx_sort], rsi=rsi_value_array[idx_sort])

    # return the data back to the caller -
    return PSResult{DataFrame}(data_frame)
end

function process_raw_json_fundamentals_earnings_data(api_call_raw_data::String)::PSResult

    # if we get here, we have valid JSON. Build dictionary -
    api_data_dictionary = JSON.parse(api_call_raw_data)
    earnings_data_dictionary = Dict{String,Any}()

    # ok, so there is a symbol key that comes back -
    earnings_data_dictionary["symbol"] = api_data_dictionary["symbol"]

    # grab: annualEarnings -
    list_of_annual_earnings_dictionaries =  api_data_dictionary["annualEarnings"]
    earnings_dataframe = DataFrame(fiscalDateEnding=Dates.Date[],reportedEPS=Union{Float64,Missing}[])
    for earnings_dictionary in list_of_annual_earnings_dictionaries
        
        # grab -
        timestamp_value = earnings_dictionary["fiscalDateEnding"]
        eps_value = earnings_dictionary["reportedEPS"]

        # convert -
        converted_timestamp_value = Dates.Date(timestamp_value,"yyyy-mm-dd")
        converted_eps_value = parse(Float64, eps_value)

        # package into the df -
        push!(earnings_dataframe, (converted_timestamp_value, converted_eps_value))
    end

    # grab: quarterlyEarnings -
    list_of_quaterly_earnings_dictionaries = api_data_dictionary["quarterlyEarnings"]
    quarterly_dataframe = DataFrame(fiscalDateEnding=Dates.Date[],
        reportedDate=Dates.Date[],
        reportedEPS=Union{Float64,Missing}[],
        estimatedEPS=Union{Float64,Missing}[],
        surprise=Union{Float64,Missing}[],
        surprisePercentage=Union{Float64,Missing}[])

    for earnings_dictionary in list_of_quaterly_earnings_dictionaries
        
        # grab data from dictionary -
        fiscalDateEnding = Dates.Date(earnings_dictionary["fiscalDateEnding"], "yyyy-mm-dd")
        reportedDate = Dates.Date(earnings_dictionary["reportedDate"], "yyyy-mm-dd")

        # check reported EPS -
        reportedEPS_value = earnings_dictionary["reportedEPS"]
        reportedEPS = missing
        if (reportedEPS_value != "None")
            reportedEPS = parse(Float64, reportedEPS_value)
        end

        # check estimated EPS -
        estimatedEPS_value = earnings_dictionary["estimatedEPS"]
        estimatedEPS = missing
        if (estimatedEPS_value != "None")
            estimatedEPS = parse(Float64, estimatedEPS_value)
        end
            
        # check suprise -
        surprise_value = earnings_dictionary["surprise"]
        surprise = missing
        if (surprise_value != "None")
            surprise = parse(Float64, surprise_value)
        end
        
        # check surprisePercentage -
        surprisePercentage_value = earnings_dictionary["surprisePercentage"]
        surprisePercentage = missing
        if (surprisePercentage_value != "None")
            surprisePercentage = parse(Float64, surprisePercentage_value)
        end
        
        # package -
        push!(quarterly_dataframe,(fiscalDateEnding, reportedDate, reportedEPS, estimatedEPS, surprise, surprisePercentage))
    end

    # package -
    earnings_data_dictionary["annualEarnings"] = earnings_dataframe
    earnings_data_dictionary["quarterlyEarnings"] = quarterly_dataframe

    # return -
    return PSResult(earnings_data_dictionary)
end

function process_raw_json_fundamentals_income_statement_data(api_call_raw_data::String)::PSResult

    # if we get here, we have valid JSON. Build dictionary -
    api_data_dictionary = JSON.parse(api_call_raw_data)
    income_statement_data_dictionary = Dict{String,Any}()

    # ok, so there is a symbol key that comes back -
    income_statement_data_dictionary["symbol"] = api_data_dictionary["symbol"]

    # process the annualReports -
    # what keys are we looking for in the annual report dictionary -
    annual_report_key_array = [
        "fiscalDateEnding"                  ;
        "reportedCurrency"                  ;
        "grossProfit"                       ; 
        "totalRevenue"                      ; 
        "costOfRevenue"                     ; 
        "costofGoodsAndServicesSold"        ; 
        "operatingIncome"                   ; 
        "sellingGeneralAndAdministrative"   ; 
        "researchAndDevelopment"            ; 
        "operatingExpenses"                 ; 
        "investmentIncomeNet"               ; 
        "netInterestIncome"                 ; 
        "interestIncome"                    ; 
        "interestExpense"                   ; 
        "nonInterestIncome"                 ; 
        "otherNonOperatingIncome"           ; 
        "depreciation"                      ; 
        "depreciationAndAmortization"       ; 
        "incomeBeforeTax"                   ; 
        "incomeTaxExpense"                  ; 
        "interestAndDebtExpense"            ; 
        "netIncomeFromContinuingOperations" ; 
        "comprehensiveIncomeNetOfTax"       ; 
        "ebit"                              ; 
        "ebitda"                            ; 
        "netIncome"                         ;
    ]

    # get the array of annual report dictionaries -
    list_of_annual_report_dictionaries =  api_data_dictionary["annualReports"]
    annual_reports_dataframe = DataFrame(fiscalDateEnding=Dates.Date[],reportedCurrency=String[],grossProfit=Union{Float64,Missing}[],
        totalRevenue=Union{Float64,Missing}[],costOfRevenue=Union{Float64,Missing}[],costofGoodsAndServicesSold=Union{Float64,Missing}[],operatingIncome=Union{Float64,Missing}[],
        sellingGeneralAndAdministrative=Union{Float64,Missing}[],researchAndDevelopment=Union{Float64,Missing}[],operatingExpenses=Union{Float64,Missing}[],investmentIncomeNet=Union{Float64,Missing}[],
        netInterestIncome=Union{Float64,Missing}[],interestIncome=Union{Float64,Missing}[],interestExpense=Union{Float64,Missing}[],nonInterestIncome=Union{Float64,Missing}[],otherNonOperatingIncome=Union{Float64,Missing}[],
        depreciation=Union{Float64,Missing}[],depreciationAndAmortization=Union{Float64,Missing}[],incomeBeforeTax=Union{Float64,Missing}[],incomeTaxExpense=Union{Float64,Missing}[],interestAndDebtExpense=Union{Float64,Missing}[],
        netIncomeFromContinuingOperations=Union{Float64,Missing}[],comprehensiveIncomeNetOfTax=Union{Float64,Missing}[],ebit=Union{Float64,Missing}[],ebitda=Union{Float64,Missing}[],netIncome=Union{Float64,Missing}[])

    # loop throw, and pakage the annual report values into the dataframe -
    for annual_report in list_of_annual_report_dictionaries
        
        # init the row of data -
        data_row = Array{Any,1}()

        # go throw all the keys -
        for annual_report_key in annual_report_key_array

            # ok, so if we have fiscalDateEnding or reportedCurrency we have a non-numeric value
            clean_value = 0.0
            if annual_report_key == "fiscalDateEnding"
                clean_value = Dates.Date(annual_report["fiscalDateEnding"], "yyyy-mm-dd")
            elseif annual_report_key == "reportedCurrency"
                clean_value = annual_report["reportedCurrency"]
            else
                
                # grab the value, check if none -
                value = annual_report[annual_report_key]
                clean_value = check_for_numerical_none_value(value)
            end
            
            # cache -
            push!(data_row, clean_value)
        end

        # push the data row into the data frame -
        push!(annual_reports_dataframe, tuple(data_row...))
    end
    income_statement_data_dictionary["annualReports"] = annual_reports_dataframe

    # process the quarterly reports -
    list_of_quaterly_report_dictionaries =  api_data_dictionary["quarterlyReports"]
    quaterly_reports_dataframe = DataFrame(fiscalDateEnding=Dates.Date[],reportedCurrency=String[],grossProfit=Union{Float64,Missing}[],
        totalRevenue=Union{Float64,Missing}[],costOfRevenue=Union{Float64,Missing}[],costofGoodsAndServicesSold=Union{Float64,Missing}[],operatingIncome=Union{Float64,Missing}[],
        sellingGeneralAndAdministrative=Union{Float64,Missing}[],researchAndDevelopment=Union{Float64,Missing}[],operatingExpenses=Union{Float64,Missing}[],investmentIncomeNet=Union{Float64,Missing}[],
        netInterestIncome=Union{Float64,Missing}[],interestIncome=Union{Float64,Missing}[],interestExpense=Union{Float64,Missing}[],nonInterestIncome=Union{Float64,Missing}[],otherNonOperatingIncome=Union{Float64,Missing}[],
        depreciation=Union{Float64,Missing}[],depreciationAndAmortization=Union{Float64,Missing}[],incomeBeforeTax=Union{Float64,Missing}[],incomeTaxExpense=Union{Float64,Missing}[],interestAndDebtExpense=Union{Float64,Missing}[],
        netIncomeFromContinuingOperations=Union{Float64,Missing}[],comprehensiveIncomeNetOfTax=Union{Float64,Missing}[],ebit=Union{Float64,Missing}[],ebitda=Union{Float64,Missing}[],netIncome=Union{Float64,Missing}[])

    # loop throw, and pakage the annual report values into the dataframe -> same keys as annualReport
    for quaterly_report in list_of_quaterly_report_dictionaries
        
        # init the row of data -
        data_row = Array{Any,1}()

        # go throw all the keys -
        for annual_report_key in annual_report_key_array

            # ok, so if we have fiscalDateEnding or reportedCurrency we have a non-numeric value
            clean_value = 0.0
            if annual_report_key == "fiscalDateEnding"
                clean_value = Dates.Date(quaterly_report["fiscalDateEnding"], "yyyy-mm-dd")
            elseif annual_report_key == "reportedCurrency"
                clean_value = quaterly_report["reportedCurrency"]
            else
                
                # grab the value, check if none -
                value = quaterly_report[annual_report_key]
                clean_value = check_for_numerical_none_value(value)
            end
            
            # cache -
            push!(data_row, clean_value)
        end

        # push the data row into the data frame -
        push!(quaterly_reports_dataframe, tuple(data_row...))
    end
    income_statement_data_dictionary["quarterlyReports"] = quaterly_reports_dataframe

    
    # return -
    return PSResult(income_statement_data_dictionary)
end