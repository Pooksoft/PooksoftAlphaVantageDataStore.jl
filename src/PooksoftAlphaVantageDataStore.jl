module PooksoftAlphaVantageDataStore

# include -
include("Include.jl")

# export functions -
# low-level functions -
export log_api_call
export execute_sts_daily_api_call
export execute_sts_adjusted_daily_api_call
export execute_sts_weekly_api_call
export execute_sts_adjusted_weekly_api_call
export execute_sts_monthly_api_call
export execute_sts_adjusted_monthly_api_call
export execute_sts_quote_api_call
export execute_sts_search_api_call
export execute_simple_moving_average_api_call
export execute_exponential_moving_average_api_call
export execute_relative_strength_index_api_call
export execute_company_overview_api_call
export execute_company_earnings_api_call

# high-level functions -
export build_api_user_model
export build_datastore_apicall_model
export execute_api_call

# read/write -
export write_data_to_filestore
export read_data_from_filestore

# export types -
export PSUserModel
export PSDataStoreAPICallModel

end # module
