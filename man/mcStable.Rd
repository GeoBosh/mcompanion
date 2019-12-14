\name{mcStable}
\alias{mcStable}
\alias{mcStable-methods}
\title{ Check if an object is stable }
\description{
  Check if an object is stable.
}
\usage{
mcStable(x)
}
\arguments{
  \item{x}{ the object to be checked }
}
\details{

  A stable matrix is a matrix all of whose eigenvalues have moduli less
  than one. Other objects are stable if the associated matrix is
  stable.

  This is a generic function. The default method works as follows.
  \code{x} is a square matrix, the method checks if its eigenvalues
  satisfy the stability condition and returns the result.

  Otherwise, if \code{x} is a rectangular matrix with more columns than
  rows, it is assumed to be the top of a multi-companion matrix. If
  \code{x} is a vector, it is assumed to represent the top row of a
  companion matrix. In all other cases \code{x} is converted to matrix
  with \code{as.matrix(x)}. The result should be a square matrix whose
  eigenvalues are checked.
  It is an error for the matrix to have more rows than columns.

}
\value{
  TRUE if the object is stable and  FALSE otherwise
}
\note{

  An argument \code{\dots} may be a good idea since methods may wish to
  provide options. For example, for continuous
  time systems, the stability condition is that the real parts of the
  eigenvalues are negative.

  For example, an option to choose the left half-plane for the stable
  region, instead of the unit circle, would handle stability for
  continuous time systems.

}
\author{Georgi N. Boshnakov}
\examples{
## a simulated matrix (it is stable by default)
mc <- mCompanion("sim", dim=4, mo=2)
mcStable(mc)

## a square matrix
m <- matrix(1:9, nrow=3)
eigen(m)$values
mcStable(m)

## a 2x4 matrix, taken to be the top of an mc matrix
m <- matrix(1:8, nrow=2)
mcStable(m)
mCompanion(m)

## a vector, taken to be the top row of an mc matrix
v <- 1:4
mcStable(v)
mCompanion(v)
abs(mc_eigen(mCompanion(v))$values)

co1 <- cbind(c(1,1,1,1), c(0,1,0,0))

## a matrix with eigenvalues equal to 1
mat2 <- make_mcmatrix(eigval = c(1), co = co1, dim = 4, len.block = c(2))
## mat2 is ordinary matrix, eigenvalues are computed numerically
eigen(mat2)
mcStable(mat2)  # FALSE but in general depends on floating point arithmetic

mat2a <- mCompanion(x="gen", eigval = c(1), co = co1, dim = 4, len.block = c(2), what.res = "list")
mc_eigen(mat2a)
mcStable(mat2a)


mat2b0 <- make_mcmatrix(eigval = c(1), co = co1, dim = 4, len.block = c(2), what = "list")
mat2b <- mCompanion(mat2b0, "gen")
mc_eigen(mat2b)
mcStable(mat2b)

## mat2c is a MultiCompanion object with the eigenvalues stored in it
mat2c <- mCompanion(x="sim", eigval = c(1,0,0), co = cbind(co1, c(0,0,1,0), c(0,0,0,1)),
                    dim = 4, len.block = c(2,1,1))
mat2c
## since the eigenvalues are directly available here, no need to compute them
mc_eigen(mat2c) # contains a 2x2 Jordan block.
mcStable(mat2c)
}
\keyword{ matrices }
