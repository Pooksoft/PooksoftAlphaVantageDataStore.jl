"""
    _include_my_codes(base_path::String, code_file_array::Array{String,1})

Function to include Julia files in a directory 
"""
function _include_my_codes(base_path::String, code_file_array::Array{String,1})
    for code_file in code_file_array
        path_to_code = joinpath(base_path,code_file)
        include(path_to_code)
    end
end

# define constants here -
const alphavantage_api_url_string = "https://www.alphavantage.co/query"
const path_to_package = dirname(pathof(@__MODULE__))
const _PATH_TO_BASE = joinpath(path_to_package,"base")
const _PATH_TO_STS = joinpath(path_to_package, "sts")
const _PATH_TO_TI = joinpath(path_to_package, "ti")
const _PATH_TO_CRYPTO = joinpath(path_to_package, "crypto")
const _PATH_TO_FUNDAMENTALS = joinpath(path_to_package, "fundamentals")

# load offical packages here -
using DataFrames
using CSV
using HTTP
using JSON
using Dates
using Logging
using Reexport
@reexport using PooksoftBase

# need to update this syntax -
# load my base codes -
my_base_codes = [
    "Types.jl", "Network.jl", "User.jl", "Checks.jl", 
    "Log.jl", "Handlers.jl", "Filesystem.jl", "Datastore.jl"
];
_include_my_codes(_PATH_TO_BASE, my_base_codes)

# stock time series -
my_sts_codes = [
    "STSDaily.jl", "STSWeekly.jl", "STSMonthly.jl", "Quote.jl", "Search.jl"
]
_include_my_codes(_PATH_TO_STS, my_sts_codes)

# technical indicators -
my_ti_codes = [
    "SMA.jl", "EMA.jl", "RSI.jl"
]
_include_my_codes(_PATH_TO_TI, my_ti_codes)

# fundementals -
my_fundamental_codes = [
    "Overview.jl"
]
_include_my_codes(_PATH_TO_FUNDAMENTALS, my_fundamental_codes)