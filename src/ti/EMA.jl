"""
    execute_exponential_moving_average_api_call(requestDictionary::Dict{String,Any}; 
        logger::Union{Nothing,AbstractLogger} = nothing) -> PSResult

Something magical will go here. It will be awesome. The best ever. amazing
"""
function execute_exponential_moving_average_api_call(requestDictionary::Dict{String,Any}; 
    logger::Union{Nothing,AbstractLogger} = nothing)::PSResult

    # initialize -
    api_call_url_string = ""
    required_api_keys = [
        "symbol"        ;   # ticker symbol -
        "function"      ;   # what function are we doing?
        "interval"      ;   # what interval: 1min, 5min, 15min, 30min, 60min, daily, weekly, monthly
        "time_period"   ;   # Number of data points used to calculate each moving average value. Positive integers are accepted (e.g., time_period=60, time_period=200)
        "series_type"   ;   # The desired price type in the time series. Four types are supported: close, open, high, low
        "datatype"      ;   # By default, datatype=json. Strings json and csv are accepted with the following specifications: json returns the daily time series in JSON format; csv returns the time series as a CSV (comma separated value) file.
        "apikey"        ;   # the API key
    ]

    try 

        # get stuff from the requestDictionary and build the url used in the call -
        api_call_url_string = "$(alphavantage_api_url_string)?"
        for key in required_api_keys
            value = requestDictionary[key]
            api_call_url_string*="&$(key)=$(value)"
        end

        # make the API call -
        api_call_result = http_get_call_with_url(api_call_url_string)
        response_body_string = checkresult(api_call_result)

        # ok, we process the response body differently depending upon json -or- csv type -
        data_type = requestDictionary["datatype"]
        if (Symbol(data_type) == :csv)
            return process_raw_csv_api_data(response_body_string)
        elseif (Symbol(data_type) == :json)
            data_series_key = "Technical Analysis: EMA"
            return process_raw_json_data_ti_ema_data(response_body_string, data_series_key)
        else
            throw(PSError("unsupported datatype in request dictionary"))
        end

    catch error
        return PSResult(error)
    end
end