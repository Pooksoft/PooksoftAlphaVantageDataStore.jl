struct PSResult{T}
    value::T
end

struct PSError <: Exception
    message::String
end

struct PSUserModel

    # data for user -
    alphavantage_api_email::String
    alphavantage_api_key::String

    # constructor -
    function PSUserModel(api_email::String,api_key::String)
        new(api_email,api_key)
    end
end
