function log_api_call(logger::AbstractLogger, user_model::PSUserModel, message::String)
    with_logger(logger) do
            
        # get user email -
        alphavantage_api_email = user_model.alphavantage_api_email

        # current timestamp -
        now_stamp = now()

        # formulate log message -
        log_mesage = "$(now_stamp)::$(alphavantage_api_email)::$(message)"

        # log -
        @debug(log_mesage) 
    end
end