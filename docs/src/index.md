# Introduction
This package encodes a set of [Julia](https://julialang.org) functions to download data from the [AlphaVantage](https://www.alphavantage.co) financial data application programming interface (API). This package assumes you have login credentials for the [AlphaVantage](https://www.alphavantage.co) API.

### Installation Requirements
`PooksoftAlphaVantageDataStore.jl` can be installed, updated, or removed using the [Julia package management system](https://docs.julialang.org/en/v1/stdlib/Pkg/). To access the package management interface, open the [Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/), and start the package mode by pressing `]`.
While in package mode, to install `PooksoftAlphaVantageDataStore.jl`, issue the command:

    (@v1.6) pkg> add PooksoftAlphaVantageDataStore

Required packages will be downloaded and installed for you automatically. 

To use `PooksoftAlphaVantageDataStore.jl` in your projects issue the command:

    julia> using PooksoftAlphaVantageDataStore

### Package Organization
Functions of `PooksoftAlphaVantageDataStore.jl` are organized around each of the category areas of the 
[AlphaVantage](https://www.alphavantage.co) application programming interface. The current version of 
`PooksoftAlphaVantageDataStore.jl` implements functions that wrap the Stock Time Series (STS) methods of
[AlphaVantage](https://www.alphavantage.co). 

#### Disclaimer
`PooksoftAlphaVantageDataStore.jl` is offered solely for training and  informational purposes. No offer or solicitation to buy or sell securities or securities derivative products of any kind, or any type of investment or trading advice or strategy,  is made, given or in any manner endorsed by Pooksoft. 

Trading involves risk. Carefully review your financial situation before investing in securities, futures contracts, options or commodity interests. Past performance, whether actual or indicated by historical tests of strategies, is no guarantee of future performance or success. Trading is generally not appropriate for someone with limited resources, investment or trading experience, or a low-risk tolerance.  Only risk capital that will not be needed for living expenses.

You are fully responsible for any investment or trading decisions you make, and such decisions should be based solely on your evaluation of your financial circumstances, investment or trading objectives, risk tolerance and liquidity needs. 
