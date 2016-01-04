\name{elo}
\alias{elo}
\alias{print.rating}
\alias{summary.rating}
\title{The Elo Rating System}
\description{
  Implements the Elo rating system for estimating the relative 
  skill level of players in two-player games such as chess. 
}
\usage{
elo(x, status = NULL, init = 2200, gamma = 0, kfac = 27, 
    history = FALSE, sort = TRUE, \dots)
}
\arguments{
  \item{x}{A dataframe containing four variables: (1) a numeric
    vector denoting the time period in which the game took place
    (2) a numeric or character identifier for player one (3)
    a numeric or character identifier for player two and (4)
    the result of the game expressed as a number, typically
    equal to one for a player one win, zero for a player two
    win and one half for a draw.}
  \item{status}{A data frame with the current status of the
    system. If not \code{NULL}, this needs to be a data frame 
    in the form of the \code{ratings} component of the returned 
    list, containing variables named \code{Player}, \code{Rating},
    and optionally \code{Games}, \code{Win}, \code{Draw}, 
	\code{Loss} and \code{Lag}, which are set to zero if not given.}
  \item{init}{The rating at which to intialize a new player not
    appearing in \code{status}. Must be a single number. If
    different initializations for different players are required,
    this can be done using \code{status}.}
  \item{gamma}{A player one advantage parameter; either a single
    value or a numeric vector equal to the number of rows in 
	\code{x}. Positive values favour player one, while negative 
	values favour player two. This could represent the advantage 
	of playing at home, or the advantage of playing white for chess. 
	Note that this is not passed to \code{\link{predict.rating}}, 
	which has its own \code{gamma} parameter.}
  \item{kfac}{The K factor parameter. Can be a single number or
    a vectorized function of two arguments, the first being the
    ratings and the second being the number of games played. See
     \code{\link{kfide}}, \code{\link{kgames}}  and
     \code{\link{krating}} for examples.}
  \item{history}{If \code{TRUE} returns the entire history for each 
    period in the component \code{history} of the returned list.}
  \item{sort}{If \code{TRUE} sort the results by rating (highest
    to lowest). If \code{FALSE} sort the results by player.}
  \item{\dots}{Passed to the function \code{kfac}.}
}
\details{
  The Elo rating system is a simple method for evaluating the skill 
  of players. It has been used since around 1960 and is still
  employed in various settings. Although the basic form uses only 
  the ratings, additional complexity is commonly introduced
  by adding a player one advantage parameter and by using different
  K factors. A player one advantage parameter has been added to the 
  original definition in the reference. This is also used
  for prediction purposes.

  This implementation has a simple initialization, and allows the 
  K factor to depend on both the ratings and the number of games 
  played. Default values are roughly optimized the chess data 
  analyzed in the file doc/ChessRatings.pdf, using the binomial 
  deviance criterion and considering only constant K factors. 
  See the function \code{\link{fide}} for a different 
  implementation.
}
\value{
  A list object of class \code{"rating"} with the following 
  components

  \item{ratings}{A data frame of the results at the end of the 
    final time period. The variables are self explanatory except
    for \code{Lag}, which represents the number of time periods
    since the player last played a game. This is equal to zero
    for players who played in the latest time period, and is
    also zero for players who have not yet played any games.}
  \item{history}{A three dimentional array, or \code{NULL} if 
    \code{history} is \code{FALSE}. The row dimension is the 
    players, the column dimension is the time periods. 
    The third dimension gives different parameters.}
  \item{gamma}{The player one advantage parameter.}
  \item{kfac}{The K factor or K factor function.}
  \item{type}{The character string \code{"Elo"}.}
}
\references{
  Elo, Arpad (1978) 
  The Rating of Chessplayers, Past and Present. 
  Arco. ISBN 0-668-04721-6.
}
\seealso{
  \code{\link{fide}}, \code{\link{kfide}}
}
\examples{
afl <- aflodds[,c(2,3,4,7)]
robj <- elo(afl)
robj

robj <- elo(afl[afl$Week==1,])
for(i in 2:max(afl$Week)) robj <- elo(afl[afl$Week==i,], robj$ratings)
robj
}
\keyword{models}




