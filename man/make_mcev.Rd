\name{make_mcev}
\alias{make_mcev}
\alias{make_mcgev}
\title{ Create a multi-companion eigenvector}
\description{
  Creates an eigenvector of a multicompanion matrix from the eigenvalue
  and the seed parameters.
}
\usage{
make_mcev(eigval, co, dim, what.co = "bottom")
make_mcgev(eigval, co, v, what.co = "bottom")
}
\arguments{
  \item{eigval}{ the eigenvalue. }
  \item{co}{
    the bottom (default) or the top seed elements of the vector.
  }
  \item{dim}{the size of the matrix. }
  \item{what.co}{ type of \code{co}: "bottom" or "top".  }
  \item{v}{ the previous vector in the chain.}
}
\details{
  \code{make_mcev} computes an eigenvector for a multi-companion (dim
  x dim) matrix by filling its top or bottom part with \code{co} and
  completing the remaining elements using the general pattern of
  eigenvectors of such matrices.

  Similarly, \code{make_mcgev} computes the next generalised
  eigenvector in a chain whose previous element is \code{v}.

  \code{what.co} cannot be "top" if the eigenvalue is 0. Generalised
  eigenvectors corresponding to the zero eigenvalue have some specifics,
  so it is better to use the specialised functions in that case.
}
\value{
  \code{make_mcev} returns the required eigenvector.

  \code{make_mcgev} returns the required generalised eigenvector.
}
\references{
  % bibentry: boshnakov2002mc
Boshnakov GN (2002).
``Multi-companion matrices.''
\emph{Linear Algebra Appl.}, \bold{354}, pp. 53--83.
ISSN 0024-3795, \url{http://doi.org/10.1016/S0024-3795(01)00475-X}.
% end:bibentry:  boshnakov2002mc
}
\author{Georgi N. Boshnakov}
\keyword{mcchain}
\keyword{internal}
