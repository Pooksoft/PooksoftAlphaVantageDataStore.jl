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
        "interval"      ;   # what interval: 1min, 5min, 15min, 30min, 60min, daily, weekly, monthly
        "time_period"   ;   # Number of data points used to calculate each moving average value. Positive integers are accepted (e.g., time_period=60, time_period=200)
        "series_type"   ;   # The desired price type in the time series. Four types are supported: close, open, high, low
        "datatype"      ;   # By default, datatype=json. Strings json and csv are accepted with the following specifications: json returns the daily time series in JSON format; csv returns the time series as a CSV (comma separated value) file.
        "apikey"        ;   # the API key
]
requestDictionary = Dict{String,Any}()
requestDictionary["apikey"] = user_model.alphavantage_api_key
requestDictionary["symbol"] = "ALLY"
requestDictionary["function"] = "EMA"
requestDictionary["interval"] = "daily"
requestDictionary["time_period"] = "14"
requestDictionary["series_type"] = "close"
requestDictionary["datatype"] = "json"
api_call_result = execute_exponential_moving_average_api_call(requestDictionary)
df = checkresult(api_call_result)
