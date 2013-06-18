suppressPackageStartupMessages({
    library(Rook)
    library(gridSVG)
    library(hexbin)
    library(selectr)
})

# This takes a while...
message("Please wait while this example loads... ", appendLF = FALSE)
source(system.file("examples", "hexbin", "hexbin-data.R",
                   package = "sjpMScThesis"))
message("done")

ws <- Rhttpd$new()
suppressMessages({
    # Disable help server if in use
    try(tools::startDynamicHelp(FALSE), TRUE)
    ws$start(port = getExampleOption("port"), quiet = TRUE)
})

ws$add(name = "hexbin",
       app = Builder$new(
                 Static$new(urls = c("/js", "/css"),
                            root = system.file("examples", "hexbin",
                                               package = "sjpMScThesis")),
                 Brewery$new(url = "/brew",
                             root = system.file("examples", "hexbin",
                                                package = "sjpMScThesis")),
                 Redirect$new("/brew/index.html")))

message(paste0("To view the 'hexbin' example, visit: ",
               ws$full_url("hexbin")))
if (getExampleOption("browse"))
    browseURL(ws$full_url("hexbin"))
