\name{sim_mcseeds}
\alias{sim_mcseeds}
\title{ Generate seed parameters of mc-matrices }
\description{

  Generates suitable seed parameters for an mc-matrix with partially
  specified spectral properties. Unspecified numeric values are
  simulated with sim_numbers().

}
\usage{
sim_mcseeds(mo = nrow(co), len.block, co, type, argarg = list(0, pi), ...)
}
\arguments{
  \item{mo}{ multi-companion order.}
  \item{len.block}{ lengths of the Jordan blocks.}
  \item{co}{ seed parameters. }
  \item{type}{ types of the eigenvectors, eg. "cp", see Details.}
  \item{argarg}{range for the complex argument.}
  \item{\dots}{ further arguments to be passed on to \code{sim_numbers}.}
}
\details{

  Generates seed parameters for a multi-companion matrix of
  multi-companion order \code{mo} and spectral and other parameters as
  specified by the arguments. See \code{sim_numbers} in package
  \code{"gbutils"} for addtional arguments for control of the
  distributions of the generated values.

  The number of the eigenvectors is inferred from the arguments. It is
  taken to be \code{sum(len.block)}, \code{ncol(co)} or
  \code{length(type)}, depending on which arguments are specified.

  \code{type} is a character vector specifying the types of the
  corresponding eigenvectors ("r" for real, "cp" for complex pairs).  If
  \code{type} is missing, all vectors are assumed complex of type
  \code{"cp"}.

  Note that each pair of complex conjugated vectors is represented by a
  single vector with arguments in the interval \code{(0, pi)}.

  Argument \code{co} can be used to specify some of the elements of the
  result. If \code{co} is given if should have the required dimension.

}
\value{
  a matrix with \code{mo} rows containing the coefficients.
}
\note{

  This function is OK when all eigenvalues are simple.
  Otherwise it should be called with suitably prepared argument
  \code{co}, which may be tricky.

  For proper parameterisation, see \code{spec_core} for the general case
  and \code{spec_root0} and \code{spec_root1}. The latter two functions
  handle the most important special cases of the spaces corresponding to
  zero and unit roots.

  TODO: The name of the function, \code{sim_mcseeds}, is misleading
        since it does not do anything specific to mc-matrices.
        (except the conventions for \code{"type"}, e.g. each complex
        pair is represented by one number)

}
\seealso{
  \code{\link{spec_core}}
}
\author{Georgi N. Boshnakov}
\keyword{distribution}
\keyword{internal}
