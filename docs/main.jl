using Documenter
using PooksoftAlphaVantageDataStore

makedocs(sitename="PooksoftAlphaVantageDataStore.jl",
    pages = [
        "index.md",

        "Utility" =>[
            "utility.md"
        ],

        "Stock Time Series (STS) functions" => [
            "stsfunctions.md",
            "execute_sts_daily_api_call.md",
            "execute_sts_weekly_api_call.md"
        ]
    ]
)