module PooksoftAlphaVantageDataStore

# include -
include("Include.jl")

# export functions -
"""
    build_api_user_model(path)

Takes a `path` string which points to a JSON configuration file.
Returns either a Result{PSError} if something went wrong, or a Result{PSUserModel} object holding the user email and AlphaVantage API key.
The PSError and PSUserModel can be accessed using the `value` field on the PSResult return wrapper
"""
export build_api_user_model
export log_api_call


"""
    execute_sts_daily_api_call()
"""
export execute_sts_daily_api_call

"""
    execute_sts_adjusted_daily_api_call()
"""
export execute_sts_adjusted_daily_api_call

"""
    execute_sts_weekly_api_call()
"""
export execute_sts_weekly_api_call

"""
    execute_sts_adjusted_weekly_api_call()
"""
export execute_sts_adjusted_weekly_api_call

"""
    execute_sts_monthly_api_call()
"""
export execute_sts_monthly_api_call


# export types -
export PSResult
export PSUserModel
export PSError

end # module
