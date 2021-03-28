"""
    execute_sts_daily_api_call(user_model::PSUserModel, ticker_symbol::String; 
        data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing) -> PSResult

Stuff will go here. Awesome stuff, the most beautiful stuff ever.  
"""
function execute_sts_daily_api_call(user_model::PSUserModel, ticker_symbol::String; 
    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing)::PSResult

    try 

        # get key's and id -
        api_key = user_model.alphavantage_api_key

        # use the alpha_vantage_api to download the data -
        url = "$(alphavantage_api_url_string)?function=TIME_SERIES_DAILY&symbol=$(ticker_symbol)&apikey=$(api_key)&datatype=$(string(data_type))&outputsize=$(string(outputsize))"
        api_call_raw_data = http_get_call_with_url(url) |> checkresult
    
        # log if we have one -
        if (isnothing(logger) == false)
            log_api_call(logger, user_model, url)
        end

        # make the handler calls, depending upon the data type -
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

    catch error
        return PSResult(error)
    end
end

"""
    execute_sts_adjusted_daily_api_call(user_model::PSUserModel, ticker_symbol::String; 
        data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing) -> PSResult

Stuff will go here. Awesome stuff, the most beautiful stuff ever.
"""
function execute_sts_adjusted_daily_api_call(user_model::PSUserModel, ticker_symbol::String; 
    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing)::PSResult
    

    try 

        # get key's and id -
        api_key = user_model.alphavantage_api_key

        # call to alpha_vantage_api to get data
        url = "$(alphavantage_api_url_string)?function=TIME_SERIES_DAILY_ADJUSTED&symbol=$(ticker_symbol)&apikey=$(api_key)&datatype=$(string(data_type))&outputsize=$(string(outputsize))"
        api_call_raw_data = http_get_call_with_url(url) |> checkresult

        # call to logger
        if (isnothing(logger) == false)
            log_api_call(logger, user_model, url)
        end

        # parse json if data called as a .json
        if (data_type == :json)
        
            # process json
            data_series_key = "Time Series (Daily)"
            return process_raw_json_api_data_sts_daily_adjusted(api_call_raw_data, data_series_key)

        elseif (data_type == :csv)
        
            # return process .csv
            return process_raw_csv_api_data(api_call_raw_data)
        
        else
        
            # tell user they requested an unsupported type of data
            error_message = "$(data_type) isn't supported by AlphaVantage. Supported values are {:json, :csv}"
            return PSResult{PSError}(PSError(error_message))
        end

    catch error
        return PSResult(error)
    end
end
