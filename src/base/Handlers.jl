function process_raw_csv_api_data(api_call_raw_data::String)::(Union{PSResult{T}, Nothing} where T<:Any)

    # check: do we have an empty string?
    # check: legit string?

    # need to check to see if legit data is coming back from the service -
    if (is_valid_json(api_call_raw_data) == true)
        api_data_dictionary = JSON.parse(api_call_raw_data)
        if (haskey(api_data_dictionary,"Error Message") == true)

            # grab the error mesage -
            error_message = api_data_dictionary["Error Message"]

            # throw -
            return PSResult{PSError}(PSError(error_message))
        else

            # formulate an error message -
            error_message = "Error: CSV type returns JSON without error message"

            # throw -
            return PSResult{PSError}(PSError(error_message))
        end
    end

    # create a data table from the CSV data -
    tmp_data_table = CSV.read(IOBuffer(api_call_raw_data))

    # sort the table according to the timestamps -
    idx_sort = sortperm(tmp_data_table[:,1])

    # create a sorted data table -
    sorted_data_table = tmp_data_table[idx_sort,:]

    # return the sorted table -
    return PSResult{DataFrame}(sorted_data_table)
end

function process_raw_json_api_data_sts(api_call_raw_data::String, data_series_key::String)::(Union{PSResult{T}, Nothing} where T<:Any)

    # is the data coming back well formed, and does it contain valid data?
    check_result = check_json_api_return_data(api_call_raw_data)
    if check_result != nothing
        return check_result
    end

    # TODO - check for missing data series key -
    # ...

    # if we get here, we have valid JSON. Build dictionary -
    api_data_dictionary = JSON.parse(api_call_raw_data)

    # grab the time series data -
    time_series_key = data_series_key
    if (haskey(api_data_dictionary, time_series_key) == false)

        # throw an error -
        error_message = "Error: Missing the Time series key = $(time_series_key)"

        # throw -
        return PSError(error_message)
    end

    # array of keys -
    data_key_label_array = ["1. open", "2. high", "3. low", "4. close", "5. volume"]
    number_of_fields = length(data_key_label_array)

    # initialize storage for the fields -
    timestamp_array = Dates.Date[]
    open_price_array = Float64[]
    high_price_array = Float64[]
    low_price_array = Float64[]
    close_price_array = Float64[]
    volume_array = Int64[]

    # ok, we have the time series key, go through the data and load into the table -
    time_series_dictionary = api_data_dictionary[time_series_key]
    time_series_key_array = collect(keys(time_series_dictionary))
    for timestamp_value in time_series_key_array

        # get the local_dictionary -
        local_dictionary = time_series_dictionary[timestamp_value]

        # cache -
        push!(timestamp_array, Dates.Date(timestamp_value,"yyyy-mm-dd"))

        # add the price data -
        for key_index = 1:number_of_fields

            # grab key -
            local_key = data_key_label_array[key_index]
            value = local_dictionary[local_key]

            # populate the array's -
            if (key_index == 1)
                push!(open_price_array, parse(Float64, value))
            elseif (key_index == 2)
                push!(high_price_array, parse(Float64, value))
            elseif (key_index == 3)
                push!(low_price_array, parse(Float64, value))
            elseif (key_index == 4)
                push!(close_price_array, parse(Float64, value))
            else
                push!(volume_array, parse(Int64, value))
            end
        end
    end

    # we need to sort the timestamps, to make them in reverse order -
    idx_sort = sortperm(timestamp_array)

    # build the data frame -
    data_frame = DataFrame(timestamp=timestamp_array[idx_sort], open=open_price_array[idx_sort], high=high_price_array[idx_sort], low=low_price_array[idx_sort], close=close_price_array[idx_sort], volume=volume_array[idx_sort])

    # return the data back to the caller -
    return PSResult{DataFrame}(data_frame)
end

