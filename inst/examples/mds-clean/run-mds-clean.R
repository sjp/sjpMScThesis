suppressPackageStartupMessages({
    library(Rook)
    library(gridSVG)
})

ws <- Rhttpd$new()
suppressMessages({
    # Disable help server if in use
    try(tools::startDynamicHelp(FALSE), TRUE)
    ws$start(port = getExampleOption("port"), quiet = TRUE)
})

ws$add(name = "mds",
       app = Builder$new(
                 Static$new(urls = c("/js", "/css"),
                            root = system.file("examples", "mds-clean",
                                               package = "sjpMScThesis")),
                 Brewery$new(url = "/brew",
                             root = system.file("examples", "mds-clean",
                                                package = "sjpMScThesis")),
                 Redirect$new("/brew/index.html")))

message(paste0("To view the 'mdsClean' example, visit: ",
               ws$full_url("mds")))
if (getExampleOption("browse"))
    browseURL(ws$full_url("mds"))
