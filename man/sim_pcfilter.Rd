\name{sim_pcfilter}
\alias{sim_pcfilter}
\title{ Generate periodic filters }
\description{
  Generates periodic filters.
}
\usage{
sim_pcfilter(period, n.root, order = n.root, mo.col, \dots)
}
\arguments{
  \item{period}{ the period. }
  \item{n.root}{ number of non-zero roots (poles). }
  \item{order}{ order of the  filter. }
  \item{\dots}{
    additional parameters to be passed down to \code{sim_mc}.
  }
  \item{mo.col}{
    the last non-zero column in the top of the mc-matrix. The default is
    \code{dim}.
  }
}
\details{

  Generates periodic filters using the multicompanion approach
  \insertCite{boshnakov2009gen}{mcompanion}.

  By default the generated filter is stable and may be used as the
  autoregressive or moving average part of a periodic autoregressive
  moving average model. The filter is generated from the specified
  spectral information by factoring a multi-companion matrix. Any
  non-specified quantities are generated randomly. Randomly generated
  eigenvalues correspond to stable filter. The user may specify
  non-stable roots, unit roots in particular, see \code{sim_mc}.
}
\value{
  A list as obtained from \code{\link{sim_mc}} with an addtional
  component for the filter.

  \item{pcfilter}{ a matrix with the filter coefficients for the i-th
    season in the i-th row.}
}
\references{%
    % bibentry: boshnakov2002mc
Boshnakov GN (2002).
``Multi-companion matrices.''
\emph{Linear Algebra Appl.}, \bold{354}, pp. 53--83.
ISSN 0024-3795, \url{http://dx.doi.org/10.1016/S0024-3795(01)00475-X}.
% end:bibentry:  boshnakov2002mc

    % bibentry: boshnakov2009gen
Boshnakov GN and Iqelan BM (2009).
``Generation of time series models with given spectral
properties.''
\emph{J. Time Series Anal.}, \bold{30}(3), pp. 349--368.
ISSN 0143-9782, \url{http://dx.doi.org/10.1111/j.1467-9892.2009.00617.x}.
% end:bibentry:  boshnakov2009gen
}
\author{Georgi N. Boshnakov}
\note{

  todo: a) Allow different orders for the individual seasons. This is
  not  trivial and maybe not natural for this method. In the singular
  case it may make sense to implement different strategies for choosing
  the factorization (when it is not unique) and to choose more carefully
  the order of the filter to ensure existence of factorization, see my
  paper.
}
\seealso{ \code{\link{sim_mc}} }
\examples{
rfi <- sim_pcfilter(2,3)
mo <- cbind(c(1,1),rfi$pcfilter)
}
\keyword{ datagen }
\keyword{ ts }
