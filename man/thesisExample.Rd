\name{Run Example Applications}
\alias{thesisExample}
\alias{stopThesisExample}
\title{
  Start and stop gridSVG web applications
}
\description{
  Main functions for starting and stopping example \pkg{gridSVG}-based
  web applications.
}
\usage{
thesisExample(name, addr = NA, port = NA, browse = NA)
stopThesisExample()
}
\arguments{
  \item{name}{
    The name of an example to start. See
    \code{\link{listThesisExamples}} for the list of available names.
  }
  \item{addr}{
    The IP address to listen on. By default (and Rook is fixed on this)
    this is \code{localhost}/\code{127.0.0.1}.

    This should be left alone.
  }
  \item{port}{
    The port that the example should listen on. The default port is
    \code{13060}.
  }
  \item{browse}{
    Logical. Whether to automatically browse to the application started
    by the example. By default this is \code{TRUE}.
  }
}
\details{
  When \code{addr}, \code{port}, \code{browse} are \code{NA}, they take
  the current value stored in \code{\link{getExampleOptions}}. When they
  are not \code{NA}, they assign the value to be the new value stored
  for the option, which is then used for any example applications.
}
\value{
  None.
}
\author{
  Simon Potter
}
\seealso{
  \code{\link{getExampleOptions}}, \code{\link{getExampleOption}},
  \code{\link{setExampleOptions}}.
}
\examples{\dontrun{
# Run LOESS example on the default port and browsing to it
thesisExample("loess")
# Stopping it
stopThesisExample()
# Starting the same application on a different port but not browsing to it
thesisExample("loess", port = 4444L, browse = FALSE)
# Stopping it
stopThesisExample()
}}
