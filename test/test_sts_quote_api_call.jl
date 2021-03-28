using PooksoftAlphaVantageDataStore

# ok, so lets build by user object -
my_current_dir = pwd()   # where am I?
path_to_config_file = my_current_dir*"/test/configuration/Configuration.json"

# build the api user model -
user_model = build_api_user_model(path_to_config_file) |> checkresult

# make an API call -
ticker_symbol = "ally"
data_type = :json
df = execute_sts_quote_api_call(user_model, ticker_symbol; data_type = data_type, logger=nothing) |> checkresult