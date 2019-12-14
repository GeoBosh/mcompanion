\name{mc_full}
\alias{mc_full}
\alias{mc_matrix}
\title{ Basic utilities for multi-companion matrices }
\description{
  Compute the dense matrix representation of a multi-companion matrix or
  convert the argument to an ordinary matrix.
}
\usage{
mc_full(x)
mc_matrix(x)
}
\arguments{
  \item{x}{ the top part of the multi-companion matrix or the whole
    matrix, see details }
}
\details{

  \code{mc_matrix} is an auxilliary function which returns an ordinary
  matrix. It returns \code{x} if \code{x} is an ordinary matrix
  (\code{is.matrix(x)==TRUE}), converts \code{x} to a matrix with one
  row if \code{x} is a vector, and returns \code{as.matrix(x)}
  otherwise. \code{mc_matrix} is used by some functions in package
  \code{mcompanion} that want to allow flexible format for the top of a
  multicompanion matrix or even the whole matrix (e.g. \code{x} may be a
  \code{MultiCompanion} object) but are not really multi-companion aware.

  For \code{mc_full}, \code{x} is normally the top part of a
  multi-companion matrix. Rows are appended as necessary to obtain the
  dense representation of the matrix and the result is guaranteed to be
  a multi-companion matrix.  It is an error to have more rows than
  columns.  If the number of rows is equal to the number of columns,
  i.e. \code{x} is the whole matrix, the effect is that \code{x} is
  converted to an ordinary matrix but no check is made to see if the
  result is indeed a multi-companion matrix.
  \code{x} may be a vector if the multi-companion order is 1.
}
\value{
  For \code{mc_full}, the multi-companion matrix as an ordinary dense
  matrix object.

  For \code{mc_matrix}, an ordinary matrix.
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
}

\author{Georgi N. Boshnakov}
\seealso{ \code{\link{mcStable}} }
\examples{
mc <- mCompanion("sim",dim=4,mo=2)
mcStable(mc)
x <- mc[1:2,]   # get the  top of mc
x2 <- mc[]      # whole mc as ordinary matrix
mc_matrix(x)
mc_matrix(mc)
mc_matrix(x2)

mc_full(x)
mc_full(mc)
mc_full(x2)
}
\keyword{mcutil}
