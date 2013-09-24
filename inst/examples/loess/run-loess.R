suppressPackageStartupMessages({
    library(grid)
    library(XML)
    library(Rook)
    library(gridSVG)
    library(ggplot2)
    library(selectr)
})

# Create randomly generated data for use in our example
xs <- seq(-10, 10, length.out = 100)
ys <- xs^2 + 15 * rnorm(100)
panelvp <- ""

ws <- Rhttpd$new()
suppressMessages({
    # Disable help server if in use
    try(tools::startDynamicHelp(FALSE), TRUE)
    ws$start(port = getExampleOption("port"), quiet = TRUE)
})

ws$add(name = "loess",
       app = Builder$new(
                 Static$new(urls = c("/js", "/css"),
                            root = system.file("examples", "loess",
                                               package = "sjpMScThesis")),
                 Brewery$new(url = "/brew",
                             root = system.file("examples", "loess",
                                                package = "sjpMScThesis")),
                 Redirect$new("/brew/index.html")))

message(paste0("To view the 'loess' example, visit: ",
               ws$full_url("loess")))
if (getExampleOption("browse"))
    browseURL(ws$full_url("loess"))

