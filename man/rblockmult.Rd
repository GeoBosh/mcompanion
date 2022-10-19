\name{rblockmult}
\alias{rblockmult}
\title{ Right-multiply a matrix by a block }
\description{
  Treats a matrix as a block matrix and multiplies each block by a given
  block.
}
\usage{
rblockmult(x, b)
}
\arguments{
  \item{x}{ the matrix. }
  \item{b}{ the block. }
}
\details{
  \code{x} is split into blocks [x1 ... xn] so that
  \code{ncol(xi)==nrow(b)} and each block is multiplied by \code{b}.
  The result is the matrix [x1 b ... xn b].
}
\value{
   the matrix obtained as described above
}
\author{Georgi N. Boshnakov}
\examples{
m <- matrix(1:12, nrow = 2)
b <- matrix(c(0, 1, 1, 0), nrow = 2)
rblockmult(m,b)
}
\keyword{matrices}
