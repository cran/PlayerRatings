\name{plot.rating}
\alias{plot.rating}

\title{Plot Player Features Across Time for a Rating Object}
\description{
  Plot line traces of estimated ratings or other features for
  selected players. This function can only be used if the full
  history is retained in the object \code{x}.
}
\usage{
\method{plot}{rating}(x, which = "Rating", players = NULL, t0 = 1, tv = NULL,
  npl = 10, random = FALSE, xlab = "Time Period", ylab = paste(x$type," Ratings"), 
  main = paste(x$type," Ratings System"), inflation = FALSE, add=FALSE, \dots) 
}
\arguments{
  \item{x}{An object of class \code{"rating"}.}
  \item{which}{The variable to be plotted.}
  \item{players}{If not \code{NULL}, should be a vector of player
    identifiers to explicitly select players to be plotted.}
  \item{t0}{The time index at which to begin. Note that unless players
    are specified explicitly, players who do not play at time index
    \code{t0} will not be selected for the plot. Can also be a
    vector of length two, in which case the second value is the
    time index at which to end.}
  \item{tv}{If not \code{NULL}, then a vector of values to be used on the
    x-axis instead of the time index.}
  \item{npl}{The number of players to select.}
  \item{random}{If \code{TRUE}, \code{npl} players are selected at random from
    those who played at time \code{t0}. If \code{FALSE} (the default), 
    the \code{npl} players who played most games at \code{t0} are selected. 
    Ignored if \code{players} is not \code{NULL}.}
  \item{xlab,ylab,main}{Graphical parameters.}
  \item{inflation}{If \code{TRUE}, plot the average rating of the best \code{npl}
     players at each time point. This is designed to investigate ratings inflation.}
  \item{add}{Add to an existing plot.}
  \item{\dots}{Other parameters to be passed through to plotting
    functions.}
}
\details{
  Note that the argument \code{random} is not used by default, since it can 
  produce flat profiles from randomly selected players who play few games. 
  The default selection is non-random and selects more active players,
  however they may be more likely to improve over time than the
  general population.  
}

\seealso{\code{\link{hist.rating}}}

\examples{
afl <- aflodds[,c(2,3,4,7)]
robj <- steph(afl, history=TRUE)
plot(robj)

robj <- elom(riichi, history = TRUE)
pl <- robj$ratings$Player[robj$ratings$Games >= 80]
plot(robj, players = pl)
}
\keyword{hplot}
