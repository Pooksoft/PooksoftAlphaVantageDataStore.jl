struct PSUserModel

    # data for user -
    alphavantage_api_email::String
    alphavantage_api_key::String

    # constructor -
    function PSUserModel(api_email::String, api_key::String)
        new(api_email,api_key)
    end
end

struct PSDataStoreAPICallModel

    # data -
    ticker::String
    dataType::Symbol
    outputsize::Symbol
    apicall::Function

    function PSDataStoreAPICallModel(apicall::Function, ticker::String; dataType::Symbol=:cvs, output::Symbol = :compact)
        this = new(ticker,dataType,output,apicall)
    end
end
