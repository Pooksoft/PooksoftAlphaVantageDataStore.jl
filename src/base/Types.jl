struct PSUserModel

    # data for user -
    alphavantage_api_email::String
    alphavantage_api_key::String

    # constructor -
    function PSUserModel(api_email::String, api_key::String)
        new(api_email,api_key)
    end
end

struct PSDataStoreDownloadParameters

    # data -
    assetTickerSymbol::String
    dataType::Symbol
    outputsize::Symbol
    call::Function

    function PSDataStoreDownloadParameters(ticker::String,dataType::Symbol,output::Symbol,call::Function)
    end
end
