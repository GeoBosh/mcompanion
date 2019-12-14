\name{make_mcmatrix}
\alias{make_mcmatrix}
\alias{make_mcchains}
\title{ Generate a multi-companion matrix from spectral description}
\description{
  Generate a multi-companion matrix or its Jordan decomposition from
  spectral parameters.
}
\usage{
make_mcmatrix(type = "real", what.res = "matrix", \dots, eigval0)

make_mcchains(eigval, co, dim, len.block, eigval0 = FALSE,
              mo.col = NULL, what.co = "bottom", \dots)
}
\arguments{
  \item{eigval}{ the eigenvalues, a numeric vector }
  \item{co}{ the seeding parameters for the eigenvectors, a matrix}
  \item{dim}{ the dimension of the matrix, a positive integer }
  \item{len.block}{ lengths of Jordan chains,
    \code{len.block[i]} is for \code{eigval[i]} }
  % \item{what.co}{ how to interpret the elements of \code{co}, see details }
  \item{type}{ mode of the matrix, real or complex }
  \item{what.res}{ format of the result, see details }
  \item{eigval0}{ If TRUE completes the matrix to a square matrix, see
    details}
  \item{\dots}{ additional arguments to be passed down, see details }
  \item{mo.col}{~~ TODO: describe this argument. ~~}
  \item{what.co}{~~ TODO: describe this argument. ~~}
}
\details{
  The spectral parameters are used to generate the (generalised)
  eigenvectors and the corresponding Jordan matrix which are then
  multiplied to get the matrix. By default, the real part is returned
  which is appropriate if all complex spectral parameters come in
  complex conjugate pairs. This may be changed by the argument
  \code{type}. A list containing the matrix and the Jordan factors is
  returned if \code{what.res = "list"}.

  The closely related function \code{sim_mc} does the same but completes
  any missing information (eigenvalues, co) with randomly generated
  entries. The result of both functions is a list or ordinary matrix,
  use \code{mCompanion} to obtain a \code{MultiCompanion} object
  directly.

  \code{make_mcchains} constructs the eigensystem, \code{make_mcmatrix}
  calls \code{make_mcchains} (passing the \code{...} arguments to it)
  and forms the matrix. \code{make_mcchains} passes the \code{...}
  arguments to \code{mc_0chains}.
  % \code{make_mcev} and \code{make_mcgev}. Currently (July 2007) the
  % only one (of the '...' arguments?) of importance to the user is
  % \code{what.co}.


  \code{make_mcchains} creates the full eigenvectors from the \code{co}
  parameters. If the number of vectors is smaller then \code{dim} and
  \code{eigval0} is TRUE  it then completes the system with chains for
  the zero eigenvalue. More specifically, it assumes that the number of
  the given chains is \code{mo.col},  takes chains corresponding
  to the zero eigenvalue, if any, and adds additional eigenvectors
  and/or generalised eigenvectors to construct the complete system.

  \strong{TODO:} cover the case \code{mo < mo.col}?

}
\value{
  \code{make_mcmatrix} normally returns the multi-companion matrix (as an
  ordinary matrix) having the given spectral properties but if
  \code{what.res=="list"}, it returns a list containing the matrix and
  the spectral information:

  \item{eigval}{eigenvalues, a vector}
  \item{len.block}{lengths of Jordan chains, a vector}
  \item{mo}{multi-companion order, positive integer}
  \item{eigvec}{generalied eigenvectors, a matrix}
  \item{co}{seeding parameters}
  \item{mo.col}{top order}
  \item{mat}{the multi-companion matrix, a matrix}

  \code{make_mcchains} returns a similar list without the component
  \code{mat}.
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
\note{The result is an ordinary matrix. Also, some entries that should
  be 0 may be non-zero due to numerical error.

  To get a MultiCompanion object use \code{\link{mCompanion}}.
}
\seealso{
  \code{\link{make_mcev}},
  \code{\link{make_mcgev}},
  \code{\link{sim_mc}},
  \code{\link{mCompanion}}
}
\examples{
make_mcchains(c(1), co = cbind(c(1,1,1,1), c(1,2,1,1)), dim = 4,
              len.block = c(2), eigval0 = TRUE)

make_mcmatrix(eigval = c(1), co = cbind(c(1,1,1,1), c(1,2,1,1)), dim = 4,
              len.block = c(2))
make_mcmatrix(eigval = c(1), co = cbind(c(1,1,1,1), c(1,2,3,4)), dim = 4,
              len.block = c(2))
}
\keyword{matrices}


