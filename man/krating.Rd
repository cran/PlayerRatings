\name{krating}
\alias{krating}
\title{A K Factor Function With Dependence On Rating}
\description{
  Calculates the K factor for the Elo rating system based
  on the player rating. 
}
\usage{
krating(rating, games, elite = NULL, rv = 2300, kv = c(32,26)) 
}
\arguments{
  \item{rating}{A numeric vector of player ratings.}
  \item{games}{A numeric vector with the number of games played
    by each player. The K factor does not depend on this 
    quantity.}
  \item{elite}{Not used.}
  \item{rv}{A numeric vector of length one less than \code{kv}
    giving the thresholds for the ratings.}
  \item{kv}{A numeric vector of length one more than \code{gv}
    giving the different K factors that the function can
    produce.}
}
\details{
  This function is designed to be used for the \code{kfac} argument
  of either \code{\link{fide}} or \code{\link{elo}}. It returns
  \code{kv[i]} for players who have a rating within the intervals 
  defined by \code{rv} (closed on the right). 
}
\value{
  A numeric vector of K factors.
}

\seealso{\code{\link{elo}}, \code{\link{fide}}}

\keyword{manip}




