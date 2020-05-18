"""
    execute_sts_daily_api_call()
"""
function execute_sts_daily_api_call(user_model::PSUserModel, stock_symbol::String; 
    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing)::(Union{PSResult{T}, Nothing} where T<:Any)

    # some error checks -
    # is user_model valid?
    check_result = check_user_model(user_model)
    if (check_result != nothing && typeof(check_result.value) == PSError)
        return check_result
    end

    # do we have the API key?
    check_result = check_missing_api_key(user_model)
    if (check_result != nothing && typeof(check_result.value) == PSError)
        return check_result
    end

    # do we have a stock_symbol -
    check_result = check_missing_symbol(stock_symbol)
    if (check_result != nothing && typeof(check_result.value) == PSError)
        return check_result
    end

    # get key's and id -
    api_key = user_model.alphavantage_api_key

    # use the alpha_vantage_api to download the data -
    url = "$(alphavantage_api_url_string)?function=TIME_SERIES_DAILY&symbol=$(stock_symbol)&apikey=$(api_key)&datatype=$(string(data_type))&outputsize=$(string(outputsize))"
    api_call_result = http_get_call_with_url(url)
    if (typeof(api_call_result.value) == PSError)
        return api_call_result
    end

    # we should have a string result -
    api_call_raw_data = api_call_result.value

    # make a call to log -
    if logger != nothing
        log_api_call(logger, user_model,url)
    end

    # make the calls, depending upon the type -
    if (data_type == :json)

        # process -
        data_series_key = "Time Series (Daily)"
        return process_raw_json_api_data_sts(api_call_raw_data, data_series_key)

    elseif (data_type == :csv)

        # return the data back to the caller -
        return process_raw_csv_api_data(api_call_raw_data)
    else
        # formulate the error message -
        error_message = "$(data_type) is not supported. Supported values are {:json,:csv}"

        # throw -
        return PSResult{PSError}(PSError(error_message))
    end
end

"""
    execute_sts_adjusted_daily_api_call()
"""
function execute_sts_adjusted_daily_api_call(user_model::PSUserModel, stock_symbol::String; 
    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing)::(Union{PSResult{T}, Nothing} where T<:Any)
    
    # some error checks -
    # is user_models valid?
    check_result = check_user_model(user_model)
    if (check_result != nothing && typeof(check_result.value) == PSError)
        return check_result
    end

    # do we have the API key?
    check_result = check_missing_api_key(user_model)
    if (check_result != nothing && typeof(check_result.value) == PSError)
        return check_result
    end

    # do we have a stock_symbol -
    check_result = check_missing_symbol(stock_symbol)
    if (check_result != nothing && typeof(check_result.value) == PSError)
        return check_result
    end

    # get key's and id -
    api_key = user_model.alphavantage_api_key

    # call to alpha_vantage_api to get data
    url = "$(alphavantage_api_url_string)?function=TIME_SERIES_DAILY_ADJUSTED&symbol=$(stock_symbol)&apikey=$(api_key)&datatype=$(string(data_type))&outputsize=$(string(outputsize))"
    api_call_result = http_get_call_with_url(url)
    if (typeof(api_call_result.value) == PSError)
        return api_call_result
    end

    #check that result value is a string
    #this is also new but doesn't change between time periods
    if (typeof(api_call_result.value) isa String == false)
        println("Call result is not valid type")#error from not correct data output
    else
        api_call_raw_data = api_call_result.value
    end

    #call to logger
    if logger != nothing
        log_api_call(logger, user_model, url)
    end

    #parse json if data called as a .json
    if (data_type == :json)
        
        # process json
        data_series_key = "Time Series (Daily)"
        return process_raw_json_api_data_sts_daily_adjusted(api_call_raw_data, data_series_key)

    elseif (data_type == :csv)
        
        #return process .csv
        return process_raw_csv_api_data(api_call_raw_data)
    else
        
        # tell user they requested an unsupported type of data
        error_message = "$(data_type) isn't supported by AlphaVantage. Supported values are {:json, :csv}"
        return PSResult{PSError}(PSError(error_message))
    end
end
