function check_for_numerical_none_value(value::String)::Union{Missing,Float64}


    return_value = missing
    if (value != "None")
        return_value = parse(Float64, value)
    end

    # return -
    return return_value
end