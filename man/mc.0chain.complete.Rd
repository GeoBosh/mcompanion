\name{mc.0chain.complete}
\alias{mc.0chain.complete}
\title{ Extend or shrink eigenchains of 0 eigenvalues }
\description{
  Takes a Jordan chain of the 0 eigenvalue of a multi-companion
  matrix and modifies it to be a Jordan chain of a larger or smaller
  multi-companion matrix.
}
\usage{
mc.0chain.complete(dim, mo, chain, alt0)
}
\arguments{
  \item{dim}{ the size of the new matrix, a number. }
  \item{mo}{ the multi-companion order of the matrix.}
  \item{chain}{ the chain from which the new chain is to be derived. }
  \item{alt0}{ optional alternative initialisation for the free
    elements, see Details. }
}
\details{

  If the number of rows of \code{chain} is larger than or equal to
  \code{mo}, then \code{chain} represents a Jordan chain of the source
  mc-matrix with the eigenvector is in the first column.

  Otherwise (if \code{nrow(chain) < mo}) the number of rows is taken to
  be \code{mo.col} and the Jordan chain is that of the top \code{mo.col
  x mo.col} corner. In this case, the chain is extended first to a chain
  for the top left \code{mo x mo} corner. Argument \code{F0bot} allows
  this to be accomplished. It provides the \code{[(mo.col+1):mo, 1:mo]}
  block of the mc-matrix.

  \code{dim} specifies the dimension of the modified matrix.

  The number of elements in the new chain may be different from the
  original and the eigenvector may not be a shrunk version of the
  original eigenvector.

  The new Jordan chain is returned as a matrix of \code{dim} rows and
  number of columns determined automatically.

  When the new matrix is larger than the original, some of the elements
  of the last vector in the new chain are arbitrary. By default these
  elements are set to zero. Argument \code{alt0} can be used to change
  this. It should be a vector of length \code{dim - nrow(chain)}.

}
\value{
  a matrix
}
\author{Georgi N. Boshnakov}
\examples{
x1 <- cbind(c(1,1), c(1,2))
j1 <- diag(c(0.8, 0.5))
m1 <- x1 \%*\% j1 \%*\% solve(x1)
bo1 <- rbind(c(0.5, 0.8), c(0.256, 0.512))

j1a <- diag(c(0, 0.5))
m1a <- x1 \%*\% j1a \%*\% solve(x1)
f1a <- cbind( rbind(m1a, bo1), 0, 0 )
}
\keyword{ mcchain }
\keyword{internal}
