function execute_sts_quote_api_call(user_model::PSUserModel, stock_symbol::String; 
    data_type::Symbol = :json, logger::Union{Nothing,AbstractLogger} = nothing)::(Union{PSResult{T}, Nothing} where T<:Any)

    # some error checks -
    # is user_models valid?
    check_result = check_user_model(user_model)
    if (check_result !== nothing && typeof(check_result.value) == PSError)
        return check_result
    end

    # do we have the API key?
    check_result = check_missing_api_key(user_model)
    if (check_result !== nothing && typeof(check_result.value) == PSError)
        return check_result
    end

    # do we have a stock_symbol -
    check_result = check_missing_symbol(stock_symbol)
    if (check_result !== nothing && typeof(check_result.value) == PSError)
        return check_result
    end

    # get key's and id -
    api_key = user_model.alphavantage_api_key

    # call to alpha_vantage_api to get data
    url = "$(alphavantage_api_url_string)?function=GLOBAL_QUOTE&symbol=$(stock_symbol)&apikey=$(api_key)&datatype=$(string(data_type))"
    api_call_result = http_get_call_with_url(url)
    if (typeof(api_call_result.value) == PSError)
        return api_call_result
    end

    #check that result value is a string
    #this is also new but doesn't change between time periods
    if (typeof(api_call_result.value) isa String == false)
        println("Call result is not valid type")    #error from not correct data output
    else
        api_call_raw_data = api_call_result.value
    end

    # call to logger
    if logger !== nothing
        log_api_call(logger, user_model, url)
    end

    # parse json if data called as a .json
    if (data_type == :json)
        
        # process json
        data_series_key = "Global Quote"
        return process_raw_json_data_sts_global_quote(api_call_raw_data, data_series_key)

    elseif (data_type == :csv)
        
        #return process .csv
        return process_raw_csv_api_data(api_call_raw_data)
    else
        
        # tell user they requested an unsupported type of data
        error_message = "$(data_type) isn't supported by AlphaVantage. Supported values are {:json, :csv}"
        return PSResult{PSError}(PSError(error_message))
    end
end