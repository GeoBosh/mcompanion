\name{mc_matrix}
\alias{mc_matrix}
\alias{mc_full}
\alias{mc_order}
\alias{is_mc_bottom}
\title{ Basic utilities for multi-companion matrices }
\description{
  Compute the dense matrix representation of a multi-companion matrix or
  convert the argument to an ordinary matrix.
}
\usage{
mc_full(x)
mc_matrix(x)
mc_order(x)
is_mc_bottom(x)
}
\arguments{
  \item{x}{
    the top part of the multi-companion matrix or the whole matrix, see
    Details.
  }
}
\details{

  \code{mc_matrix} returns an ordinary matrix. It returns \code{x} if
  \code{x} is an ordinary matrix (\code{is.matrix(x) == TRUE}), converts
  \code{x} to a matrix with one row if \code{x} is a vector, and returns
  \code{as.matrix(x)} otherwise. \code{mc_matrix} is used by some
  functions in package \code{mcompanion} that want to allow flexible
  format for the top of a multicompanion matrix or even the whole matrix
  (e.g. \code{x} may be a \code{MultiCompanion} object) but are not
  really multi-companion aware.

  For \code{mc_full}, \code{x} is normally the top part of a
  multi-companion matrix. Rows are appended as necessary to obtain the
  dense representation of the matrix and the result is guaranteed to be
  a multi-companion matrix.  It is an error to have more rows than
  columns.  If the number of rows is equal to the number of columns,
  i.e. \code{x} is the whole matrix, the effect is that \code{x} is
  converted to an ordinary matrix but no check is made to see if the
  result is indeed a multi-companion matrix.
  \code{x} may be a vector if the multi-companion order is 1.



  Give the multi-companion order of a square matrix

  Determine the multi-companion order of a square matrix or check if a
  matrix may be the bottom part of a multi-companion matrix.

  
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
  for \code{mc_full}, the multi-companion matrix as an ordinary dense
  matrix object.

  For \code{mc_matrix}, an ordinary matrix.
  
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
\note{
  \code{mc_matrix} is not multi-companion specific, except that it
  converts a vector to a matrix with one row (not column).  For square
  matrices these functions are not really multi-companion specific.

  It may make sense to allow non-square matrices also for \code{mc_order}.
}
\author{Georgi N. Boshnakov}
\seealso{ \code{\link{mcStable}} }
\examples{
mc <- mCompanion("sim", dim = 4, mo = 2)
mc
mc_order(mc)
x <- mc[1:2, ]   # the top of mc
x
x2 <- mc[]      # whole mc as ordinary matrix
x2

mc_matrix(mc)
mc_matrix(x2)
## mc_matrix() doesn't append rows to its argument
mc_matrix(x)

## mc_full() appends rows, to make the matrix square multicompanion
mc_full(x)
## mc and x2 are square, so not amended:
mc_full(mc)
mc_full(x2)

## a vector argument is treated as a matrix with 1 row:
mc_matrix(1:4)
mc_full(1:4)
## mc_order(1:4) # not by mc_order


m <- mCompanion(matrix(1:8, nrow = 2))
mc_matrix(m)
mc_order(m)

m[-c(1,2), ]
is_mc_bottom(m[-c(1,2), ]) # TRUE

## TRUE for reactangular diagonal matrix with nrow < ncol
is_mc_bottom(diag(1, nrow = 3, ncol = 5))
## border cases
is_mc_bottom(matrix(0, nrow = 0, ncol = 4)) # TRUE, 0 rows
is_mc_bottom(diag(4))                       # TRUE, square diagonal matrix
}
\keyword{matrices}
