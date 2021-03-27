# define constants here -
const alphavantage_api_url_string = "https://www.alphavantage.co/query"
const path_to_package = dirname(pathof(@__MODULE__))
const _PATH_TO_BASE = joinpath(path_to_package,"base")
const _PATH_TO_STS = joinpath(path_to_package, "base") 

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
# load my code -
include("./base/Types.jl")
include("./base/Network.jl")
include("./base/User.jl")
include("./base/Checks.jl")
include("./base/Log.jl")
include("./base/Handlers.jl")
include("./base/Filesystem.jl")
include("./base/Datastore.jl")

# stock time series -
include("./sts/STSDaily.jl")
include("./sts/STSWeekly.jl")
include("./sts/STSMonthly.jl")
include("./sts/Quote.jl")
include("./sts/Search.jl")

# technical indicators -
include("./ti/SMA.jl")
include("./ti/EMA.jl")
include("./ti/RSI.jl")