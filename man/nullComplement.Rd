\name{null_complement}
\alias{null_complement}
\title{Compute the orthogonal complement of a subspace}
\description{Computes the orthogonal complement of a subspace relative
  to a universe.}
\usage{
null_complement(m, universe = NULL, na.allow = TRUE)
}
\arguments{
  \item{m}{
    NA or a matrix whose columns define the subspace, see Details.
  }
  \item{universe}{
    a matrix whose columns specify the subspace relative to
    which to compute the complement, the default is the full space.
  }
  \item{na.allow}{
    if \code{TRUE}, default, treat NA's specially, see Details.
  }
}
\details{

  Argument \code{universe} can be used to specify a subspace w.r.t.
  which to compute the complement.  If \code{universe} is \code{NULL}, a
  complement w.r.t. this full space is computed. The full space is
  deduced from the dimension of \code{m}.

  \code{null_complement} returns a matrix whose columns give a basis of
  the required subspace.

  \code{null_complement} uses \code{Null()} from package MASS for the
  actual computation. \code{null_complement(m, na.allow=FALSE)} is
  equivalent to \code{Null(m)}.

  \code{m} is typically a matrix whose columns represent the subspace
  w.r.t. which to compute the complement.
  \code{null_complement} can also deal with NA's in \code{m}. This
  facility can be turned off by specifying \code{na.allow = FALSE}.

  If \code{na.allow = TRUE}, the default, and \code{m} is identical to
  \code{NA}, \code{universe} is returned (i.e. \code{m = NA} represents
  the empty subspace). Note that in this case \code{universe} cannot be
  NULL, since there is no way to determine the dimension of the space.

  Otherwise, \code{m} is a matrix. If all elements of \code{m} are NA, a
  matrix of NA's is returned with number of columns equal to
  \code{ncol(universe) - ncol(m)}.

  \strong{TODO:}
  Currently, if \code{m} contains a mixture of numbers and NA's, the
  result is the same as when all entries of \code{m} are NA's. A
  complete implementation should handle this case better. However, in
  general, the result cannot be  a simple matrix.

}
\value{
  a matrix representing a basis of the requested subspace
}
\examples{
m1 <- diag(1, nrow = 3, ncol = 2)
null_complement(m1)

null_complement(c(1,1,0))
null_complement(c(1,1,0), m1)
}
\author{Georgi N. Boshnakov}
\keyword{matrices}
