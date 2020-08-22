# -- PRIVATE METHODS HERE ------------------------------------------------------- #
function check_if_user_dictionary_contains_correct_keys(user_data_dictionary::Dict{String,Any})::PSResult{Bool}

    # the user dictionary should contain a user_data root, and a alpha_vantage_api_key child -
    # TODO: fill me in ...
    return PSResult{Bool}(true)
end


# -- PUBLIC METHODS HERE ------------------------------------------------------- #
"""
    build_api_user_model(path)

Returns either a PSResult{PSError} if something went wrong, or a PSResult{PSUserModel} object holding the user email and AlphaVantage API key.
The PSError and PSUserModel can be accessed using the `value` field on the Result return wrapper
"""
function build_api_user_model(path_to_configuration_file::String)::(Union{PSResult{T}, Nothing} where T<:Any)

    # some users checks -
    # did the user pass in a legit path?
    check_result = is_path_valid(path_to_configuration_file)
    if (typeof(check_result.value) == Bool && check_result.value == false)
        error_message = "error: $(path_to_configuration_file) in not a valid path"
        return PSResult{PSError}(PSError(error_message))
    end

    # ok, path seems legit - load the default user information from the config.json file -
    user_json_dictionary = JSON.parsefile(path_to_configuration_file)

    # does the user dictionary contain the correct keys?
    if (check_if_user_dictionary_contains_correct_keys(user_json_dictionary) == false)
        error_message = "error: missing keys in user configuration dictionary"
        return PSResult{PSError}(PSError(error_message))
    end

    # -- DO NOT EDIT BELOW THIS LINE ------------------------------------------#

    # grab the user data -
    alpha_vantage_api_key = user_json_dictionary["user_data"]["alpha_vantage_api_key"]
    alpha_vantage_api_email = user_json_dictionary["user_data"]["alpha_vantage_api_email"]

    # build APIUserModel -
    api_user_model = PSUserModel(alpha_vantage_api_email, alpha_vantage_api_key)

    # return the user_data_dictionary -
    return PSResult{PSUserModel}(api_user_model)
    # -------------------------------------------------------------------------#
end
