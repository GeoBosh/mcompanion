\name{mc_factors}
\alias{mc_factors}
\title{ Factors of multi-companion matrices }
\description{
  Gives the factors comprising the companion factorisation of a
  multi-companion matrix.
}
\usage{
mc_factors(x, what = "mc")
}
\arguments{
  \item{x}{
    a multi-companion matrix, an object of class \code{MultiCompanion}.
  }
  \item{what}{format of the result, see below.}
}
\details{

  If the factors are available in the object's pad in the requested
  format, they are returned without further processing.
  The factors may be available if they have been previously computed or
  if the matrix has been created from the factors.

  If the factors are available, but not in the requested format, they are
  converted to it. Otherwise the factors are computed.

  The factors are stored in the object's pad under the name "mC.factors"
  when \code{what == "mc"}, and in "mC.factorsmat" otherwise.

}
\value{
  If \code{what == "mc"} the companion factors of \code{x} as a list of
  \code{MultiCompanion} objects.

  Otherwise a matrix with i-th row representing the i-th factor.

  As a side effect, the factors are stored in the object's pad, see
  `Details'.
}
%\references{ ~put references to the literature/web site here ~ }
\references{%
  \insertRef{boshnakov2002mc}{mcompanion}
}
\author{Georgi N. Boshnakov}
\examples{
m <- mCompanion(matrix(1:8, nrow = 2))
mc_factors(m)
}
\keyword{ matrices }
