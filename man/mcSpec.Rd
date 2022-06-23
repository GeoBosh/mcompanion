\name{mcSpec}
\alias{mcSpec}
\alias{initialize,mcSpec-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Generate objects of class mcSpec}
\description{Generate objects of class mcSpec.}
\usage{
mcSpec(\dots)

\S4method{initialize}{mcSpec}(.Object, dim, mo, root1 = numeric(0), iorder = 0,
           siorder = 0, order = rep(dim, mo), evtypes = NULL,
           mo.col = NULL, n.roots = mo.col, \dots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dim}{the dimension, a positive integer.}
  \item{mo}{multi-companion order, a.k.a. number of seasons.}
  \item{root1}{roots equal to one, a vector of positive integers of
    length at most \code{mo}.}
  \item{iorder}{integration order, a non-negative integer.}
  \item{siorder}{seasonal integration order, a non-negative integer.}
  \item{order}{order of the periodic filter, a vector of length
           \code{mo}.}
  \item{evtypes}{types of additional eigenvalues, see Details.}
  \item{mo.col}{number of non-zero columns in the top part of the
    multicompanion matrix, see Details.}
  \item{n.roots}{number of non-zero roots}
  \item{\dots}{further arguments to be passed on.}

   \item{.Object}{An object. This argument is not used in calls of
    \code{mcSpec} and \code{new}, see the details section.
  }

}
\details{

  \code{mcSpec(...)} and \code{new("mcSpec", ...)} create objects from
  class \code{mcSpec}. The two calls are equivalent and may contain any
  of the arguments of the initialize method described here, except
  \code{.Object} which is generated automatically.
  In both cases the initialize method is called and passed all the
  arguments.

  Several ways are provided for the specification of unit roots and they
  may be combined, as long as the specification is consistent.

  \code{roots1} specifies eigenvalues equal to 1 and the size of their
  Jordan chains. \code{iorder} and \code{siorder} provide convenient
  shortcuts for the special cases which they cover.

  \code{iorder} specifies the integration order. This corresponds to
  operator \eqn{(1-B)} applied \code{iorder} times.

  Similarly, \code{siorder} specifies the seasonal integration order,
  which corresponds to the operator \eqn{(1-B^s)} applied \code{siorder}
  times, where \eqn{s} is equal to \code{mo}. This argument generates
  \code{mo} unit roots, each of height (dimension of its Jordan chain)
  \code{siorder}.

  It is possible to use combinations of these arguments to specify the
  unit roots and all specifications are combined. Care must be taken not
  to exceed \code{dim}.


  If \code{mo.col} is missing, it is set to \code{max(order)}.
  \code{mo.col} may also be the character string "+ones". In this case
  the dimension of the unit roots is added to \code{max(order)}.
  \code{mo.col} may also be set directly by giving it an appropriate
  integer value. \strong{TODO: Need more checks for consistency here!}

  \strong{TODO:} describe other roots and eigenvectors!


  After all specified quantities are prepared, the rest are set to NA's.

  If not all eigenvalues are specified, additional eigenvalues are
  introduced to reach dimension \code{dim}. By default, if an even
  number of eigenvalues is needed, all of them are specified as complex
  pairs, "cp". If the number is odd, one real eigenvalue is specified
  and the rest are set again to "cp".

  Argument \code{evtypes} can be used to select a different setting for
  the additional eigenvalues.  It is a character vector in which "r"
  stands for real eigenavalues and "cp" stands for a complex pair. For
  example, if there are two "free" eigenvalues, the automatic choice
  would be a complex pair, "cp". If two real eigenvalues are desired set
  \code{evtypes} to \code{c("r","r")}.

  Note: \code{evtypes} is for types of additional eigenvalues. Do not
  specify types for eigenvalues equal to one or zero.
}
\value{
  an object of class \code{mcSpec}
}
\references{
  \insertRef{boshnakov2002mc}{mcompanion}

  \insertRef{boshnakov2009gen}{mcompanion}
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{mcSpec-class}}
}
\examples{
spec2 <- mcSpec(21, 4, siorder=2, iorder=1)
spec4 <- mcSpec(11, 4, siorder=1, iorder=1)
spec.co2 <- mcSpec(dim = 5, mo = 4, siorder = 1)
spec.co2new <- mcSpec(dim = 5, mo = 4, siorder = 1) # after correcting ev.arg
spec.co2alt <- mcSpec(dim = 6, mo = 4, siorder = 1)

spec.co3 <- mcSpec(dim = 5, mo = 4, root1 = c(1,1,1))

spec.coz1 <- mcSpec(dim = 4, mo = 4, root1 = c(1,1), order = rep(2,4)) # test0 roots
spec.coz2 <- mcSpec(dim = 5, mo = 4, root1 = c(1,1), order = rep(2,4)) # test0 roots
spec.coz3 <- mcSpec(dim = 4, mo = 4, root1 = c(1), order = rep(2,4)) # test0 roots
spec.co4 <- mcSpec(dim = 4, mo = 4, root1 = c(1,1,1))
}
\keyword{methods}
