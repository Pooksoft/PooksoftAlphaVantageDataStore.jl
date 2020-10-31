using Documenter
using PooksoftAlphaVantageDataStore

makedocs(sitename="PooksoftAlphaVantageDataStore.jl",
    pages = [
        "index.md",

        "Utility" =>[
            "utility.md"
        ],

        "Stock Time Series (STS) functions" => [
            "execute_sts_daily_api_call.md",
            "execute_sts_weekly_api_call.md",
            "execute_sts_adjusted_weekly_api_call.md",
            "execute_sts_monthly_api_call.md",
            "execute_sts_adjusted_monthly_api_call.md"
        ]
    ]
)