library(shiny)
message(paste0("To run the 'loessStatic' example, visit: http://localhost:",
               getExampleOption("port")))
runApp(system.file("examples", "loess-static", "loess-static",
                   package = "sjpMScThesis"),
       port = getExampleOption("port"),
       launch.browser = getExampleOption("browse"))


