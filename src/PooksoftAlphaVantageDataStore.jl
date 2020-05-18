module PooksoftAlphaVantageDataStore

# include -
include("Include.jl")

# export functions -
export build_api_user_model
export log_api_call
export execute_sts_daily_api_call
export execute_sts_adjusted_daily_api_call
export execute_sts_weekly_api_call
export execute_sts_adjusted_weekly_api_call
export execute_sts_monthly_api_call
export execute_sts_adjusted_monthly_api_call

export write_data_to_filestore
export read_data_from_filestore

# export types -
export PSResult
export PSUserModel
export PSError

end # module
