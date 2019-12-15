\name{mc_factorize}
\alias{mc_factorize}
\alias{mc_leftc}
\title{ Factorise multi-companion matrices }
\description{
  Companion factorization of multi-companion matrices.
}
\usage{
mc_factorize(x, mo, mo.col)
mc_leftc(x, mo, mo.col)
}
\arguments{
  \item{x}{ a multi-companion matrix or its top. }
  \item{mo}{ multi-companion order, number of structural top rows. }
  \item{mo.col}{ number of non-trivial columns in the top of the matrix. }
}
\details{
  The companion factorization of a multi-companion matrix, \eqn{X}, of
  (multi-companion) order \eqn{p} is
  \eqn{X=A_1\times\cdots\times A_p}{X=A[1]...A[p]},
  where \eqn{A_i}{A[i]}, \eqn{i=1,\dots,p}{i=1,...,p}, are companion
  matrices.

  \code{mc_leftc} factorises a multi-companion matrix into a product
  of companion times multi-companion.

  \code{mc_factorize} calls \code{mc_leftc} a number of times to compute
  the full factorisation.

  If \code{x} is not a matrix an attempt is made to convert it to
  matrix. If \code{x} is a vector it is converted to a matrix with 1 row.

  \code{x} may be the whole matrix or its top.
  If \code{mo} is missing \code{x} is assumed to be the top of the
  matrix and the multi-companion order is set to its number of rows.

  \code{mo.col} defaults to the number of columns of \code{x}.
  It is important to specify \code{mo.col} if there are columns of
  zeroes in the top of the matrix. Otherwise the factorisation usually
  fails with a message (from \code{solve}) that the system is exactly
  singular. Note however that for objects of class MultiCompanion this
  situation is handled automatically (unless the user overwrites the
  default behaviour).
}
\value{
  for \code{mc_factorize}, a matrix whose i-th row is the first row of
  the i-th companion factor.

  for \code{mc_leftc}, a numeric vector containing the first row of the
  companion factor. 
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

  The companion factorisation does not always exist but currently this
  possibility is not handled. Even if it exists, it may be numerically
  unstable.

  Also, if \code{mo.col} is smaller than the number of columns, then the
  factorisation is not unique, the one having \code{mo.col} non-zero
  entries is computed.   The existence is not treated.

  \code{mc_leftc} is probably the first function I wrote for
  multi-companion matrices. It does not do checks consistently. The
  MultiCompanion class can be used here.

}
\section{Level}{0}
\seealso{ \code{\link{mc_from_factors}} }
\examples{
mat2 <- make_mcmatrix(eigval = c(1), co = cbind(c(1,1,1,1), c(0,1,0,0)), dim = 4, len.block = c(2))
mat2
eigen(mat2)
mc_leftc(mat2, mo = 4, mo.col = 2)
mCompanion(mat2)
mCompanion(mat2, mo=4, mo.col=2)
mc_leftc(mCompanion(mat2), mo = 4, mo.col = 2)
mc_eigen(mCompanion(mat2), mo = 4, mo.col = 2)
mc_eigen(mCompanion(mat2, mo=4, mo.col=2), mo = 4, mo.col = 2)
}
\keyword{matrices}
