using PooksoftAlphaVantageDataStore
using Test
using JSON
using DataFrames

# -- User creation/low level download tests --------------------------------------------- #
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


function download_daily_appl_sts_test_low_level()

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

function download_daily_adjusted_appl_sts_test_low_level()

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
    api_call_result = execute_sts_adjusted_daily_api_call(user_model, stock_symbol; data_type = data_type, outputsize = outputsize, logger=nothing)

    # check -
    if (typeof(api_call_result.value) == DataFrame)
        return true
    end

    # return -
    return false
end

function download_weekly_adjusted_appl_sts_test_low_level()

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
    api_call_result = execute_sts_adjusted_weekly_api_call(user_model, stock_symbol; data_type = data_type, outputsize = outputsize, logger=nothing)

    # check -
    if (typeof(api_call_result.value) == DataFrame)
        return true
    end

    # return -
    return false
end

function download_weekly_appl_sts_test_low_level()

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
    api_call_result = execute_sts_weekly_api_call(user_model, stock_symbol; data_type = data_type, outputsize = outputsize, logger=nothing)

    # check -
    if (typeof(api_call_result.value) == DataFrame)
        return true
    end

    # return -
    return false
end

function download_monthly_adjusted_appl_sts_test_low_level()

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
    api_call_result = execute_sts_adjusted_monthly_api_call(user_model, stock_symbol; data_type = data_type, outputsize = outputsize, logger=nothing)

    # check -
    if (typeof(api_call_result.value) == DataFrame)
        return true
    end

    # return -
    return false
end

function download_monthly_appl_sts_test_low_level()

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
    api_call_result = execute_sts_monthly_api_call(user_model, stock_symbol; data_type = data_type, outputsize = outputsize, logger=nothing)

    # check -
    if (typeof(api_call_result.value) == DataFrame)
        return true
    end

    # return -
    return false
end
#---------------------------------------------------------------------------------------- #

# -- User creation/high level download tests -------------------------------------------- #

function download_daily_appl_sts_test_high_level()

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

    # setup the API call -
    stock_symbol = "aapl"
    data_type = :json
    outputsize = :compact
    call = execute_sts_adjusted_daily_api_call
    apicall_model = build_datastore_apicall_model(call,stock_symbol; output=outputsize, datatype=data_type)
    if (isa(apicall_model.value, PSDataStoreAPICallModel) == false)
        return false
    end

    # make the apicall -
    api_call_result = execute_api_call(user_model, apicall_model.value)

    # check -
    if (isa(api_call_result.value,DataFrame) == true)
        return true
    end

    # return -
    return false
end 
#---------------------------------------------------------------------------------------- # 

@testset "user_test_set" begin
    # @test build_api_user_model_test_low_level() == true
    # @test download_daily_appl_sts_test_low_level() == true
    # @test download_daily_adjusted_appl_sts_test_low_level() == true
    @test download_weekly_appl_sts_test_low_level() == true
    @test download_weekly_adjusted_appl_sts_test_low_level() == true
    @test download_monthly_appl_sts_test_low_level() == true
    
    # sleep(60)   # wait 1 min -
    # @test download_monthly_adjusted_appl_sts_test_low_level() == true
    @test download_daily_appl_sts_test_high_level() == true
end

