using PooksoftAlphaVantageDataStore

# ok, so lets build by user object -
my_current_dir = pwd()   # where am I?
path_to_config_file = my_current_dir*"/test/configuration/Configuration.json"

# build the api user model -
user_model = build_api_user_model(path_to_config_file) |> checkresult

# setup call -
requestDictionary = Dict{String,Any}()
requestDictionary["apikey"] = user_model.alphavantage_api_key
requestDictionary["symbol"] = "ALLY"
requestDictionary["function"] = "TIME_SERIES_INTRADAY"
requestDictionary["interval"] = "30min"
requestDictionary["adjusted"] = "true"
requestDictionary["outputsize"] = "compact"
requestDictionary["datatype"] = "json"
api_call_result = execute_sts_intraday_api_call(requestDictionary)
df = checkresult(api_call_result)
