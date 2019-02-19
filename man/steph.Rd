\name{steph}
\alias{steph}
\title{The Stephenson Rating System}
\description{
  Implements the Stephenson rating system for estimating the relative 
  skill level of players in two-player games such as chess. It
  extends the Glicko method by including a second parameter 
  controlling player deviation across time, a bonus parameter, 
  and a neighbourhood parameter.   
}
\usage{
steph(x, status = NULL, init = c(2200,300), gamma = 0, cval = 10, 
  hval = 10, bval = 0, lambda = 2, history = FALSE, sort = TRUE, 
  rdmax = 350, \dots)
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
    \code{Deviation}, and optionally \code{Games}, \code{Win}, 
	\code{Draw}, \code{Loss} and \code{Lag}, which are set to zero 
    if not given.}
  \item{init}{The rating vector at which to initialize a new player 
    not appearing in \code{status}. Must be a vector of length two
    giving the initial rating and initial deviation respectively. 
    If different initializations for different players are 
    required, this can be done using \code{status}. The initial
	deviation cannot be greater than \code{rdmax}.}
  \item{gamma}{A player one advantage parameter; either a single
    value or a numeric vector equal to the number of rows in 
	\code{x}. Positive values favour player one, while negative 
	values favour player two. This could represent the advantage 
	of playing at home, or the advantage of playing white for chess. 
	Note that this is not passed to \code{\link{predict.rating}}, 
	which has its own \code{gamma} parameter.}
  \item{cval}{The c parameter, which controls the increase in the
    player deviations across time. Must be a single non-negative number. 
    Note that both \code{cval} and \code{hval} increase player 
    deviations, so if \code{hval} is not zero then \code{cval} should 
    typically be lower than the corresponding parameter in 
    \code{\link{glicko}}.}
  \item{hval}{The h parameter, which also controls the increase in the
    player deviations across time. Must be a single non-negative number.}
  \item{bval}{The bonus parameter, which gives a per game bonus to each
    player on the basis that players who play more often may improve
    irrespective of whether they win or lose. A single non-negative
    number. Note that this will create ratings inflation (i.e. ratings
    will increase over time).}
  \item{lambda}{The neighbourhood parameter, which shrinks player
    ratings towards their opponents. A single non-negative number.}
  \item{history}{If \code{TRUE} returns the entire history for each 
    period in the component \code{history} of the returned list.}
  \item{sort}{If \code{TRUE} sort the results by rating (highest
    to lowest). If \code{FALSE} sort the results by player.}
  \item{rdmax}{The maximum value allowed for the rating deviation.}
  \item{\dots}{Not used.}
}
\details{
  The Stephenson rating system is a method for evaluating the skill 
  of players. It was developed by Alec Stephenson in 2012 as a variant 
  of his winning entry in a competition to find the most useful 
  practical chess rating system, organized by Jeff Sonas on Kaggle,
  a platform for data prediction competitions. The precise details 
  are given in the file doc/ChessRatings.pdf.

  This implementation is written so that Glicko is obtained as a 
  special case upon setting all of the parameters \code{hval}, 
  \code{bval} and \code{lambda} to zero. Default values are roughly 
  optimized for the chess data analyzed in the file 
  doc/ChessRatings.pdf, using the binomial deviance criterion.
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
    players, the column dimension is the time periods. The 
    third dimension gives different parameters.}
  \item{gamma}{The player one advantage parameter.}
  \item{cval}{The c parameter.}
  \item{hval}{The h parameter.}
  \item{bval}{The bonus parameter.}
  \item{lambda}{The neighbourhood parameter.}
  \item{type}{The character string \code{"Stephenson"}.}
}
\references{
  Glickman, M.E. (1999) 
  Parameter estimation in large dynamic paired comparison experiments. 
  J. R. Stat. Soc. Ser. C: Applied Statistics, 48(3), 377-394.
  
  Glickman, M.E. (2001) 
  Dynamic paired comparison models with stochastic variances. 
  Journal of Applied Statistics, 28, 673-689.
}

\seealso{\code{\link{glicko}}}

\examples{
afl <- aflodds[,c(2,3,4,7)]
robj <- steph(afl)
robj

robj <- steph(afl[afl$Week==1,])
for(i in 2:max(afl$Week)) robj <- steph(afl[afl$Week==i,], robj$ratings)
robj
}
\keyword{models}




