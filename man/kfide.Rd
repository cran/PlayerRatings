\name{kfide}
\alias{kfide}
\title{The K Factor Function Used By FIDE}
\description{
  Calculates the K factor for the Elo rating system based
  on player rating, number of games played, and optionally
  a binary elite player identifier. 
}
\usage{
kfide(rating, games, elite = NULL, kv = c(10,15,30)) 
}
\arguments{
  \item{rating}{A numeric vector of player ratings.}
  \item{games}{A numeric vector with the number of games played
    by each player.}
  \item{elite}{If not \code{NULL}, then a binary identifier for
    elite players.}
  \item{kv}{The three different K factors that the function can
    produce.}
}
\details{
  This function is designed to be used for the \code{kfac} argument
  of either \code{\link{fide}} or \code{\link{elo}}. It returns
  \code{kv[1]} for elite players, \code{kv[2]} for non-elite
  players with 30 games or more, and \code{kv[3]} for non-elite
  players with less than 30 games. The default is the current FIDE 
  implementation which uses the K factors 10, 15 and 30. The K factor 
  of 30 was changed from 25 in the year 2011. In this context, elite
  players are defined by FIDE as being those who have reached 
  the rating 2400 or more at any time in the past.  
}
\value{
  A numeric vector of K factors.
}

\seealso{\code{\link{fide}}}

\keyword{manip}




