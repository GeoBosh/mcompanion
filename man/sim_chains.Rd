\name{sim_chains}
\alias{sim_chains}
\title{Simulate Jordan chains}
\description{Simulate Jordan chains.}
\usage{
sim_chains(dim = nrow(vectors), type = NULL, heights = NULL,
           vectors = NULL, argarg = list(0, pi), ...)
}
\arguments{
  \item{dim}{dimension of the matrix, a positive integer.}
  \item{type}{
    types of the eigenvalues, a character vector containing
    \code{"r"} and \code{"cp"}.
  }
  \item{heights}{
    heights of the eigenvalues, a vector of positive integers.
  }
  \item{vectors}{a matrix containing chains.}
  \item{argarg}{TODO: describe.}
  \item{\dots}{
    additional arguments to be passed on to \code{sim_numbers}.
  }
}
\details{

  \code{sim_chains} prepares the arguments and calls \code{sim_numbers}
  to fill the NA entries in \code{vectors} with simulated values.
}
\value{
  a matrix
}
\author{Georgi N, Boshnakov}
\keyword{internal}
