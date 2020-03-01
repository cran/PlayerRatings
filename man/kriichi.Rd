\name{kriichi}
\alias{kriichi}
\title{A multi-player K Factor Function for Riichi Mahjong}
\description{
  Calculates the K factor for the rating system employed by
  Tenhou for Riichi mahjong. 
}
\usage{
kriichi(rating, games, gv = 400, kv = 0.2) 
}
\arguments{
  \item{rating}{A numeric vector of player ratings. The K factor
     does not depend on this quantity.}
  \item{games}{A numeric vector with the number of games played
    by each player.}
  \item{gv}{A value giving the threshold for the number of games 
    played.}
  \item{kv}{The K factor if the number of games played is greater
    than or equal to \code{gv}.}
}
\details{
  This function is designed to be used for the \code{kfac} argument
  of \code{\link{elom}}. It returns \code{kv} for players who have 
  played at least \code{gv} games, and returns \code{1-(1-kv)N/gv} 
  otherwise, where \code{N} is the number of games played. 
}
\value{
  A numeric vector of K factors.
}

\seealso{\code{\link{elom}}, \code{\link{fide}}}

\keyword{manip}




