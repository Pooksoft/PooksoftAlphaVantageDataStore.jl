## PooksoftAlphaVantageDataStore.jl

### Introduction
``PooksoftAlphaVantageDataStore.jl`` is an application programming interface (API) for [AlphaVantage](https://www.alphavantage.co), a leading provider of realtime and historical stock, forex (FX) data, and digital/crypto currency data feeds written in the [Julia](https://julialang.org) programming language.

### Installation and Requirements
To install this package, open the [Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/), start the package mode press `]` to enter `pkg>` mode.
To install ``PooksoftAlphaVantageDataStore.jl``, issue the command:

    (@v1.4) pkg> add https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl.git

To use ``PooksoftAlphaVantageDataStore.jl`` in your project simply issue the command:

    julia> using PooksoftAlphaVantageDataStore

### Utility functions
* [build_api_user_model](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/base/User.jl) | Function to build a user model object which requires an [AlphaVantage API key](https://www.alphavantage.co/support/#api-key)

### Stock Time Series (STS) functions
STS functions allow the user to download daily, weekly or monthly stock price data (or adjusted data) with a frequency depending upon your [AlphaVantage](https://www.alphavantage.co/support/#support) account privileges. These functions take the form:

    execute_sts_{*}_api_call

where `{*}` denotes the time frame for the data.

* [execute_sts_daily_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSDaily.jl) | Download daily stock price information 
* [execute_sts_adjusted_daily_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSDaily.jl) | Download adjusted daily stock price information
* [execute_sts_weekly_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSWeekly.jl) | Download weekly stock price information  
* [execute_sts_adjusted_weekly_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSWeekly.jl) | Download adjusted weekly stock price information
* [execute_sts_monthly_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSMonthly.jl) | Download monthly stock price information  
* [execute_sts_adjusted_monthly_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSMonthly.jl) | Download adjusted monthly stock price information
