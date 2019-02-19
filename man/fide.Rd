\name{fide}
\alias{fide}
\title{The Elo Rating System Employed By The FIDE}
\description{
  Implements the Elo rating system for estimating the relative 
  skill level of players in two-player games such as chess,
  implementing a version similar to that employed by the FIDE. 
}
\usage{
fide(x, status = NULL, init = 2200, gamma = 0, kfac = kfide, 
    history = FALSE, sort = TRUE, \dots)
}
\arguments{
  \item{x}{A data frame containing four variables: (1) a numeric
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
	\code{Loss} \code{Lag} and \code{Elite}, which are set 
    to zero if not given, and \code{Opponent}, which is set
    to the player rating if not given.}
  \item{init}{The rating at which to initialize a new player not
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
    a vectorized function of three arguments, the first being the
    ratings, the second being the number of games played, and the
    third being a binary indicator for whether or not a player 
    has ever achieved a rating above 2400.  See \code{\link{kfide}}, 
    \code{\link{kgames}}  and \code{\link{krating}} for examples.
    The function \code{\link{kfide}} is used by default.}
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
  original definition in the reference. A player one advantage 
  parameter is also used for prediction purposes in 
  \code{\link{predict.rating}}.

  This implementation uses default arguments that are consistent 
  with the implementation of FIDE for rating chess players.
  It does not employ the initialization used by FIDE. For the
  chess data analyzed in the file doc/ChessRatings.pdf, prediction
  performance is poor because the default values of the K factors
  are too low. This can be altered using the \code{kv} argument 
  which is passed to the function \code{\link{kfide}}.
}
\value{
  A list object of class \code{"rating"} with the following 
  components

  \item{ratings}{A data frame of the results at the end of the 
    final time period. The variables are self explanatory except
    for \code{Lag}, which represents the number of time periods
    since the player last played a game, \code{Elite}, which
    is a binary indicator for whether or not a player has ever
    reached 2400, and \code{Opponent}, which gives the average 
    rating of all opponents. The \code{Lag} variable is equal 
    to zero for players who played in the latest time period, 
    and is also zero for players who have not yet played any 
    games. The \code{Elite} variable is required due to the 
    K factor dependency in the FIDE implementation. The
    \code{Opponent} variable is not currently used in the
    updating algorithm.}
  \item{history}{A three dimensional array, or \code{NULL} if 
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

\seealso{\code{\link{elo}}, \code{\link{kfide}}}

\examples{
afl <- aflodds[,c(2,3,4,7)]
robj <- fide(afl)
robj

robj <- fide(afl[afl$Week==1,])
for(i in 2:max(afl$Week)) robj <- fide(afl[afl$Week==i,], robj$ratings)
robj
}
\keyword{models}




