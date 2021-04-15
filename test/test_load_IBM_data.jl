using PooksoftAlphaVantageDataStore
using JSON

# ok, so lets build by user object -
my_current_dir = pwd()   # where am I?
path_to_data_file = my_current_dir*"/test/data/IBM-Intraday-04-14-2021.json"

# load -
json_dictionary = JSON.parsefile(path_to_data_file)