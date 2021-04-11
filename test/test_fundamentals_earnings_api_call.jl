using PooksoftAlphaVantageDataStore

# ok, so lets build by user object -
my_current_dir = pwd()   # where am I?
path_to_config_file = my_current_dir*"/test/configuration/Configuration.json"

# build the api user model -
user_model_result = build_api_user_model(path_to_config_file)
user_model = checkresult(user_model_result)

# now that we have the userModel - lets populate the request dictionary -
required_api_keys = [
        "symbol"        ;   # ticker symbol -
        "function"      ;   # what function are we doing?
        "apikey"        ;   # the API key
]
requestDictionary = Dict{String,Any}()
requestDictionary["apikey"] = user_model.alphavantage_api_key
requestDictionary["symbol"] = "ALLY"
requestDictionary["function"] = "OVERVIEW"
api_call_result = execute_company_overview_api_call(requestDictionary)
df = checkresult(api_call_result)