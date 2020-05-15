using PooksoftAlphaVantageDataStore
using Test
using JSON
using DataFrames

# -- User creation tests ------------------------------------------------------- #
function build_api_user_model_test()

    # initialize -
    my_current_dir = pwd()   # where am I?
    path_to_config_file = my_current_dir*"/configuration/Configuration.json"

    # build the api user model -
    user_model_result = build_api_user_model(path_to_config_file)
    if (typeof(user_model_result.value) == PSError)
        return false
    end

    user_model = user_model_result.value
    user_email = user_model.alphavantage_api_email

    # is the user email the same as in Configuration.json?
    user_json_dictionary = JSON.parsefile(path_to_config_file)
    alpha_vantage_api_email = user_json_dictionary["user_data"]["alpha_vantage_api_email"]
    if (user_email == alpha_vantage_api_email)
        return true
    end

    # return -
    return false
end

function download_daily_appl_sts_test()

    # initialize -
    my_current_dir = pwd()   # where am I?
    path_to_config_file = my_current_dir*"/configuration/Configuration.json"

    # build the api user model -
    user_model_result = build_api_user_model(path_to_config_file)
    if (typeof(user_model_result.value) == PSError)
        return false
    end

    # get the user model, we'll need this to make an API call -
    user_model = user_model_result.value

    # make an API call -
    stock_symbol = "aapl"
    data_type = :json
    outputsize = :compact
    api_call_result = execute_sts_daily_api_call(user_model, stock_symbol; data_type = data_type, outputsize = outputsize, logger=nothing)

    # check -
    if (typeof(api_call_result.value) == DataFrame)
        return true
    end

    # return -
    return false
end
#------------------------------------------------------------------------------- #

@testset "user_test_set" begin
    @test build_api_user_model_test() == true
    @test download_daily_appl_sts_test() == true
end