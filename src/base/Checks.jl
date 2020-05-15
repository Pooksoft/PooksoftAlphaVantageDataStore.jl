function is_path_valid(path_to_file::String)::PSResult{Bool}

    # the config file should be a json file, and should be reachable -
    # TODO: fill me in ...
    return PSResult{Bool}(true)
end

function is_string_empty(raw_string::String)::PSResult{Bool}

    # if we have an empty string - return true
    if isempty(raw_string) == true
        return PSResult{Bool}(true)
    end

    # default Return is flase -
    return PSResult{Bool}(false)
end

function check_missing_api_key(user_model::PSUserModel)::(Union{T, Nothing} where T<:Any)

    # do we have the alpha_vantage_api_key -
    if (hasfield(PSUserModel, :alphavantage_api_key) == false)
        # throw -
        return PSResult{PSError}(PSError("user model is missing API key information"))
    end

    # get the key -
    api_key = user_model.alphavantage_api_key

    # check -
    if (isempty(api_key) == true)

        # formulate an error message -
        error_message = "the API key is empty in the user model"

        # throw -
        return PSResult{PSError}(PSError(error_message))
    end

    #
    return nothing
end

function check_missing_symbol(stock_symbol::String)::(Union{T, Nothing} where T<:Any)

    if (isempty(stock_symbol) == true)

        # formulate an error message -
        error_message = "missing stock symbol"

        # throw -
        return PSResult{PSError}(PSError(error_message))
    end

    # return nothing -
    return nothing
end

function check_json_api_return_data(api_call_raw_data::String)::(Union{T, Nothing} where T<:Any)

    # well formed JSON?
    if is_valid_json(api_call_raw_data).value == false
        return PSError("invalid JSON $(api_call_raw_data)")
    end

    # need to check to see if legit data is coming back from the service -
    api_data_dictionary = JSON.parse(api_call_raw_data)
    if (haskey(api_data_dictionary,"Error Message") == true)

        # grab the error mesage -
        error_message = api_data_dictionary["Error Message"]

        # throw -
        return PSResult{PSError}(PSError(error_message))
    end

    # need to check - are we hitting the API call limit?
    if (haskey(api_data_dictionary,"Note") == true)

        # grab the error mesage -
        error_message = api_data_dictionary["Note"]

        # throw -
        return PSResult{PSError}(PSError(error_message))
    end

    # default -
    return nothing
end

function check_user_model(user_model::PSUserModel)::(Union{T, Nothing} where T<:Any)
    return PSResult{Bool}(true)
end


"""
    _is_valid_json(raw_string)->Bool

Checks to see if the input `string` is a valid JSON structure.
Returns `true` indicating valid JSON, `false` otherwise.
"""
function is_valid_json(raw_string::String)::PSResult{Bool}

    # check: do we have an empty string?
    if (is_string_empty(raw_string).value == true)
        return PSResult{Bool}(false)
    end

    # otherwise, to check to see if the string is valid JSON, try to
    # parse it.
    try
        JSON.parse(raw_string)
        return PSResult{Bool}(true)
    catch
        return PSResult{Bool}(false)
    end
end
