\name{mc_chain_subset}
\alias{mc_chain_subset}
\alias{mc_chain_merge}
\title{Internal utilities for mc eigenvectors}
\description{
  Utilities for manipulation of mc eigenchains:
  subset, merge.
}
\usage{
mc_chain_subset(ev, chainno)
mc_chain_merge(ev1, ev2)
}
\arguments{
  \item{ev}{eigensystem, a list, see details.}
  \item{ev1}{chain, a list.}
  \item{ev2}{chain, a list.}
  \item{chainno}{chains to extract, integer vector.}
}
\value{

  for \code{mc_chain_subset} and \code{mc_chain_merge}, a list having
  the same format as \code{ev1} and \code{ev2}

}
\details{

  The lists representing eigensystems (\code{ev}, \code{ev1},
  \code{ev2})  have the following structure:

  \tabular{ll}{
    \cr % patch: otherwise 'mo' turns up one character to the left of
        % the other entries in the first column. (BUG?)
    \code{mo} \tab  the multi-companion order,\cr
    \code{mo.col} \tab  the mc column order,\cr
    \code{eigval} \tab  a vector of eigenvalues containing one
                        entry for each chain,\cr
    \code{len.block} \tab  a vector of chain lengths, \code{len.block[i]}
                           is the length of the chain \cr
                     \tab  corresponding to \code{eigval[i]},\cr
    \code{eigvec} \tab  a matrix of generalised eigenvectors,\cr
    \code{co} \tab  the seed parameters (always bottom?), a matrix.
  }

  A chain with no elements is represented  by the empty list.

  If component \code{co} is non-NULL, it is processed as expected.  It
  may also be NULL or absent. In that case it will be NULL in the result
  returned by \code{mc_chain_subset}, similarly for \code{mc_chain_merge} but
  since it has two arguments, see the details below.

  \code{mc_chain_subset} takes a subsystem of \code{ev}, basically
  \code{ev$eigval[chaino]}, etc, but catering also for the possibility
  that some chains have length greater than one. \code{chainno} specifies
  which chains to take (or omit) with the usual \R index syntax.

  \code{mc_chain_merge} concatenates the two chains.  If \code{co} is
  NULL in both arguments, it is NULL in the result. Otherwise \code{co}
  is set to the bottom parts of the vectors. Components \code{mo} and
  \code{mo.col} in the two chains should be the same but currently this
  is not checked.

}
\seealso{
  \code{\link{mc_chain_extend}}
}
\author{Georgi N. Boshnakov}
\keyword{ mcchain }
\keyword{internal}

