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

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/Pooksoft/PooksoftAlphaVantageDataStore.jl.git",
    devbranch = "main",
    devurl = "dev",
)