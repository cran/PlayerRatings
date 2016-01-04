\name{kgames}
\alias{kgames}
\title{A K Factor Function With Dependence On Number Of Games}
\description{
  Calculates the K factor for the Elo rating system based
  on number of games played. 
}
\usage{
kgames(rating, games, elite = NULL, gv = 30, kv = c(32,26)) 
}
\arguments{
  \item{rating}{A numeric vector of player ratings. The K factor
     does not depend on this quantity.}
  \item{games}{A numeric vector with the number of games played
    by each player.}
  \item{elite}{Not used.}
  \item{gv}{A numeric vector of length one less than \code{kv}
    giving the thresholds for the number of games played.}
  \item{kv}{A numeric vector of length one more than \code{gv}
    giving the different K factors that the function can
    produce.}
}
\details{
  This function is designed to be used for the \code{kfac} argument
  of either \code{\link{fide}} or \code{\link{elo}}. It returns
  \code{kv[i]} for players who have played a total number of games
  within the intervals defined by \code{gv} (closed on the right). 
}
\value{
  A numeric vector of K factors.
}

\seealso{\code{\link{elo}}, \code{\link{fide}}}

\keyword{manip}




