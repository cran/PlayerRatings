\name{aflodds}
\docType{data}
\alias{aflodds}
\title{Australian Football Game Results and Odds}
\usage{aflodds}
\description{
  The \code{aflodds} data frame has 675 rows and 9 variables. It
  shows the results and betting odds for 675 Australian football 
  games played by 18 teams from 26th March 2009 until 24th June
  2012.
}
\format{
  This data frame contains the following columns:
  \describe{
    \item{Date}{A date object showing the date of the game.}
	\item{Week}{The number of weeks since 25th March 2009.}
    \item{HomeTeam}{The home team name.}
    \item{AwayTeam}{The away team name.}
    \item{HomeScore}{The home team score.}
	\item{AwayScore}{The home team score.}
	\item{Score}{A numeric vector giving the value one, zero or one
	  half for a home win, an away win or a draw respectively.}
	\item{HomeOdds}{The best decimal odds offered for the home team.
	  This is missing for some earlier games.}
	\item{AwayOdds}{The best decimal odds offered for the away team.
	  This is missing for some earlier games.}
  }
}
\source{
  Wikipedia and www.oddsportal.com.
}
\keyword{datasets}

