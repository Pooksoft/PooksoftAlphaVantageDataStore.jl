function build_datastore_download_parameter_object(callFunction::Function, tickerSymbol::String; 
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
    parameter_object = PSDataStoreDownloadParameters(callFunction, tickerSymbol; dataType=datatype, output=output)

    # return -
    return PSResult(parameter_object)
end

function download(userModel::PSUserModel, parameters::PSDataStoreDownloadParameters; 
    logger::Union{Nothing,AbstractLogger} = nothing)::PSResult

    # get stuff from the parameters -
    tickerSymbol = parameters.ticker
    outputsize = parameters.outputsize
    datatype = parameters.dataType
    apicall = parameters.apicall

    # make the call -
    return apicall(userModel,tickerSymbol; data_type = datatype, outputsize = outputsize, logger = logger)
end