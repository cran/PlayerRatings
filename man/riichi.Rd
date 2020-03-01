\name{riichi}
\docType{data}
\alias{riichi}
\title{Riichi Mahjong Game Results}
\usage{aflodds}
\description{
  The \code{aflodds} data frame has 540 rows and 9 variables. It
  shows the results for 540 Riichi Mahjong games played by 69 
  players at the Melbourne Mahjong Club in 2019. Player identifiers 
  are randomly assigned.
}
\format{
  This data frame contains the following columns:
  \describe{
    \item{Time}{The day number within the year 2019.}
	\item{Play1}{Player 1 identifier.}
    \item{Play2}{Player 2 identifier.}
    \item{Play3}{Player 3 identifier.}
    \item{Play4}{Player 4 identifier.}
	\item{Score1}{Player 1 score.}
    \item{Score2}{Player 2 score.}
    \item{Score3}{Player 3 score.}
    \item{Score4}{Player 4 score.}
  }
}
\details{
  Players start the game with 25000 points. Mahjong is a zero-sum 
  game, therfore the sum of all four scores is always 100000. Negative 
  scores are possible. The largest recorded score is 93900. The 
  smallest recorded score is -24600.
}
\source{
  Hand collected by The Melbourne Mahjong Club.
}
\keyword{datasets}

