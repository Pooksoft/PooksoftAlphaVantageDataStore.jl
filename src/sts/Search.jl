"""
    execute_sts_search_api_call(user_model::PSUserModel, keyword::String; 
        data_type::Symbol = :json, logger::Union{Nothing,AbstractLogger} = nothing) -> PSResult

This documentation will be awesome. the best description ever. 
"""
function execute_sts_search_api_call(user_model::PSUserModel, keyword::String; 
    data_type::Symbol = :json, logger::Union{Nothing,AbstractLogger} = nothing)::PSResult


    try

        # get key's and id -
        api_key = user_model.alphavantage_api_key

        # call to alpha_vantage_api to get data
        url = "$(alphavantage_api_url_string)?function=SYMBOL_SEARCH&keywords=$(keyword)&apikey=$(api_key)&datatype=$(string(data_type))"
        api_call_raw_data = http_get_call_with_url(url) |> checkresult

        # call to logger
        if (isnothing(logger) == false)
            log_api_call(logger, user_model, url)
        end

        # parse json if data called as a .json
        if (data_type == :json)
        
            # process json
            data_series_key = "bestMatches"
            return process_raw_json_data_sts_search_data(api_call_raw_data, data_series_key)

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