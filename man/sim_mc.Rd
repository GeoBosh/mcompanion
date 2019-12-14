\name{sim_mc}
\alias{sim_mc}
\title{ Simulate a multi-companion matrix }
\description{
  Simulate a multi-companion matrix with partially or  fully specified spectral
  properties.
}
\usage{
sim_mc(dim, mo, mo.col = dim, eigval, len.block, type.eigval = NULL,
       co, eigabs, eigsign, type = "real",
       value = "real", value.type = "", ...)
}
\arguments{
  \item{dim}{ dimension of the matrix }
  \item{mo}{ multi-companion order }
  \item{mo.col}{ number of structural columns }
  \item{eigval}{ eigenvalues }
  \item{len.block}{ lengths of Jordan blocks }
  \item{type.eigval}{ types of the eigenvalues, a character vector }
  \item{co}{ \code{co} parameters, see Details.}
  \item{eigabs}{ moduli (absolute values) of eigenvalues, see Details.}
  \item{eigsign}{signs or complex arguments of eigenvalues, see Details.}
  \item{type}{ passed down to generators (???) }
  \item{value}{ what to return }
  \item{value.type}{  type of the value (???)}
  \item{\dots}{
    further arguments to passed on to \code{sim_mcseeds} and
    \code{sim_numbers}, see Details.
  }
}
\details{

  \code{sim_mc} generates a multi-companion matrix of dimension
  \code{dim x dim} and multi-companion order \code{mo}. The matrix has
  the spectral properties specified by the arguments. Values that cannot
  be inferred from the arguments are simulated.

  Arguments \code{dim}, \code{mo}, and \code{mo.col} define the
  structure of the matrix. The first two are compulsory but the last
  one, \code{mo.col}, is optional. If no other arguments are supplied
  \code{sim_mc} produces a matrix with all spectral parameters
  simulated.

  The number of non-zero eigenvalues is at most \code{mo.col}.
  If \code{mo.col < dim} the multi-companion matrix has structural
  eigenvectors/chains corresponding to the zero eigenvalue(s), see
  the references. These chains are generated automatically.

  Arguments \code{type.eigval}, \code{eigabs}, \code{eigsign} and
  \code{eigval} are vectors used to specify the types and the values of
  the eigenvalues. Any or all of them may be missing or NULL. Those
  present must have the same length.

  It is not necessary to specify eigenvalues and eigenvectors
  corresponding to eigenvalues equal to zero, since the structural
  eigenchains needed when \code{mo.col < dim} are created automatically.
  In practice, the number of the non-zero eigenvalues is usually equal
  to \code{mo.col}.  The net effect is that the arguments specifying the
  spectral structure of the matrix normally need to specify the spectral
  information about the non-zero \code{eigval} only.

  Some or all of the eigenvalues may be specified partially or fully
  using arguments \code{eigabs}, \code{eigsign}, and
  \code{eigval}. Non-NA entries in \code{eigval} specify complete
  eigenvalues. Non-NA entries in \code{eigabs} specify absolute values
  of eigenvalues. Non-NA entries in \code{eigsign} specify signs of real
  eigenvalues or complex arguments of complex eigenvalues. Generally, if
  the entry for an eigenvalue in \code{eigval} is a number (not
  \code{NA}), then the corresponding entries in \code{eigabs} and
  \code{eigsign} will be \code{NA}. This is not enforced and a limited
  check for consistency is made in case of redundant information.

  \code{type.eigval} is a character vector describing the types of the
  eigenvalues, where "r", "c", and "cp" stand for real, complex, and
  complex pair, respectively. It is best to have one entry only for each
  complex pair (specified by "cp"), rather than two "c" entries.

  If \code{type.eigval} is NULL (default) and \code{eigval} is supplied,
  then \code{type.eigval} is inferred from the imaginary part of
  \code{eigval} ("r" or "cp"), if it is complex.

  For compatibility with older versions of this function \code{eigval}
  may be a character vector in which case it is simply assigned to
  \code{type.eigval}.

  If both, \code{type.eigval} and \code{eigval}, are missing a default
  allocation of the types of the eigenvalues is chosen.


  \strong{TODO: complete the description below.}

  The remaining spectral parameters may be specified with the argument
  \code{co} with missing entries for the "free" entries. (!!! This is not
  complete, it may be better to have separate arguments for the absolute
  value and the angle, as for eigenvalues, and an option for
  normalisation of these coefficients. ???)

  Generators other than the default ones may be specified in the
  \code{...}  argument. These are passed to \code{sim_numbers} and
  \code{sim_mcseeds}.  Again, for the "co" arguments the support
  is not finished.

}
\value{
  if \code{value.type} is the character string \code{"matrix"}, the
  required multi-companion matrix. Otherwise, if
  \code{value.type=="list"}, a list containing also the spectral
  information (this list is the same as the one from
  \code{\link{make_mcmatrix}})).
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
  A canonical form is needed, especially when there are repeated
  eigenvalues whose eigenvectors may be chosen to be orthogonal, at
  least. (nyakade v zapiskite mi tryabva da ima kanonichna forma!)
}
\seealso{

  \code{gbutils::sim_numbers} and
  \code{\link{sim_mcseeds}} for arguments that control the distributions of
  the random numbers.

  \code{\link{make_mcmatrix}} creates the matrix.

}
\examples{
m0 <- sim_mc(3,2)   # simulate 3x3 2-companion matrix
abs(m0$eigval)      # eigval random, so their abs values

# now fix moduli of eigenvalues, and
# ask for one real ev and one complex pair of ev's
m1 <- sim_mc(3,2,eigabs=c(0.25,0.5), type.eigval=c("r","cp"))
m1$eigval
abs(m1$eigval)

# same as above, since type.eigval happens to be the default
# dim is odd, by default first ev is real, rest are complex pairs
m1a <- sim_mc(3,2,eigabs=c(0.25,0.5))
m1a$eigval
abs(m1a$eigval)

# simulate 6x6 4-companion matrix
# with ev's at the seasonal frequencies (1.57 3.141593 -1.57)
# and random moduli. 3 complex pairs of ev's
m2 <- sim_mc(6,4, eigsign = pi*c(1/2,1,-1/2) )
Arg(m2$eigval)
}
\keyword{ datagen }