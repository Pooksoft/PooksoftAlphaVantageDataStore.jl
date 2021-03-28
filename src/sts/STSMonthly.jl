"""
    execute_sts_monthly_api_call(user_model::PSUserModel, stock_symbol::String; 
        data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing) -> PSResult

Stuff will go here. Awesome stuff, the most beautiful stuff ever.
"""
function execute_sts_monthly_api_call(user_model::PSUserModel, stock_symbol::String; 
    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing)::PSResult

    try

        # get key's and id -
        api_key = user_model.alphavantage_api_key

        # use alpha_vantage_api to access data change function to monthly in this case
        # change this line for different time periods
        url = "$(alphavantage_api_url_string)?function=TIME_SERIES_MONTHLy&symbol=$(stock_symbol)&apikey=$(api_key)&datatype=$(string(data_type))&outputsize=$(string(outputsize))"
        api_call_raw_data = http_get_call_with_url(url) |> checkresult
    
        # call to logger if we have one -
        if (isnothing(logger) == false)
            log_api_call(logger, user_model, url)
        end

        # call a different method depending upon data type -
        if (data_type == :json)
            
            # process json
            data_series_key = "Monthly Time Series"
            return process_raw_json_api_data_sts(api_call_raw_data, data_series_key)
        elseif (data_type == :csv)
            
            # process csv results -
            return process_raw_csv_api_data(api_call_raw_data)
        else
            
            # formulate the error message -
            error_message = "$(data_type) is not supported. Supported values are {:json,:csv}"
            return PSResult{PSError}(PSError(error_message))
        end

    catch error
        return PSResult(error)
    end    
end

"""
    execute_sts_adjusted_monthly_api_call(user_model::PSUserModel, stock_symbol::String; 
        data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing) -> PSResult

Stuff will go here. Awesome stuff, the most beautiful stuff ever.
"""
function execute_sts_adjusted_monthly_api_call(user_model::PSUserModel, stock_symbol::String; 
    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing)::PSResult

    try
        
        # get key's and id -
        api_key = user_model.alphavantage_api_key

        # use alpha_vantage_api to access data change function to monthly in this case
        # change this line for different time periods
        url = "$(alphavantage_api_url_string)?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=$(stock_symbol)&apikey=$(api_key)&datatype=$(string(data_type))&outputsize=$(string(outputsize))"
        api_call_raw_data = http_get_call_with_url(url) |> checkresult
        
        # call to logger
        if (isnothing(logger) == false)
            log_api_call(logger, user_model, url)
        end

        if (data_type == :json)
        
            # process json
            # this string line should match the .json of the type we are calling
            data_series_key = "Monthly Adjusted Time Series"
            return process_raw_json_api_data_sts_adjusted(api_call_raw_data, data_series_key)
    
        elseif (data_type == :csv)
            return process_raw_csv_api_data(api_call_raw_data)
        else
            # formulate the error message -
            error_message = "$(data_type) is not supported. Supported values are {:json,:csv}"
            return PSResult{PSError}(PSError(error_message))
        end
        
    catch error
        return PSResult(error)
    end 
end