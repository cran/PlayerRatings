\name{predict.rating}
\alias{predict.rating}

\title{Predict Result Of Games Based On Player Ratings}
\description{
  Predict the result of two-player games as a number between zero 
  and one, given the estimated ratings for each player.
}
\usage{
\method{predict}{rating}(object, newdata, tng=15, trat=NULL, gamma=30, 
  thresh, \dots)
}
\arguments{
  \item{object}{An object of class \code{"rating"}.}
  \item{newdata}{A dataframe containing three variables: (1) a 
    numeric vector denoting the time period in which the game 
    is taking place (2) a numeric or character identifier for 
    player one (3) a numeric or character identifier for player 
    two. The time period can contain missing values as it is not 
    used for the prediction. Note that this argument cannot be
    missing; if predictions on the original dataset are required,
    then this dataset must be passed to the prediction function.}
  \item{tng}{A single value. If the number of games played by 
    either player is below this value, then either the prediction
    will be a missing value, or the prediction will be based on
    \code{trat}.}
  \item{trat}{Either a single number or a vector of length two,
    giving the rating and deviation parameters to be used for 
    players who have played less than \code{tng} games. If 
    \code{NULL} then these predictions will be missing.}
  \item{gamma}{A player one advantage parameter; either a single
    value or a numeric vector equal to the number of rows in 
	\code{newdata}. Positive values favour player one, while 
	negative values favour player two. This could represent the 
	advantage of playing at home, or the advantage of playing 
	white for chess. The default value is roughly optimal for 
	chess ratings.}
  \item{thresh}{A single value. If given, a binary vector is 
    returned indicating whether the prediction is greater than 
	this value.}
  \item{\dots}{Not used.}
}
\details{
  The function predicts the expectation of the game result. If the 
  value of one is a win for player one, and the value of zero is a 
  win for player two, and there are no other possibilities, then the
  prediction is the probability of a win for player one. This
  is not the case when draws are a possibility.  
}
\value{
  A numeric vector of predictions, which may contain missing 
  values.
}

\seealso{\code{\link{metrics}}}

\examples{
afl <- aflodds[,c(2,3,4,7)]
train <- afl[afl$Week <= 80,]
test <- afl[afl$Week > 80,]
robj <- elo(train)
pvals <- predict(robj, test)
}
\keyword{models}
