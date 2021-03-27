var documenterSearchIndex = {"docs":
[{"location":"#Introduction","page":"Introduction","title":"Introduction","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"This package encodes a set of Julia functions to download data from the AlphaVantage financial data application programming interface (API). This package assumes you have login credentials for the AlphaVantage API.","category":"page"},{"location":"#Installation-Requirements","page":"Introduction","title":"Installation Requirements","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"PooksoftAlphaVantageDataStore.jl can be installed, updated, or removed using the Julia package management system. To access the package management interface, open the Julia REPL, and start the package mode by pressing ]. While in package mode, to install PooksoftAlphaVantageDataStore.jl, issue the command:","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"(@v1.6) pkg> add PooksoftAlphaVantageDataStore","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"Required packages will be downloaded and installed for you automatically. ","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"To use PooksoftAlphaVantageDataStore.jl in your projects issue the command:","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"julia> using PooksoftAlphaVantageDataStore","category":"page"},{"location":"#Package-Organization","page":"Introduction","title":"Package Organization","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"Functions of PooksoftAlphaVantageDataStore.jl are organized around each of the category areas of the  AlphaVantage application programming interface. The current version of  PooksoftAlphaVantageDataStore.jl implements functions that wrap the Stock Time Series (STS) methods of AlphaVantage. ","category":"page"},{"location":"#Disclaimer","page":"Introduction","title":"Disclaimer","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"PooksoftAlphaVantageDataStore.jl is offered solely for training and  informational purposes. No offer or solicitation to buy or sell securities or securities derivative products of any kind, or any type of investment or trading advice or strategy,  is made, given or in any manner endorsed by Pooksoft. ","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"Trading involves risk. Carefully review your financial situation before investing in securities, futures contracts, options or commodity interests. Past performance, whether actual or indicated by historical tests of strategies, is no guarantee of future performance or success. Trading is generally not appropriate for someone with limited resources, investment or trading experience, or a low-risk tolerance.  Only risk capital that will not be needed for living expenses.","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"You are fully responsible for any investment or trading decisions you make, and such decisions should be based solely on your evaluation of your financial circumstances, investment or trading objectives, risk tolerance and liquidity needs. ","category":"page"},{"location":"utility/#Utility-functions","page":"Utility functions","title":"Utility functions","text":"","category":"section"},{"location":"execute_sts_adjusted_monthly_api_call/#Adjusted-Time-Series-Monthly","page":"Adjusted Time Series Monthly","title":"Adjusted Time Series Monthly","text":"","category":"section"},{"location":"execute_sts_adjusted_monthly_api_call/","page":"Adjusted Time Series Monthly","title":"Adjusted Time Series Monthly","text":"execute_sts_adjusted_monthly_api_call","category":"page"},{"location":"execute_sts_adjusted_monthly_api_call/#PooksoftAlphaVantageDataStore.execute_sts_adjusted_monthly_api_call","page":"Adjusted Time Series Monthly","title":"PooksoftAlphaVantageDataStore.execute_sts_adjusted_monthly_api_call","text":"execute_sts_adjusted_monthly_api_call(user_model::PSUserModel, stock_symbol::String; \n    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing) -> (Union{PSResult{T}, Nothing} where T<:Any)\n\nStuff will go here. Awesome stuff, the most beautiful stuff ever.\n\n\n\n\n\n","category":"function"},{"location":"execute_sts_daily_api_call/#Time-Series-Daily","page":"Time Series Daily","title":"Time Series Daily","text":"","category":"section"},{"location":"execute_sts_daily_api_call/","page":"Time Series Daily","title":"Time Series Daily","text":"execute_sts_daily_api_call","category":"page"},{"location":"execute_sts_daily_api_call/#PooksoftAlphaVantageDataStore.execute_sts_daily_api_call","page":"Time Series Daily","title":"PooksoftAlphaVantageDataStore.execute_sts_daily_api_call","text":"execute_sts_daily_api_call(user_model::PSUserModel, ticker_symbol::String; \n    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing) -> (Union{PSResult{T}, Nothing} where T<:Any)\n\nStuff will go here. Awesome stuff, the most beautiful stuff ever.  \n\n\n\n\n\n","category":"function"},{"location":"execute_sts_monthly_api_call/#Time-Series-Monthly","page":"Time Series Monthly","title":"Time Series Monthly","text":"","category":"section"},{"location":"execute_sts_monthly_api_call/","page":"Time Series Monthly","title":"Time Series Monthly","text":"execute_sts_monthly_api_call","category":"page"},{"location":"execute_sts_monthly_api_call/#PooksoftAlphaVantageDataStore.execute_sts_monthly_api_call","page":"Time Series Monthly","title":"PooksoftAlphaVantageDataStore.execute_sts_monthly_api_call","text":"execute_sts_monthly_api_call(user_model::PSUserModel, stock_symbol::String; \n    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing) -> (Union{PSResult{T}, Nothing} where T<:Any)\n\nStuff will go here. Awesome stuff, the most beautiful stuff ever.\n\n\n\n\n\n","category":"function"},{"location":"execute_sts_weekly_api_call/#Time-Series-Weekly","page":"Time Series Weekly","title":"Time Series Weekly","text":"","category":"section"},{"location":"execute_sts_weekly_api_call/","page":"Time Series Weekly","title":"Time Series Weekly","text":"execute_sts_weekly_api_call","category":"page"},{"location":"execute_sts_weekly_api_call/#PooksoftAlphaVantageDataStore.execute_sts_weekly_api_call","page":"Time Series Weekly","title":"PooksoftAlphaVantageDataStore.execute_sts_weekly_api_call","text":"execute_sts_weekly_api_call(user_model::PSUserModel, stock_symbol::String; \n    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing, AbstractLogger} = nothing) -> (Union{PSResult{T}, Nothing} where T<:Any)\n\nStuff will go here. Awesome stuff, the most beautiful stuff ever.\n\n\n\n\n\n","category":"function"},{"location":"execute_sts_adjusted_weekly_api_call/#Adjusted-Time-Series-Weekly","page":"Adjusted Time Series Weekly","title":"Adjusted Time Series Weekly","text":"","category":"section"},{"location":"execute_sts_adjusted_weekly_api_call/","page":"Adjusted Time Series Weekly","title":"Adjusted Time Series Weekly","text":"execute_sts_adjusted_weekly_api_call","category":"page"},{"location":"execute_sts_adjusted_weekly_api_call/#PooksoftAlphaVantageDataStore.execute_sts_adjusted_weekly_api_call","page":"Adjusted Time Series Weekly","title":"PooksoftAlphaVantageDataStore.execute_sts_adjusted_weekly_api_call","text":"execute_sts_adjusted_weekly_api_call(user_model::PSUserModel, stock_symbol::String; \n    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing, AbstractLogger} = nothing) -> (Union{PSResult{T}, Nothing} where T<:Any)\n\nStuff will go here. Awesome stuff, the most beautiful stuff ever.\n\n\n\n\n\n","category":"function"},{"location":"execute_sts_adjusted_daily_api_call/#Adjusted-Time-Series-Daily","page":"Adjusted Time Series Daily","title":"Adjusted Time Series Daily","text":"","category":"section"},{"location":"execute_sts_adjusted_daily_api_call/","page":"Adjusted Time Series Daily","title":"Adjusted Time Series Daily","text":"execute_sts_adjusted_daily_api_call","category":"page"},{"location":"execute_sts_adjusted_daily_api_call/#PooksoftAlphaVantageDataStore.execute_sts_adjusted_daily_api_call","page":"Adjusted Time Series Daily","title":"PooksoftAlphaVantageDataStore.execute_sts_adjusted_daily_api_call","text":"execute_sts_adjusted_daily_api_call(user_model::PSUserModel, ticker_symbol::String; \n    data_type::Symbol = :json, outputsize::Symbol = :compact, logger::Union{Nothing,AbstractLogger} = nothing) -> (Union{PSResult{T}, Nothing} where T<:Any)\n\nStuff will go here. Awesome stuff, the most beautiful stuff ever.\n\n\n\n\n\n","category":"function"}]
}
