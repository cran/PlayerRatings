\name{elom}
\alias{elom}
\title{Multi-player Elo Based Rating System}
\description{
  Implements the Elo based rating system for for multi-player games
  where the result is a placing or a score. This includes zero-sum
  games such as poker and mahjong. The default arguments used here 
  are those used by Tenhou for riichi mahjong. 
}
\usage{
elom(x, nn = 4, exact = TRUE, base = c(30,10,-10,-30), status = NULL, 
    init = 1500, kfac = kriichi, history = FALSE, sort = TRUE, \dots,
	placing = FALSE)
}
\arguments{
  \item{x}{A data frame containing \code{2nn+1} variables, where 
    \code{nn} is the number of players in a single game: (col \code{1}) 
	a numeric vector denoting the time period in which the game 
	took place, (cols \code{2} to \code{nn+1}) numeric or character 
	identifiers for each of the \code{nn} players, (cols \code{nn+2} 
	to \code{2nn+1}) the result of the game expressed as a number, 
	typically a score for each player (e.g. the number of remaining 
	chips in poker). Negative numbers are allowed. 
	Alternatively, the result can be a placing (e.g. 1 for 
    first place, 2 for second place), in which case the \code{placing}
	argument MUST be set to \code{TRUE}. Placings must be integers: in the
	event of a tie, multiple players can be given the same placing.}
  \item{nn}{Number of players in a single game. If the number of players
    varies, then this argument should be set to the maximum number of 
	players in any game, and the \code{exact} argument should be set to
	\code{FALSE}. Unused player identifiers in \code{x} must then 
	be set to the missing value \code{NA}. The game score for \code{NA}
	player identifiers is ignored and therefore can also be set to 
	\code{NA}.}
  \item{exact}{If \code{TRUE} (the default), then every game always has 
    exactly \code{nn} players. If \code{TRUE}, then \code{x} cannot have 
	missing values.}
  \item{base}{The base values used for the rating. Can be a numeric 
    vector of length equal to \code{nn}, a numeric matrix with \code{nrow(x)}
    rows and \code{nn} columns,	or a vectorized function of 
	the game score. If a numeric vector, then the person with the highest 
	score gets \code{base[1]}, the person with the second highest score 
	gets \code{base[2]}, and so on. In the event of a tie on the game score, 
	tied players are given the largest available \code{base} value. For 
	games with less than \code{nn} players, see Details. If \code{base} is
	a matrix, then the ith row is used for the ith game in \code{x}. If 
	\code{base} is a vectorized function, then each player gets 
	the result of the function applied to the game score. In Riichi 
	mahjong, where players start with 25000 points, a typical example 
	might be \code{function(x) (x-25000)/250}.}
  \item{status}{A data frame with the current status of the
    system. If not \code{NULL}, this needs to be a data frame 
    in the form of the \code{ratings} component of the returned 
    list, containing variables named \code{Player}, \code{Rating},
    and optionally \code{Games}, \code{1st}, \code{2nd}, 
	\code{3rd} and so on, and finally \code{Lag}, which 
	are all set to zero if not given.}
  \item{init}{The rating at which to initialize a new player not
    appearing in \code{status}. Must be a single number. If
    different initializations for different players are required,
    this can be done using \code{status}.}
  \item{kfac}{The K factor parameter. Can be a single number or
    a vectorized function of two arguments, the first being the
    ratings and the second being the number of games played. See
    \code{\link{kriichi}} for an example.}
  \item{history}{If \code{TRUE} returns the entire history for each 
    period in the component \code{history} of the returned list.}
  \item{sort}{If \code{TRUE} sort the results by rating (highest
    to lowest). If \code{FALSE} sort the results by player.}
  \item{\dots}{Passed to the function \code{kfac}.}
  \item{placing}{If the results are given as placings (e.g. 1 for 
    first place, 2 for second place) then this argument MUST be set
	to \code{TRUE}, otherwise the placings will be interpreted 
	as game scores.}
}
\details{
  For multi-player games there is no player one advantage parameter 
  (e.g. a home advantage in football or a white advantage in chess). 
  
  If the sum of the vector \code{base} is not zero, or
  if \code{base} is a function which is not zero when evaluated
  at the starting chip/points value, then you may observe 
  unusual behaviour and/or substantial ratings inflation/deflation.
  
  The two-player Elo system is based on game outcomes in the interval 
  [0,1] and therefore uses a different scaling. As a result, the K 
  factors here should be smaller. The default (as used by Tenhou)
  is a K factor of 0.2 for players that have played a large number of
  games (see \code{\link{kriichi}}).
  
  If the number of players varies and \code{base} is a vector (of length 
  \code{nn}), then if the game has less than \code{nn} players, the vector 
  is reduced by successively removing the centre value (for odd lengths) 
  or by averaging both centre values (for even lengths). For example, if 
  the \code{x} data frame contains both four-player and three-player 
  mahjong games, then under the default values the three-player base 
  vector becomes \code{c(30,0,-30)}, which is consistent with the vector 
  that Tenhou uses for three-player mahjong.
  
  A numeric matrix can be used to allocate different \code{base} vectors to
  different games. For example, in Riichi mahjong, games can be Tonpuusen 
  (East round only) or Hanchan (East and South rounds), and you may wish
  to allocate different base vectors to each type.  
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
  \item{nn}{The number of players for a single game.}
  \item{kfac}{The K factor or K factor function.}
  \item{type}{The character string \code{"EloM"}.}
}
\references{
  Elo, Arpad (1978) 
  The Rating of Chessplayers, Past and Present. 
  Arco. ISBN 0-668-04721-6.
}
\seealso{
  \code{\link{elo}}, \code{\link{fide}}, \code{\link{glicko}}, \code{\link{kriichi}}
}
\examples{
robj <- elom(riichi)
robj

ut <- unique(riichi$Time)
robj <- elom(riichi[riichi$Time == ut[1],])
for(i in 2:length(ut)) {
  robj <- elom(riichi[riichi$Time == ut[i],], status = robj$ratings)
}
robj
}
\keyword{models}




