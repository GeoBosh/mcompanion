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
    NA or a matrix whose columns define the subspace, a vector is
    treated as a matrix with one column.
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

  \code{null_complement} computes the orthogonal complement of a
  subspace (spanned by the columns of \code{m}) relative to a universe.

  Argument \code{universe} can be used to specify a subspace w.r.t.
  which to compute the complement.  If \code{universe} is \code{NULL}
  (the default), the complement w.r.t. the full space is computed. The
  full space is the \eqn{n}-dimensional space, where \eqn{n} is the
  number of rows of argument \code{m}.

  \code{null_complement} returns a matrix whose columns give a basis of
  the required subspace.

  \code{null_complement} uses \code{Null()} from package MASS for the
  actual computation. \code{null_complement(m, na.allow = FALSE)} is
  equivalent to \code{Null(m)}.

  \code{m} is typically a matrix whose columns represent the subspace
  w.r.t. which to compute the complement.
  \code{null_complement} can also deal with NA's in \code{m}. This
  facility can be turned off by specifying \code{na.allow = FALSE}.

  If \code{na.allow = TRUE}, the default, and \code{m} is identical to
  \code{NA}, \code{universe} is returned (i.e. \code{m = NA} represents
  the empty subspace). Note that in this case \code{universe} cannot be
  NULL, since there is no way to determine the dimension of the full
  space.

  Otherwise, \code{m} is a matrix. If all elements of \code{m} are
  \code{NA}, a matrix of NA's is returned with number of columns equal
  to \code{ncol(universe) - ncol(m)}.
}
\value{
  a matrix representing a basis of the requested subspace
}
\examples{
m1 <- diag(1, nrow = 3, ncol = 2)
null_complement(m1)

null_complement(c(1,1,0))
null_complement(c(1,1,0), m1)

## the columns of the result from null_complement() are orthogonal
## to  the 1st argument:
t(c(1,1,0)) \%*\% null_complement(c(1,1,0))
t(c(1,1,0)) \%*\% null_complement(c(1,1,0), m1)

null_complement(rep(NA_real_, 3), m1)
null_complement(NA, m1)
}
\author{Georgi N. Boshnakov}
\keyword{matrices}
