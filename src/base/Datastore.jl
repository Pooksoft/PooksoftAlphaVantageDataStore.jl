function build_datastore_apicall_model(callFunction::Function, tickerSymbol::String; 
    output::Symbol = :compact, datatype::Symbol = :json)::PSResult

    # TODO: Checks -
    
    # initialize -
    output_type_set = Set{Symbol}()
    datatype_set = Set{Symbol}()

    # check output types -
    push!(output_type_set,:compact)
    push!(output_type_set,:full)
    if (in(output,output_type_set) == false)
        return PSResult(ArgumentError("Incompatible output type. Expected {:compact,:full} but received $(string(output))"))
    end

    # check datatype -
    push!(datatype_set, :json)
    push!(datatype_set, :csv)
    if (in(datatype,datatype_set) == false)
        return PSResult(ArgumentError("Incompatible data type. Expected {:json,:csv} but received $(string(output))"))
    end
    
    # check the tickerSymbol -
    if (isa(tryparse(Float64,tickerSymbol), Number) == true)
        return PSResult(ArgumentError("Incompatible ticker symbol type"))
    end

    # TODO: how do we check is we have a specific function?

    # get stuff -
    parameter_object = PSDataStoreAPICallModel(callFunction, tickerSymbol; dataType=datatype, output=output)

    # return -
    return PSResult(parameter_object)
end

"""
    execute_api_call(user::PSUserModel, api::PSDataStoreAPICallModel; logger::Union{Nothing,AbstractLogger} = nothing)::PSResult

High-level convenience function to execute an data store application programming interface call.

# Arguments
"""
function execute_api_call(usermodel::PSUserModel, apimodel::PSDataStoreAPICallModel; 
    logger::Union{Nothing,AbstractLogger} = nothing)::PSResult

    # get stuff from the parameters -
    tickerSymbol = apimodel.ticker
    outputsize = apimodel.outputsize
    datatype = apimodel.dataType
    apicall = apimodel.apicall

    # make the call -
    return apicall(usermodel,tickerSymbol; data_type = datatype, outputsize = outputsize, logger = logger)
end