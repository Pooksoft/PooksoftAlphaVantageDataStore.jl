using PooksoftAlphaVantageDataStore

# ok, so lets build by user object -
my_current_dir = pwd()   # where am I?
path_to_config_file = my_current_dir*"/test/configuration/Configuration.json"

# build the api user model -
user_model = build_api_user_model(path_to_config_file) |> checkresult

# make an API call -
stock_symbol = "aapl"
data_type = :json
outputsize = :compact
df = execute_sts_monthly_api_call(user_model, stock_symbol; data_type = data_type, outputsize = outputsize, logger=nothing) |> checkresult