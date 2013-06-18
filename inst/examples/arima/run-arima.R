# Loading required packages, quietly
suppressPackageStartupMessages({
    library(gridSVG)
    library(selectr)
    library(Rook)
})

# Loading in main ACF/PACF plotting function
source(system.file("examples", "arima", "R", "acf-plots.R",
                   package = "sjpMScThesis"))

# Set 'Nile' to be the default dataset, but allow changing
armaDatasetGen <- function() {
    dataset <- Nile
    function(newdata = NULL) {
        if (is.null(newdata)) {
            dataset
        } else {
            newts <- ts(newdata)
            dataset <<- newts
        }
    }
}
armaDataset <- armaDatasetGen()

ws <- Rhttpd$new()
suppressMessages({
    # Disable help server if in use
    try(tools::startDynamicHelp(FALSE), TRUE)
    ws$start(port = getExampleOption("port"), quiet = TRUE)
})

ws$add(name = "arima",
       app = Builder$new(
                 Static$new(urls = c("/js", "/css"),
                            root = system.file("examples", "arima",
                                               package = "sjpMScThesis")),
                 Brewery$new(url = "/brew",
                             root = system.file("examples", "arima",
                                                package = "sjpMScThesis")),
                 Redirect$new("/brew/index.html")))

message(paste0("To view the 'arima' example, visit: ",
               ws$full_url("arima")))
if (getExampleOption("browse"))
    browseURL(ws$full_url("arima"))
