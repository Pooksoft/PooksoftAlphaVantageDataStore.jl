"""
execute_sts_monthly_api_call()
"""
function execute_sts_monthly_api_call(user_model::PSUserModel, stock_symbol::String; 
    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing)::(Union{PSResult{T}, Nothing} where T<:Any)

    # same error checks as daily api call
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

    #use alpha_vantage_api to access data change function to monthly in this case
    #change this line for different time periods
    url = "$(alphavantage_api_url_string)?function=TIME_SERIES_MONTHLy&symbol=$(stock_symbol)&apikey=$(api_key)&datatype=$(string(data_type))&outputsize=$(string(outputsize))"
    api_call_result = http_get_call_with_url(url)
    if (typeof(api_call_result.value) == PSError)
        return api_call_result
    end#keep the same as daily call

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
    if (data_type == :json)
        #process json
        #this string line should match the .json of the type we are calling
        data_series_key = "Monthly Time Series"
        return process_raw_json_api_data_sts(api_call_raw_data, data_series_key)

    elseif(data_type == :csv)
        return process_raw_csv_api_data(api_call_raw_data)
    else
        # formulate the error message -
        error_message = "$(data_type) is not supported. Supported values are {:json,:csv}"

        return PSResult{PSError}(PSError(error_message))
    end
end