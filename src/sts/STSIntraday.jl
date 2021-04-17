"""
    execute_sts_intraday_api_call(requestDictionary::Dict{String,Any}; 
        logger::Union{Nothing,AbstractLogger} = nothing) -> PSResult

The best method description ever will go here. It will be amazing. 
"""
function execute_sts_intraday_api_call(requestDictionary::Dict{String,Any}; 
    logger::Union{Nothing,AbstractLogger} = nothing)::PSResult

    # initialize -
    api_call_url_string = ""
    required_api_keys = [
        "symbol"        ;   # ticker symbol -
        "function"      ;   # what function are we doing?
        "interval"      ;   # what interval do we need?
        "apikey"        ;   # the API key
        "adjusted"      ;   # whether data is adjsuted or raw (default: true)
        "outputsize"    ;   # Strings compact (default) and full are accepted: compact returns only the latest 100 data points in the intraday time series; full returns the full-length intraday time series. 
        "datatype"      ;   # what type of data is returned from API. Default: json
    ]

    try

        # ok, before we get too far, we need to check for the optional data in the requestDictionary -
        if (haskey(requestDictionary,"adjusted") == false)
            requestDictionary["adjusted"] = "true"
        end

        # outputsize -
        if (haskey(requestDictionary,"outputsize") == false)
            requestDictionary["outputsize"] = "compact"
        end

        # datatype -
        if (haskey(requestDictionary,"datatype") == false)
            requestDictionary["datatype"] = "json"
        end

        # get stuff from the requestDictionary and build the url used in the call -
        api_call_url_string = "$(alphavantage_api_url_string)?"
        for (index,key) in enumerate(required_api_keys)
            value = requestDictionary[key]
            if (index == 1)
                api_call_url_string*="$(key)=$(value)"
            else
                api_call_url_string*="&$(key)=$(value)"
            end            
        end
 
        # make the API call -
        api_call_result = http_get_call_with_url(api_call_url_string)
        response_body_string = checkresult(api_call_result)

        # ok, we process the response body differently depending upon json -or- csv type -
        data_type = requestDictionary["datatype"]
        if (Symbol(data_type) == :csv)
            return process_raw_csv_api_data(response_body_string)
        elseif (Symbol(data_type) == :json)
            return process_raw_json_sts_intraday_data(response_body_string)
        else
            throw(PSError("unsupported datatype in request dictionary"))
        end
    catch error
        return PSResult(error)
    end
end