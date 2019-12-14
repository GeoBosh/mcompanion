\name{mc_order}
\alias{mc_order}
\alias{is_mc_bottom}
\title{
  Give the multi-companion order of a square matrix
}
\description{
  Determine the multi-companion order of a square matrix or check if a
  matrix may be the bottom part of a multi-companion matrix.
}
\usage{
mc_order(x)
is_mc_bottom(x)
}
\arguments{
  \item{x}{ a matrix }
}
\details{

  In \code{mc_order(x)} should be a square matrix, while in
  \code{is_mc_bottom(x)} the matrix is usually rectangular.

  The bottom part of a multi-companion matrix is of the form [I 0],
  where I is an identity matrix and 0 is a matrix of zeroes. The top
  consists of the rows above the bottom part.
  The multi-companion order is the number of rows in the top of a
  multi-companion matrix.

  Identity matrices have \code{mc_order} zero.
  Other general matrices have \code{mc_order} equal to the number of
  rows. In particular, an \eqn{1\times1}{1 x 1} matrix has \code{mc_order}
  zero, if its only element is equal to one, and \code{mc_order} one
  otherwise.

  Acordingly, \code{is_mc_bottom(x)} returns TRUE if \code{x} is the
  identity matrix or a matrix with zero rows.  This is consistent with
  the treatment of the identity matrix as multi-companion of multi order
  0 and a general matrix as multi-companion of multi-companion order
  equal to the number of its rows.

}
\value{
  for \code{mc_order}, the multi-companion order of \code{x}, a
  non-negative integer

  for \code{is_mc_bottom}, TRUE if \code{x} may be the bottom part of a
  multi-companion matrix and FALSE otherwise.

}
\references{%
    % bibentry: boshnakov2002mc
Boshnakov GN (2002).
``Multi-companion matrices.''
\emph{Linear Algebra Appl.}, \bold{354}, pp. 53--83.
ISSN 0024-3795, \url{http://dx.doi.org/10.1016/S0024-3795(01)00475-X}.
% end:bibentry:  boshnakov2002mc
}
\author{Georgi N. Boshnakov}
\note{
  It may make sense to allow non-square matrices also for \code{mc_order}.
}
\seealso{
  \code{\link{mc_full}}
}
\examples{
m <- mCompanion(matrix(1:8, nrow = 2))
mc_order(m)
}
\keyword{mcutil}
