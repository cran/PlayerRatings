\name{predict.rating}
\alias{predict.rating}

\title{Predict Result Of Games Based On Player Ratings}
\description{
  Predict the result of two-player or multi-player games, 
  given the estimated ratings for each player.
}
\usage{
\method{predict}{rating}(object, newdata, tng=15, trat=NULL, gamma=30, 
  thresh, placing = FALSE, \dots)
}
\arguments{
  \item{object}{An object of class \code{"rating"}.}
  \item{newdata}{For two player games, a dataframe containing 
    three variables: (1) a numeric vector denoting the time period 
	in which the game is taking place (2) a numeric or character 
	identifier for player one (3) a numeric or character identifier 
	for player two. The time period can contain missing values as 
	it is not used for the prediction. For N-player games (i.e.
	for objects created by the \code{elom} function), the player 
	identifiers should be in columns 2 to N-1. This argument cannot 
	be missing; if predictions on the original dataset are required,
    then this dataset must be passed to the prediction function.}
  \item{tng}{A single value. If the number of games played by 
    any player is below this value, then either the prediction
    will be a missing value, or the prediction will be based on
    \code{trat}.}
  \item{trat}{A single number (for Elo and EloM), or a vector of 
    length two (for Glicko or Glicko-2 or Stephenson) giving the 
	rating and deviation parameters to be used for players who have 
	played less than \code{tng} games. If \code{NULL} then these 
    predictions will be missing. The volatility parameter in 
    Glicko-2 is not needed for predictions.}
  \item{gamma}{A player one advantage parameter; either a single
    value or a numeric vector equal to the number of rows in 
	\code{newdata}. Positive values favour player one, while 
	negative values favour player two. This could represent the 
	advantage of playing at home, or the advantage of playing 
	white for chess. The default value is roughly optimal for 
	chess ratings. Ignored for multi-player.}
  \item{thresh}{A single value. If given, a binary vector is 
    returned indicating whether the prediction is greater than 
	this value. Ignored for multi-player.}
  \item{placing}{For multi-player only. If \code{TRUE}, predicted
    placings are given rather than expected base scores.}
  \item{\dots}{Not used.}
}
\details{
  The function predicts the expectation of the game result. In 
  two-player games, if the value of one is a win for player one, and 
  the value of zero is a win for player two, and there are no other 
  possibilities, then the prediction is the probability of a win 
  for player one. This is not the case when draws are a possibility.

  For multi-player predictions using objects produced by \code{elom}, 
  expected base scores are given for each player. These are simply the 
  difference between the rating of a player and the average of all 
  players in the game, divided by 40.
}
\value{
  A numeric vector of predictions of two-player games, or a matrix of 
  expected base scores for multi-player games, either of which may contain 
  missing values.
}

\seealso{\code{\link{elo}}, \code{\link{elom}}, \code{\link{metrics}}}

\examples{
afl <- aflodds[,c(2,3,4,7)]
train <- afl[afl$Week <= 80,]
test <- afl[afl$Week > 80,]
robj <- elo(train)
pvals <- predict(robj, test)

train <- riichi[riichi$Time <= 250,]
test <- riichi[riichi$Time > 250,]
robj <- elom(train)
predict(robj, test, trat = 1400, placing = TRUE)
}
\keyword{models}
