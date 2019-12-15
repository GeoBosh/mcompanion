\name{spec_core}
\alias{spec_core}
\title{
  Parameterise Jordan chains of multi-companion matrices
}
\description{
  Parameterise the Jordan chains corresponding to a given eigenvalue of
  a multi-companion matrix.
}
\usage{
spec_core(mo, evalue, heights, ubasis = NULL, uorth = NULL, evspace = NULL)
}
\arguments{
  \item{mo}{multi-companion order, a positive integer.}
  \item{evalue}{eigenvalue, a real or complex number.}
  \item{heights}{
    dimensions of Jordan blocks of \code{evalue}, a vector of positive
    integers.
  }
  \item{ubasis}{basis of the universe, a matrix.}
  \item{uorth}{
    orthogonal complement of \code{ubasis} w.r.t. the full core basis,
    see Details.
  }
  \item{evspace}{The space spanned by the eigenvectors, see Details.}
}
\details{

  \code{spec_core} prepares a canonical representation of the parameters
  of a multi-companion matrix coresponding to an eigenvalue. Roughly
  speaking, free parameters are represented by NA's in the returned
  object. For no-repeated eigenvalues the parameterisation consists of
  the eigenvalue and the seed parameters of the eigenvector. Even then,
  for uniqueness some convention needs to be adopted.

  So, in general the  parameterisation is effectively in terms of
  subspaces.

  \strong{TODO:} Currently this is not documented and is work in
  progress, there are only some working notes (rakopis:
  "Some technical details about the parameterisation of mc-matrices").

}
\value{
  a list representing the parameterised chains corresponding to the
  eigenvalue. Currently it contains the following elements:
  \item{evalue}{}
  \item{heights}{}
  \item{co}{}
  \item{core.vectors}{}
  \item{param.tall}{}
  \item{param.hang}{}
  \item{generators}{}
}
\author{Georgi N. Boshnakov}
\examples{
spec_core(4, 1, c(1,1,1,1))

spec_core(4, 1, c(2,1,1,1))
spec_seeds1(c(2,2,2,2), 4)
spec_seeds1(c(2,1,1,1), 4)
spec_core(4, 1, c(2,1,1,1))$co
spec_core(4, 1, c(2,1,1,1))$generators
}
\keyword{ mcspec }
