function write_data_to_filestore(base_repository_file_path::String, function_call::Symbol, asset_symbol::String, date_string::String, data_frame::DataFrame)::String

    # -
    # checks go here ...
    # -

    # build a path into the data repository -
    function_call_string = string(function_call)
    final_repo_path = "$(base_repository_file_path)/$(function_call_string)/$(asset_symbol)/$(date_string)"
    final_repo_path_with_file_name = "$(base_repository_file_path)/$(function_call_string)/$(asset_symbol)/$(date_string)/data.csv"

    # check - do we have the repo path directory structure?
    if (isdir(final_repo_path) == false)
        mkpath(final_repo_path)
    end

    # write file to disk -
    CSV.write(final_repo_path,data_frame)

    # return -
    return final_repo_path_with_file_name
end