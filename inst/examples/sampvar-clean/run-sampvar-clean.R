# Load required packages
suppressPackageStartupMessages({
    library(gridSVG)
    library(Rook)
    library(animaker)
    library(selectr)
})

# Load required utility functions for building up the plot
source(system.file("examples", "sampvar-clean", "R",
                   "stackPoints.R", package = "sjpMScThesis"))
source(system.file("examples", "sampvar-clean", "R",
                   "buildViewports.R", package = "sjpMScThesis"))
source(system.file("examples", "sampvar-clean", "R",
                   "sectionPlots.R", package = "sjpMScThesis"))
source(system.file("examples", "sampvar-clean", "R",
                   "main.R", package = "sjpMScThesis"))
source(system.file("examples", "sampvar-clean", "R",
                   "genLocations.R", package = "sjpMScThesis"))

# We can refer to the dataset using this closure (and also assign)
datasetGen <- function() {
    # Use mtcars if no data found
    dataset <- mtcars$mpg
    function(newdata = NULL) {
        if (is.null(newdata)) {
            dataset
        } else {
            dataset <<- newdata
        }
    }
}
dataset <- datasetGen()
# Let's use a provided dataset
dataset(read.csv(
    system.file("examples", "sampvar-clean",
                "datasets", "data.csv", package = "sjpMScThesis"))[[1]])

ws <- Rhttpd$new()
suppressMessages({
    # Disable help server if in use
    try(tools::startDynamicHelp(FALSE), TRUE)
    ws$start(port = getExampleOption("port"), quiet = TRUE)
})

ws$add(name = "sampvar",
       app = Builder$new(
                 Static$new(urls = c("/js", "/css"),
                            root = system.file("examples", "sampvar-clean",
                                               package = "sjpMScThesis")),
                 Brewery$new(url = "/brew",
                             root = system.file("examples", "sampvar-clean",
                                                package = "sjpMScThesis")),
                 Redirect$new("/brew/index.html")))

message(paste0("To run the 'sampvarClean' example, visit: ",
               ws$full_url("sampvar")))
if (getExampleOption("browse"))
    browseURL(ws$full_url("sampvar"))
