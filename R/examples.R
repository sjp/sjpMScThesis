exampleNames <- c("arima", "hexbin", "hexbinClean",
                  "loess", "loessShiny", "loessStatic",
                  "mds", "mdsClean", "sampvar", "sampvarClean")
.ENV <- new.env()

thesisExample <- function(name, addr = NA, port = NA, browse = NA) {
    if (missing(name))
        stop(paste0("The name of an example must be given.\n",
                    "This can be one of:\n  ",
                    paste0(exampleNames, collapse = ", "), "."))
    if (! (is.character(name) && length(name) == 1))
        stop("'name' must be a single element character vector.")
    if (! name %in% exampleNames)
        stop("'name' must be one of the names listed in 'listThesisExamples()'")
    if (! (length(port) == 1 && (is.na(port) || is.numeric(port))))
        stop("'port' must be a single element numeric vector.")
    if (! is.na(addr) && is.character(addr))
        setExampleOptions(addr = addr)
    if (! is.na(port) && is.numeric(port))
        setExampleOptions(port = as.integer(port))
    if (! is.na(browse) && is.logical(browse))
        setExampleOptions(browse = browse)
    exfn <- switch(name,
                   arima = arimaExample,
                   loess = loessExample,
                   loessShiny = loessShinyExample,
                   loessStatic = loessStaticExample,
                   hexbin = hexbinExample,
                   hexbinClean = hexbinCleanExample,
                   mds = mdsExample,
                   mdsClean = mdsCleanExample,
                   sampvar = sampvarExample,
                   sampvarClean = sampvarCleanExample)
    exfn()
}

stopThesisExample <- function() {
    if (exists("ws")) {
        ws <- get("ws")
        try(ws$stop(), TRUE)
    }
}

listThesisExamples <- function() {
    cat(" arima: Interactive ARIMA Model Diagnostics\n")
    cat(" hexbin: Hexagonal Binning Comparisons\n")
    cat(" hexbinClean: 'hexbin' with no explanatory paragraphs\n")
    cat(" loess: Interactive LOESS Smoothing\n")
    cat(" loessShiny: Interactive LOESS Smoothing using 'shiny' and 'gridSVG'\n")
    cat(" loessStatic: Interactive LOESS Smoothing using 'shiny' (for comparison)\n")
    cat(" mds: Animated Multidimensional Scaling\n")
    cat(" mdsClean: 'mds' with no explanatory paragraphs\n")
    cat(" sampvar: Sampling Variation Teaching Visualisation\n")
    cat(" sampvarClean: 'sampvar' with no explanatory paragraphs\n")
}

arimaExample <- function() {
    source(system.file("examples", "arima", "run-arima.R",
                       package = "sjpMScThesis"),
           echo = FALSE)
}

hexbinExample <- function() {
    source(system.file("examples", "hexbin", "run-hexbin.R",
                       package = "sjpMScThesis"),
           echo = FALSE)
}

hexbinCleanExample <- function() {
    source(system.file("examples", "hexbin-clean", "run-hexbin-clean.R",
                       package = "sjpMScThesis"),
           echo = FALSE)
}

loessExample <- function() {
    source(system.file("examples", "loess", "run-loess.R",
                       package = "sjpMScThesis"),
           echo = FALSE)
}

loessShinyExample <- function() {
    source(system.file("examples", "loess-shiny", "run-loess-shiny.R",
                       package = "sjpMScThesis"),
           echo = FALSE)
}

loessStaticExample <- function() {
    source(system.file("examples", "loess-static", "run-loess-static.R",
                       package = "sjpMScThesis"),
           echo = FALSE)
}

mdsExample <- function() {
    source(system.file("examples", "mds", "run-mds.R",
                       package = "sjpMScThesis"),
           echo = FALSE)
}

mdsCleanExample <- function() {
    source(system.file("examples", "mds-clean", "run-mds-clean.R",
                       package = "sjpMScThesis"),
           echo = FALSE)
}

sampvarExample <- function() {
    source(system.file("examples", "sampvar", "run-sampvar.R",
                       package = "sjpMScThesis"),
           echo = FALSE)
}

sampvarCleanExample <- function() {
    source(system.file("examples", "sampvar-clean", "run-sampvar-clean.R",
                       package = "sjpMScThesis"),
           echo = FALSE)
}

# Get and set global 'example' options

# Initial settings
assign("exampleOptions",
       list(addr = "127.0.0.1",
            port = 13060L,
            browse = TRUE),
       .ENV)

checkOptions <- function(options) {
    optionNames <- names(options)
    validOption <- sapply(optionNames, function(x) {
        if (x == "addr")
            is.character(options$addr)
        if (x == "port")
            is.numeric(options$port)
        if (x == "browse")
            is.logical(options$browse)
    })
    validOption <- as.logical(unlist(validOption))
    if (any(! validOption))
        stop(paste("Invalid option for: ",
                   paste(dQuote(optionNames[! validOption]), collapse = ", "),
                   sep = ""))
}

# Get/set options
getExampleOption <- function(name) {
    oldOptions <- get("exampleOptions", .ENV)
    optionNames <- names(oldOptions)
    if (name %in% optionNames) {
        oldOptions[[name]]
    }
}

getExampleOptions <- function() {
    get("exampleOptions", .ENV)
}

setExampleOptions <- function(...) {
    oldOptions <- get("exampleOptions", .ENV)
    options <- list(...)
    if (length(options)) {
        names <- names(options)
        optionNames <- names(oldOptions)
        names <- names[nchar(names) > 0 &
                       names %in% optionNames]
        if (length(options[names])) {
            newOptions <- oldOptions
            newOptions[names] <- options[names]
            checkOptions(newOptions)
            assign("exampleOptions", newOptions, .ENV)
            invisible(oldOptions[names])
        } 
    } 
}

