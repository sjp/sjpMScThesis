library(shiny)
message(paste0("To run the 'loessShiny' example, visit: http://localhost:",
               getExampleOption("port")))
runApp(system.file("examples", "loess-shiny", "loess-shiny",
                   package = "sjpMScThesis"),
       port = getExampleOption("port"),
       launch.browser = getExampleOption("browse"))
