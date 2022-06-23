\name{mc_chain_extend}
\alias{mc_chain_extend}
\title{ Extend multi-companion eigenvectors }
\description{
  Extend Jordan chains of a multi-companion matrix to higher dimension
  and complete them to a full system by adding eigenchains for zero
  eigenvalues.
}
\usage{
mc_chain_extend(ev, newdim)
}
\arguments{
  \item{ev}{
    eigenvalues and eigenvectors, a list with components \code{values}
    and \code{vectors}.
  }
  \item{newdim}{ the new dimension of the vectors. }
}
\details{

  The eigenvectors of a multi-companion  matrix have a special
  structure. This function extends the supplied eigenvectors to be
  eigenvectors of a higher-dimensional multi-companion matrix of the
  same multi-companion order with the same top rows extended with zeroes.

  \code{ev} is a list with components \code{values}, \code{vectors} and
  possibly others. In particular, \code{ev} may be the value returned by
  a call to the base function \code{eigen()}.  A component
  \code{len.block} may be used to specify the lengths of the Jordan
  chains, by default all are of length one.

  The function handles also the case when only the first \code{mo.col}
  columns of the top of the original multi-companion matrix are
  non-zero. This may be specified by a component \code{mo.col} in
  \code{ev}, otherwise \code{mo.col} is set to the dimension of the
  space spanned by the non-zero eigenvalues.

  When \code{mo.col} is smaller than the multi-companion order, the
  information in the eigenvectors is not sufficient to extend them. The
  missing entries are supplied via the argument \code{F0bot}
  (\strong{TODO: describe!}).

  Chains corresponding to zero eigenvalues come last in the result.
}
\value{
  The eigenvectors extended to the new dimension.
}
\references{%
  \insertRef{boshnakov2002mc}{mcompanion}
  
  \insertRef{boshnakov2009gen}{mcompanion}
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{mc_eigen}};

  the main work is done by \code{\link{mC.non0chain.extend}} and
  \code{\link{mc_0chains}}.
}
\examples{
ev <- make_mcchains(eigval = c(1, 0.5), co = cbind(c(1,1), c(1, -1)), dim = 4,
              mo.col = 2,
              len.block = c(1, 1))
ev
## extend evecs in ev to the requested dim and complete with chains for eval 0.
mc_chain_extend(ev = ev, newdim = 6)
mc_chain_extend(ev = ev, newdim = 7)
}
\keyword{matrices}
