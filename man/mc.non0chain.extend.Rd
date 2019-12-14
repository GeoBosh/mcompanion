\name{mC.non0chain.extend}
\alias{mC.non0chain.extend}
\title{ Extend multi-companion eigenvectors(non0) }
\description{
  Extend eigenchains corresponding to non-zero eigenvalues
  of a multi-companion matrix to higher dimension.
}
\usage{
mC.non0chain.extend(ev, newdim)
}
\arguments{
  \item{ev}{ eigenvalues and eigenvectors, a list with components ???
    (as in \code{mc_chain_subset}, etc)  }
  \item{newdim}{ the new dimension of the vectors}
}
\details{
  The eigenvectors of a multi-companion  matrix have a special
  structure. This function extends the supplied eigenvectors to be
  eigenvectors of a higher-dimensional multi-companion matrix of the
  same multi-companion order with the same top rows extended with zeroes.

  The function handles also the case when only the first \code{mo.col}
  columns of the top of the original multi-companion matrix are
  non-zero. This may be specified by a component \code{mo.col} in
  \code{ev} (otherwise \code{mo.col} is set to the number of
  eigenvalues).

  A component \code{len.block} of \code{ev} may be used to specify
  lengths of the Jordan chains, the default is 1.

  When \code{mo.col} is smaller than the multi-companion order, the
  information in the eigenvectors is not sufficient to extend them. The
  missing entries must  be supplied via the argument \code{x0}.
}
\value{
  The eigenvectors extended to the new dimension.
}
\author{Georgi N. Boshnakov}
\note{
This is mostly internal function. The user function is \code{mc_chain_extend}.}
\seealso{ \code{\link{mc_chain_extend}}}
\keyword{mcchain}
\keyword{internal}
