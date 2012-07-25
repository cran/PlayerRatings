\name{metrics}
\alias{metrics}
\title{Prediction Evaluation}
\description{
  Returns measures that assess prediction performance. 
}
\usage{
metrics(act, pred, cap = c(0.01,0.99), which = 1:3, na.rm = TRUE, 
  sort = TRUE, digits = 3, scale = TRUE)
}
\arguments{
  \item{act}{A numeric vector of actual values. Typically equal to
    one for a player one win, zero for a player two win, and one
    half for a draw.}
  \item{pred}{A numeric vector of predictions, typically values 
    between zero and one. A matrix can also be given, in which
    case the jth column contains the predictions for model j.}
  \item{cap}{A numeric vector of length two giving values at which
    to cap the binomial deviance.}
  \item{which}{Select metrics using any subset of \code{1:3}. All
    are produced by default.}
  \item{na.rm}{Remove missing values in predictions. The default is
    to remove missing values because the default predict method will
    predict missing values for games with new players.}
  \item{sort}{By default output is ordered from best to worst using
    the first metric specified.}
  \item{digits}{Round to this number of digits.}
  \item{scale}{If \code{TRUE} (the default), all metrics are scaled
    so that a value of 100 corresponds to predicting 0.5 for every
    game.}
}
\details{
  The preferred metric for assessing predictions in chess is
  the capped binomial deviance. Mean squared error and mean 
  absolute error metrics are also produced. By default all metrics 
  are scaled so that the value 100 represents the zero information
  case. If not scaled, then all metrics are multiplied by 100.
}
\value{
  A numeric vector.
}

\seealso{\code{\link{predict.rating}}}

\examples{
afl <- aflodds[,c(2,3,4,7)]
train <- afl[afl$Week <= 80,]
test <- afl[afl$Week > 80,]
robj <- elo(train)
metrics(test$Score, predict(robj, test))
metrics(test$Score, predict(robj, test), scale = FALSE)
}
\keyword{manip}




