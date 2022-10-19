\name{mCompanion}
\alias{mCompanion}
\alias{initialize,MultiCompanion-method}
\title{ Create objects from class MultiCompanion }
\description{
  Create, generate, or simulate objects from class \code{"MultiCompanion"} by
  specifying the matrix in several ways.
}
\usage{
mCompanion(x, detect = "nothing", misc = list(), \dots)

\S4method{initialize}{MultiCompanion}(.Object, xtop, mo, n, mo.col, ido, x, dimnames,
           detect = "nothing", misc = list())
}
\arguments{
  \item{x}{
    the matrix or, for \code{mCompanion} only, the top of the
    matrix or a character string, see section \sQuote{Details}.
  }
  \item{misc}{
    information to be stored in the object's pad.
  }
  \item{\dots}{
    other arguments to be passed down to generator functions, see
    section \sQuote{Details}.
  }
  \item{xtop}{ the top of the matrix. }
  \item{mo}{ the multi-companion order of the matrix. }
  \item{n}{ the dimension. }
  \item{mo.col}{
    the top order, meaniing that columns mo.col+1,...,n of the top of
    the matrix are zeros. \code{mo.col} may also be set to "detect", in
    which case it is determined by scanning \code{xtop} or \code{x}.
  }
  \item{ido}{ the dimension of the identity sub-matrix. }
  \item{dimnames}{ is not used currently. }
  \item{detect}{
    controls whether automatic detection of \code{mo} and \code{mo.col}
    should be attempted. The values tested are "mo", "mo.col", "all",
    and "nothing" with obvious meanings.
  }
  \item{.Object}{this is set implicitly by package "methods". }
}
\details{

  Objects from class \code{"MultiCompanion"} can be created by calling
  \code{mCompanion()} or \code{new("MultiCompanion", ...)}. In the
  latter case the \dQuote{\dots} arguments are as for the
  \code{initialize} method, except \code{.Object}. Do not call
  \code{initialize} directly.

  \code{mCompanion} can generate multi-companion matrices from spectral
  information, full or partial, using the methodology developed by
  \insertCite{boshnakov2009gen;textual}{mcompanion}. If the
  specification is not given in full, the missing information is filled
  with suitably simulated values. For example, unspecifies eigenvalues
  are generated inside the unit circle, \code{\link{sim_mc}}.

  If argument \code{x} is the string "sim" or "gen", then
  \code{mCompanion} calls \code{\link{sim_mc}} or
  \code{\link{make_mcmatrix}}, respectively, with the arguments
  \code{...} and converts the result to class MultiCompanion.  See the
  documentation of those functions for further details and examples.
  The conversion may be the main reason to use \code{mCompanion} in this
  way rather than call \code{sim_mc} and \code{make_mcmatrix} directly.

  Otherwise, if \code{x} is numeric it is taken to specify the top of
  the matrix unless \code{detect="mo"} in which case it is the whole
  matrix.  In both cases all arguments are passed down to \code{new}, the
  only (more or less) change being that \code{x} is passed down as
  \code{xtop=x} and \code{x=x}, respectively, see
  \code{\linkS4class{MultiCompanion}}.
  % \code{initialize,MultiCompanion-method}.

  \code{detect=="gen"} signifies that \code{x} has the format of the
  output from \code{sim_mc} or \code{make_mcmatrix}, so that \code{mCompanion}
  may use the additional information in such objects.

  The multi-companion order is determined automatically from the content
  of the matrix if \code{detect=="mo"}.
}
\value{
  a multi-companion matrix, an object of class \code{"MultiCompanion"}
}
\references{%
  \insertRef{boshnakov2002mc}{mcompanion}
  
  \insertRef{boshnakov2007svd}{mcompanion}

  \insertRef{boshnakov2009gen}{mcompanion}
}
\author{Georgi N. Boshnakov}
%\note{}
\seealso{
    \code{\link{sim_mc}},
    \code{\link{make_mcmatrix}},
    \code{\linkS4class{MultiCompanion}}
}
\examples{
# simulate a 6x6 mc matrix with 2 non-trivial rows
mCompanion("sim", dim = 4, mo = 2)
# simulate a 6x6 mc matrix with 4 non-trivial rows
mCompanion("sim", dim = 6, mo = 4)
# similar to above but top rows with 2 non-zero columns
mCompanion("sim", dim = 6, mo = 4, mo.col = 2)

## specify the non-trivial top rows (as a matrix):
m1 <- matrix(1:24, nrow = 4)
mCompanion(m1)            # mc matrix with m1 on top

m2 <- rbind(c(1, 2, 0, 0), c(3, 4, 0, 0))
x2a <- mCompanion(m2)     # mc matrix with m2 on top
x2a@mo.col                #  = 4

x2 <- mCompanion(m2, mo.col = "detect")
x2@mo.col                #  = 2,  detects the 0 columns in m2
mCompanion(m2, mo.col = 2)  # same

# create manually an mc matrix
(m3 <- rbind(m1, c(1, rep(0, 5)), c(0, 1, rep(0, 4))))
# turn it into a MultiCompanion object
x3 <- mCompanion(x = m3, detect = "mo")
x3@mo
x3 <- mCompanion(m3)
x3@mo

m4 <- rbind(c(1, 2, rep(0, 4)), c(3, 4, rep(0, 4)))

x4 <- mCompanion(m4, mo = 2)
x4@mo.col    #  = 6,
## special structure not incorporated in x4,
##   eigen and mc_eigen are equiv. in this case
eigen(x4)
mc_eigen(x4)

x4a <- mCompanion(m4, mo = 2, mo.col = 2)
x4a@mo.col    #  = 2,  has Jordan blocks of size > 1
## the eigenvectors do not span the space:
eigen(x4a)
## mc_eigen exploits the Jordan structure, e.g.2x2 Jordan blocks,
## and gives the generalised eigenvectors:
(ev <- mc_eigen(x4a))

x4a \%*\% ev$vectors

## construct the Jordan matrix of x4a from eigenvalues and eigenvectors
(x4a.j <- Jordan_matrix(ev$values,  ev$len.block))

## check that AX = XJ and A = XJX^-1, up to numerical precision:
x4a \%*\% ev$vectors  -  ev$vectors \%*\% x4a.j
x4a  -  ev$vectors \%*\% x4a.j \%*\% solve(ev$vectors)
}
\keyword{matrices}
