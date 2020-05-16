# define constants here -
const alphavantage_api_url_string = "https://www.alphavantage.co/query"
const path_to_package = dirname(pathof(@__MODULE__))

# load offical packages here -
using DataFrames
using CSV
using HTTP
using JSON
using Dates
using Logging

# load my code -
include("./base/Types.jl")
include("./base/Network.jl")
include("./base/User.jl")
include("./base/Checks.jl")
include("./base/Log.jl")
include("./base/Handlers.jl")

# stock time series -
include("./sts/STSDaily.jl")
include("./sts/STSWeekly.jl")
include("./sts/STSMonthly.jl")