function process_raw_json_api_data_sts_adjusted(api_call_raw_data::String, data_series_key::String)::(Union{PSResult{T}, Nothing} where T<:Any)
    
    # is the data coming back well formed, and does it contain valid data?
    check_result = check_json_api_return_data(api_call_raw_data)
    if check_result != nothing
        return check_result
    end

    # if we get here, we have valid JSON. Build dictionary -
    api_data_dictionary = JSON.parse(api_call_raw_data)

    # grab the time series data -
    time_series_key = data_series_key
    if (haskey(api_data_dictionary, time_series_key) == false)

        # throw an error -
        error_message = "Error: Missing the Time series key = $(time_series_key)"

        # throw -
        return PSError(error_message)
    end
    #all repeated up to here possibly look to make the above a function for just checking data
    # array of keys -- this is changed per function
    data_key_label_array = ["1. open", "2. high", "3. low", "4. close", "5. adjusted close", "6. volume", "7. dividend amount"]
    number_of_fields = length(data_key_label_array)

    #initialize arrays to hold these fields for all dates
    timestamp_array = Dates.Date[]
    open_price_array = Float64[]
    high_price_array = Float64[]
    low_price_array = Float64[]
    close_price_array = Float64[]
    adjusted_close_array = Float64[]
    volume_array = Int64[]
    dividend_amount_array = Float64[]

    # ok, we have the time series key, go through the data and load into the table -
    time_series_dictionary = api_data_dictionary[time_series_key]
    time_series_key_array = collect(keys(time_series_dictionary))
    for timestamp_value in time_series_key_array

        # get the local_dictionary -
        local_dictionary = time_series_dictionary[timestamp_value]

        # cache -
        push!(timestamp_array, Dates.Date(timestamp_value,"yyyy-mm-dd"))

        # add the price data -
        for key_index = 1:number_of_fields

            # grab key -
            local_key = data_key_label_array[key_index]
            value = local_dictionary[local_key]

            # populate the array's -
            if (key_index == 1)
                push!(open_price_array, parse(Float64, value))
            elseif (key_index == 2)
                push!(high_price_array, parse(Float64, value))
            elseif (key_index == 3)
                push!(low_price_array, parse(Float64, value))
            elseif (key_index == 4)
                push!(close_price_array, parse(Float64, value))
            elseif (key_index == 5)
                push!(adjusted_close_array, parse(Float64, value))
            elseif (key_index == 6)
                push!(volume_array, parse(Int64, value))
            else
                push!(dividend_amount_array, parse(Float64, value))
            end
        end
    end
    # we need to sort the timestamps, to make them in reverse order -
    idx_sort = sortperm(timestamp_array)

    # build the data frame -
    data_frame = DataFrame(timestamp=timestamp_array[idx_sort], open=open_price_array[idx_sort], high=high_price_array[idx_sort], low=low_price_array[idx_sort], close=close_price_array[idx_sort], adjusted_close = adjusted_close_array[idx_sort], volume=volume_array[idx_sort], dividend_amount = dividend_amount_array[idx_sort])

    # return the data back to the caller -
    return PSResult{DataFrame}(data_frame)
end

function process_raw_json_api_data_sts_daily_adjusted(api_call_raw_data::String, data_series_key::String)::(Union{PSResult{T}, Nothing} where T<:Any)
    
    # is the data coming back well formed, and does it contain valid data?
    check_result = check_json_api_return_data(api_call_raw_data)
    if check_result != nothing
        return check_result
    end

    # if we get here, we have valid JSON. Build dictionary -
    api_data_dictionary = JSON.parse(api_call_raw_data)

    # grab the time series data -
    time_series_key = data_series_key
    if (haskey(api_data_dictionary, time_series_key) == false)

        # throw an error -
        error_message = "Error: Missing the Time series key = $(time_series_key)"

        # throw -
        return PSError(error_message)
    end
    #all repeated up to here possibly look to make the above a function for just checking data
    # array of keys -- this is changed per function
    data_key_label_array = ["1. open", "2. high", "3. low", "4. close", "5. adjusted close", "6. volume", "7. dividend amount", "8. split coefficient"]
    number_of_fields = length(data_key_label_array)

    #initialize arrays to hold these fields for all dates
    timestamp_array = Dates.Date[]
    open_price_array = Float64[]
    high_price_array = Float64[]
    low_price_array = Float64[]
    close_price_array = Float64[]
    adjusted_close_array = Float64[]
    volume_array = Int64[]
    dividend_amount_array = Float64[]
    split_coefficient = Float64[]

    # ok, we have the time series key, go through the data and load into the table -
    time_series_dictionary = api_data_dictionary[time_series_key]
    time_series_key_array = collect(keys(time_series_dictionary))
    for timestamp_value in time_series_key_array

        # get the local_dictionary -
        local_dictionary = time_series_dictionary[timestamp_value]

        # cache -
        push!(timestamp_array, Dates.Date(timestamp_value,"yyyy-mm-dd"))

        # add the price data -
        for key_index = 1:number_of_fields

            # grab key -
            local_key = data_key_label_array[key_index]
            value = local_dictionary[local_key]

            # populate the array's -
            if (key_index == 1)
                push!(open_price_array, parse(Float64, value))
            elseif (key_index == 2)
                push!(high_price_array, parse(Float64, value))
            elseif (key_index == 3)
                push!(low_price_array, parse(Float64, value))
            elseif (key_index == 4)
                push!(close_price_array, parse(Float64, value))
            elseif (key_index == 5)
                push!(adjusted_close_array, parse(Float64, value))
            elseif (key_index == 6)
                push!(volume_array, parse(Int64, value))
            elseif (key_index == 7)
                push!(dividend_amount_array, parse(Float64, value))
            else
                push!(split_coefficient, parse(Float64, value))
            end
        end
    end
    # we need to sort the timestamps, to make them in reverse order -
    idx_sort = sortperm(timestamp_array)

    # build the data frame -
    data_frame = DataFrame(timestamp=timestamp_array[idx_sort], open=open_price_array[idx_sort], high=high_price_array[idx_sort], low=low_price_array[idx_sort], close=close_price_array[idx_sort], adjusted_close = adjusted_close_array[idx_sort], volume=volume_array[idx_sort], dividend_amount = dividend_amount_array[idx_sort])

    # return the data back to the caller -
    return PSResult{DataFrame}(data_frame)
end