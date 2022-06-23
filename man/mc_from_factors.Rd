\name{mc_from_factors}
\alias{mc_from_factors}
\alias{mc_from_filter}
\title{ Multi-companion matrix from factors }
\description{
  Compute a multi-companion matrix from its companion factors or from a
  periodic filter. Create the multi-companion matrix corresponding to a
  periodic filter by multiplying the relevant companion matrices in
  reverse order.
}
\usage{
mc_from_factors(x)
mc_from_filter(x)
}
\arguments{
  \item{x}{ a matrix with a row for each companion factor, see details. }
}
\details{

  \code{x} is a matrix whose i-th row is the top row of the i-th
  companion factor (for \code{mc_from_factors}) or the filter
  coefficients for the i-th season (for \code{mc_from_filter}).

  \code{mc_from_factors} is, effectively, the inverse of \code{\link{mc_factorize}}.
  The companion matrices specified by the argument are multiplied.

  \code{mc_from_filter} is similar except that the relevant companion
  matrices are multiplied in reverse order. After all, it is natural to
  have the coefficients for the i-th season in the i-th row!

  todo: add an argument to specify the "first" season.
}
\value{
  The top of the resulting multi-companion matrix.
}
\references{%
  \insertRef{boshnakov2002mc}{mcompanion}
}
\author{Georgi N. Boshnakov}
\section{Level}{Currently \code{mc_from_factors} calls \code{mCompanion}, which it probably
  should not do.}
\seealso{ \code{\link{mc_factorize}} }
\examples{
x <- matrix(1:8, nrow = 2)
mc_from_factors(x)
mCompanion(mc_from_factors(x))

mc_from_filter(x)
mCompanion(mc_from_filter(x))
}
\keyword{matrices}
