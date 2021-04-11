"""
    execute_company_earnings_api_call(requestDictionary::Dict{String,Any}; 
        logger::Union{Nothing,AbstractLogger} = nothing) -> PSResult
"""
function execute_company_earnings_api_call(requestDictionary::Dict{String,Any}; 
    logger::Union{Nothing,AbstractLogger} = nothing)::PSResult

    # initialize -
    api_call_url_string = ""
    required_api_keys = [
        "symbol"        ;   # ticker symbol -
        "function"      ;   # what function are we doing?
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

        # if we get here, we have valid JSON. Build dictionary -
        return process_raw_json_fundamentals_earnings_data(response_body_string)
    catch error
        return PSResult(error)
    end
end


