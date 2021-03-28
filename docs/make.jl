using Documenter
using PooksoftAlphaVantageDataStore

makedocs(sitename="PooksoftAlphaVantageDataStore.jl",
    pages = [
        "index.md",

        "Utility" =>[
            "utility.md"
        ],

        "Stock Time Series (STS)" => [
            "execute_sts_daily_api_call.md",
            "execute_sts_weekly_api_call.md",
            "execute_sts_adjusted_weekly_api_call.md",
            "execute_sts_monthly_api_call.md",
            "execute_sts_adjusted_monthly_api_call.md"
        ],

        "Technical Indicators (TI)" => [
            "execute_ti_simple_moving_average_api_call.md",
            "execute_ti_exponential_moving_average_api_call.md"
        ]
    ]
)

# Deploy -
# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl.git",
    devbranch = "master",
    devurl = "dev",
)