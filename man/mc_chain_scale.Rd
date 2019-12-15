\name{mc_chain_scale}
\alias{mc_chain_scale}
\title{Scale vectors in eigenchains of multi-companion matrices}
\description{
  Scale vectors in an eigenchain of a multi-companion matrix. Currently
  the factor is determined so that the seeding coefficient with the
  maximal value becomes equal to one. By default the seeding
  coefficients at the bottom are examined.
}
\usage{
mc_chain_scale(ev, subset = NULL, fvec = NULL, fchain = NULL)
}
\arguments{
  \item{ev}{
    the eigenvectors, a list with elements \code{"eigvec"},
    \code{"len.block"}.
  }
     % \item{how}{ Not used currently, the action taken makes the largest
     %   bottom parameters equal to 1. }
  \item{subset}{subset of the eigenvectors to examine, a string or a
    vector of integers suitable for indexing.}
  \item{fvec}{a function for the computation of the normailising factor,
    see Details.}
  \item{fchain}{can be used to specify a more general transformation, a
    function, see Details.}
}
\details{

  All vectors in the chain are scaled by the same factor.

  The factor is determined so that the seeding coefficient with the
  maximal modulus becomes equal to one. By default the seeding
  coefficients at the bottom of the eigenvector are examined but if
  argument \code{subset} is equal to "top" the tops are checked
  instead. \code{subset} may also be a vector of integers to be used as
  an index to select the desired subset.

  Argument \code{fvec} may be used to specify a method other than
  modulus for the normalising factor. \code{fvec} is a function with two
  arguments, the first being the eigenvector and the second the index
  vector.

  Argument \code{fchain} may be used to specify a completely different
  way to normailse the chain. \code{fchain} is a function with one
  argument, \code{chain}, which can do any transformation of the chain.

}
\value{
  a list as \code{ev} with the desired transformations done.
}
\author{Georgi N. Boshnakov}
\keyword{mcchain}
\keyword{internal}




