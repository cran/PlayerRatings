\name{glicko2}
\alias{glicko2}
\title{The Glicko-2 Rating System}
\description{
  Implements the Glicko-2 rating system for estimating the relative 
  skill level of players in two-player games such as chess. It
  extends the Glicko method by including a volatility parameter for
  each player, representing the degree of expected fluctuation in 
  the rating. Volatility is therefore a measure of consistency of
  performance.  
}
\usage{
glicko2(x, status = NULL, init = c(2200,300,0.15), gamma = 0, 
    tau = 1.2, history = FALSE, sort = TRUE, rdmax = 350, \dots)
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
    \code{Deviation}, \code{Volatility}, and optionally \code{Games}, 
	\code{Win}, \code{Draw}, \code{Loss} and \code{Lag}, which are 
	set to zero if not given.}
  \item{init}{The rating vector at which to initialize a new player 
    not appearing in \code{status}. Must be a vector of length three
    giving the initial rating, initial deviation and initial volatility 
	respectively. If different initializations for different players are 
    required, this can be done using \code{status}. The initial
	deviation cannot be greater than \code{rdmax}. The initial
	volatility cannot be greater than \code{rdmax} divided by 
	\code{400/log(10)}.}
  \item{gamma}{A player one advantage parameter; either a single
    value or a numeric vector equal to the number of rows in 
	\code{x}. Positive values favour player one, while negative 
	values favour player two. This could represent the advantage 
	of playing at home, or the advantage of playing white for chess. 
	Note that this is not passed to \code{\link{predict.rating}}, 
	which has its own \code{gamma} parameter.}
  \item{tau}{The tau parameter, which controls the change in the
    player volatility across time. Smaller values prevent the 
	  volatility measures from changing by large amounts. Must be a 
	  single number. Mark Glickman suggests a value between 0.3 and 1.2.
	  A non-positive value can be specified, in which case the 
	  volatilities are never updated.}
  \item{history}{If \code{TRUE} returns the entire history for each 
    period in the component \code{history} of the returned list.}
  \item{sort}{If \code{TRUE} sort the results by rating (highest
    to lowest). If \code{FALSE} sort the results by player.}
  \item{rdmax}{The maximum value allowed for the rating deviation.
    The maximum value allowed for the volatility is \code{rdmax} 
	divided by \code{400/log(10)}.}
  \item{\dots}{Not used.}
}
\details{
  The Glicko-2 rating system is a method for evaluating the skill 
  of players. It is more complex than Glicko because it includes a 
  volatility for each player. It requires a single parameter 
  optimization for each player within each time period. We use the
  R function \code{optimize} in preference to the root-finding 
  approaches suggested in Glickman (2001) and Glickman (2013).
  Default values are roughly optimized for the chess data analyzed 
  in the file doc/ChessRatings.pdf, using the binomial deviance 
  criterion. A player one advantage parameter has been added to 
  the original definition in the reference. A player one advantage 
  parameter is also used for prediction purposes in 
  \code{\link{predict.rating}}.
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
  \item{history}{A three dimensional array, or \code{NULL} if 
    \code{history} is \code{FALSE}. The row dimension is the 
    players, the column dimension is the time periods. 
    The third dimension gives different parameters.}
  \item{gamma}{The player one advantage parameter.}
  \item{tau}{The tau parameter.}
  \item{type}{The character string \code{"Glicko-2"}.}
}
\references{
  Glickman, M.E. (2001) 
  Dynamic paired comparison models with stochastic variances. 
  Journal of Applied Statistics, 28, 673-689.
  
  Glickman, M.E. (2013) 
  Example of the Glicko-2 system.
}

\seealso{\code{\link{elo}}, \code{\link{glicko}}, \code{\link{steph}}}

\examples{
initstate <- data.frame(Player=1:4, Rating = c(1500,1400,1550,1700), 
  Deviation = c(200,30,100,300), Volatility = 0.06)
games <- data.frame(Week = 1, Payer1 = 1, Player2 = 2:4, Score = c(1,0,0))
robj <- glicko2(games, status = initstate, tau = 0.5, sort = FALSE)
print(robj, cols = 1:4, digits = 6)

afl <- aflodds[,c(2,3,4,7)]
robj <- glicko2(afl)
robj

robj <- glicko2(afl[afl$Week==1,])
for(i in 2:max(afl$Week)) robj <- glicko2(afl[afl$Week==i,], robj$ratings)
robj
}
\keyword{models}




