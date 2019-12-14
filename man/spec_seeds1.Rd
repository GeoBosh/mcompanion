\name{spec_seeds1}
\alias{spec_seeds1}
\title{
  Generate seed parameters for unit mc-eigenvectors
}
\description{
  Generates seed parameters for mc-eigenvectors corresponding to unit
  roots.
}
\usage{
spec_seeds1(len.block, mo)
}
\arguments{
  \item{len.block}{
    lengths of Jordan blocks, a vector of positive integers.
  }
  \item{mo}{multi-companion order.}
}
\details{

  Creates a matrix of seed parameters corresponding to unit eigenvalues
  of a multi-companion matrix of multi-companion order \code{mo}.
  \code{len.block} gives the sizes of the Jordan blocks corresponding to
  eigenvalues equal to one.

  In general, the entries are filled with NA's but for some
  configurations some (or even all) of the entries are uniquely
  determined up to a linear transformation. In such cases a
  ``canonical'' choice is made.

  The generated seed parameters can be considered to be \code{"top"} or
  \code{"bottom"}, as needed. (\strong{TODO:} check this claim, I have
  forgotten the details but think that this is the reason that it is not
  necessary to have an argument for the dimension of the matrix).

  code{spec_seeds1} can be used by model fitting functions to prepare
  parameters for estimation but see \code{\link{spec_root1}} and
  \code{\link{mcSpec}} for a more comprehensive treatment.

}
\value{
  a matrix with \code{mo} rows and \code{sum(len.block)} columns
}
\author{Georgi N. Boshnakov}
\note{
  TODO: the treatment of ``canonical'' cases is incomplete, see also the
  comments in the source code of the function.

  TODO: explain the \code{Inf} and \code{-Inf} output entries for some
  configurations (e.g. the last example below).

  "co" in the name of \code{spec_seeds1} is short for coefficient.

}
\seealso{
  \code{\link{spec_root1}},
  \code{\link{mcSpec}}
}
\examples{
spec_seeds1(c(1), mo = 4)       # NA's
spec_seeds1(c(1,1), mo = 4)     # NA's
spec_seeds1(c(1,1,1), mo = 4)   # NA's (but for parameterisation
                            #     a different approach is used)
spec_seeds1(c(1,1,1,1), mo = 4) # identity matrix but other bases are good too
spec_seeds1(c(2,2,2,2), mo = 4) # no NA's, tops of gen.evecs can be chosen 0
spec_seeds1(c(2,1,1,1), mo = 4) # (can be improved)
spec_seeds1(c(2,1), mo = 4)     # NA's
}
\keyword{mcspec}
