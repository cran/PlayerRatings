\name{hist.rating}
\alias{hist.rating}

\title{Histogram Plotting for a Rating Object}
\description{
  Plot histograms of estimated ratings or other features,
  including full history progressions.
}
\usage{
\method{hist}{rating}(x, which = "Rating", tng=15, history = FALSE, log = FALSE, 
  xlab = which, main = paste(x$type," Ratings System"), density = FALSE, 
  add = FALSE, \dots)
}
\arguments{
  \item{x}{An object of class \code{"rating"}.}
  \item{which}{The variable to be plotted.}
  \item{tng}{A single value. If the number of games played by the
    player is below this value, the player is not depicted on the
    plot.}
  \item{history}{If \code{TRUE}, a histogram is plotted for every
    single time point. Only available if the history was retained
    in \code{x}.}
  \item{log}{The log(x+1) transform. May be useful if plotting e.g.
    the number of games.}
  \item{xlab,main}{Graphical parameters.}
  \item{density}{If \code{TRUE}, plot a density estimate rather 
    than a histogram.}
  \item{add}{Add to an existing plot? Only relevant for density
    estimates.}
  \item{\dots}{Other parameters to be passed through to plotting
    functions.}
}

\seealso{\code{\link{plot.rating}}}

\examples{
afl <- aflodds[,c(2,3,4,7)]
robj <- steph(afl)
hist(robj, xlim = c(1900,2500), density=TRUE)

afl <- aflodds[,c(2,3,4,7)]
robj <- steph(afl, history=TRUE)
hist(robj, history=TRUE, xlim = c(1900,2500), density=TRUE)

robj <- elom(riichi)
hist(robj, xlim = c(1100,1900))

robj <- elom(riichi, history=TRUE)
hist(robj, history=TRUE, xlim = c(1100,1900))
}
\keyword{hplot}
