\name{setExampleptions}
\alias{setExampleOptions}
\alias{getExampleOption}
\alias{getExampleOptions}
\title{ Get and Set Global Options }
\description{
  Provides access to a predefined set of global options for the
  \pkg{sjpMScThesis} package.
}
\usage{
getExampleOption(name)
getExampleOptions()
setExampleOptions(...)
}
\arguments{
  \item{name}{ The name of one option. }
  \item{...}{
    Named arguments giving a name, value pair for a new option setting.
  }
}
\details{
  The options currently available are:
  \itemize{
    \item \code{addr} The address to listen on. Default is
    \code{"127.0.0.1"}.
    \item \code{port} The port to listen on. Default is \code{13060L}.
    \item \code{browse} Logical. Whether to automatically browse to the
    application once it starts. Default is \code{TRUE}.
  }
}
\value{
  \code{getExampleOption()} returns at most one option setting.
  \code{getExampleOptions()} returns all option settings.
  \code{setExampleOptions()} returns a list of previous option settings
  for the options that were changed.
}
\author{ Simon Potter }
\seealso{ \code{\link{thesisExample}} }
