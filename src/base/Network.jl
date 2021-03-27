function http_get_call_with_url(url::String)::PSResult

    # check: is the URL string empty?
    # check: is it a legit URL string?

    # ok, so we are going to make a HTTP GET call with the URL that was passed in -
    response = HTTP.request("GET",url)

    # ok, so let's check if we are getting a 200 back -
    if (response.status == 200)
        return PSResult{String}(String(response.body))
    else
        # create an error, and throw it back to the caller -
        error_message = "http status flag $(response.status) was returned from url $(url)"
        return PSResult{PSError}(PSError(error_message))
    end
end