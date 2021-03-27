![CI](https://github.com/Pooksoft/PooksoftOptionsKit.jl/workflows/CI/badge.svg)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://pooksoft.github.io/PooksoftAlphaVantageDataStore.jl/dev/)
![GitHub](https://img.shields.io/github/license/pooksoft/PooksoftAlphaVantageDataStore.jl)

## Introduction
``PooksoftAlphaVantageDataStore.jl`` is an application programming interface (API) for [AlphaVantage](https://www.alphavantage.co), a leading provider of realtime and historical stock, forex (FX) data, and digital/crypto currency data feeds written in the [Julia](https://julialang.org) programming language.

## Installation and Requirements
``PooksoftAlphaVantageDataStore.jl`` can be installed, updated, or removed using the [Julia package management system](https://docs.julialang.org/en/v1/stdlib/Pkg/). To access the package management interface, open the [Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/), and start the package mode by pressing `]`.
While in package mode, to install ``PooksoftAlphaVantageDataStore.jl``, issue the command:

    (@v1.6) pkg> add PooksoftAlphaVantageDataStore

To use ``PooksoftAlphaVantageDataStore.jl`` in your project issue the command:

    julia> using PooksoftAlphaVantageDataStore

## Utility functions
The utility functions construct two important composite data types, [PSUserModel](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/base/Types.jl) which encapsulates information about your [AlphaVantage](https://www.alphavantage.co) account and [PSDataStoreAPICallModel](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/base/Types.jl) which can be used along with the high-level interface to make [AlphaVantage](https://www.alphavantage.co) application programming interface (API) calls. 

Utility functions:
* [build_api_user_model](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/base/User.jl) | Function to build a user model object which requires an [AlphaVantage API key](https://www.alphavantage.co/support/#api-key)
* [build_datastore_apicall_model](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/base/Datastore.jl) | Utility function to build an api call model which is required for the high-level api call interface. This function returns a [PSDataStoreAPICallModel](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/base/Types.jl) object wrapped in a ``PSResult`` type; the [PSDataStoreAPICallModel](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/base/Types.jl) object can be accessed from the ``value`` field of the ``PSResult`` type. 

## Stock Time Series (STS) functions (low-level interface)
STS functions allow the user to download daily, weekly or monthly stock price data (or adjusted data) with a frequency depending upon your [AlphaVantage](https://www.alphavantage.co/support/#support) account privileges. These functions take the form:

    execute_sts_{*}_api_call

where `{*}` denotes the time frame for the data.

* [execute_sts_daily_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSDaily.jl) | Download daily stock price information 
* [execute_sts_adjusted_daily_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSDaily.jl) | Download adjusted daily stock price information
* [execute_sts_weekly_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSWeekly.jl) | Download weekly stock price information  
* [execute_sts_adjusted_weekly_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSWeekly.jl) | Download adjusted weekly stock price information
* [execute_sts_monthly_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSMonthly.jl) | Download monthly stock price information  
* [execute_sts_adjusted_monthly_api_call](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/sts/STSMonthly.jl) | Download adjusted monthly stock price information

## Stock Time Series (STS) functions (high-level interface)
There is also a high-level interface that calls the low-level functions. The high-level interface has the convenience function:

    execute_api_call

which takes a [PSUserModel](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/base/Types.jl) and a [PSDataStoreAPICallModel](https://github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl/blob/master/src/base/Types.jl) object, along with an optional [logger](https://github.com/kmsquire/Logging.jl) instance. Use the help system at the julia prompt for additional information on the ``execute_api_call`` function. 
