## PooksoftAlphaVantageDataStore.jl

### Introduction
``PooksoftAlphaVantageDataStore.jl`` is an application programming interface (API) for [AlphaVantage](https://www.alphavantage.co), a leading provider of realtime and historical stock, forex (FX) data, and digital/crypto currency data feeds written in the [Julia](https://julialang.org) programming language.

### Installation and Requirements
To install this package, open the [Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/), start the package mode press `]` to enter `pkg>` mode.
To install ``PooksoftAlphaVantageDataStore.jl``, issue the command:

    (@v1.4) pkg> add https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl.git

To use ``PooksoftAlphaVantageDataStore.jl`` in your project simply issue the command:

    julia> using PooksoftAlphaVantageDataStore

Function | Description
---: | ---
[build_api_user_model](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/base/User.jl) | Function to build a user model object
[execute_sts_daily_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSDaily.jl) | Download daily stock price information  
[execute_sts_adjusted_daily_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSDaily.jl) | Download adjusted daily stock price information
[execute_sts_weekly_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSWeekly.jl) | Download weekly stock price information  
[execute_sts_adjusted_weekly_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSWeekly.jl) | Download adjusted weekly stock price information
[execute_sts_monthly_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSMonthly.jl) | Download monthly stock price information  
[execute_sts_adjusted_monthly_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSMonthly.jl) | Download adjusted monthly stock price information
