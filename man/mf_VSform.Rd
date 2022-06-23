\name{mf_VSform}
\alias{mf_order}
\alias{mf_period}
\alias{mf_poles}
\alias{mf_VSform}

\title{ Extract properties of multi-filters }
\description{
  Extract properties for scalar and vector of seasons forms of multi-filters.
}
\usage{
mf_order(x, i = "max", form = "pc", perm)
mf_period(x)
mf_poles(x, blocks = FALSE)
mf_VSform(x, first = 1, form = "U", perm)
}
\arguments{
  \item{ x }{ the filter, an object of class  \code{"MultiFilter"}.}
  \item{ i }{ index, integer vector or a string. }
  \item{ first }{the first season of the year.}
  \item{ form }{
    the form of the filter to which the result refers,
    one of "pc", "I", "U", or "L", see Details.
  }
  \item{ perm }{permutation of the seasons within the year.}
  \item{ blocks }{ request lengths of Jordan chains.}
}
\value{
  For \code{mf_order},
  if \code{i = "max"} a positive integer,
  otherwise a vector  of positive integers.

  For \code{mf_period} the period of the filter, a positive integer.

  For \code{mf_poles},
  if \code{blocks = FALSE}, a vector of the eigenvalues of the associated
  multi-companion matrix, each eigenvalue repeated according to its
  algebraic multiplicity.
  If \code{blocks = TRUE}, a 2-column matrix with the eigenvalues in the
  first column and the lengths of the  Jordan chains in the second.
  There is one row  for each  chain (i.e. multiple eigenvalues are
  repeated according to their geometric multiplicity).

  For \code{mf_VSform} a list with components:
  \item{Phi0}{the zero lag coefficient, a matrix,}
  \item{Phi}{the remaining coefficients, a matrix,}
  \item{Phi0inv}{
    (\code{form=="I"} only) the inverse of the zero lag coefficient
    matrix of the vs-form, a matrix. (\strong{TODO:} the name of this
    component is misleading since in the case \code{form = "I"} Phi0 is
    the identity matrix and \code{Phi0inv} is not equal to the inverse
    of Phi0.)
  }
}
\details{

  With the default \code{i=="max"} the function \code{mf_order} returns
  a single number, the order of the filter in the representation
  requested by \code{form}.
  The orders of the components may be obtained with the setting
  \code{i=="all"} which gives a vector whose j-th element is the order
  of the j-th component of the filter. A subset of these may be obtained
  with numeric \code{i} which is treated as standard index vector.
  Values for \code{i} other than the default are meaningful mainly for
  \code{form="pc"}.

  \code{mf_VSform} arranges the filter coefficients in one of the vector
  of seasons forms (todo: cite me). The component \code{Phi} of the
  result is a matrix obtained by putting the coefficient matrices next
  to each other, [A1 ... Ad].  If \code{perm} is provided, then the
  result is the same for "U" and "L".

  \code{mf_VSform} is called implicitly by the subscripting operation
  ("[") when needed, it is more flexible and is recommended for general
  use.

  For the vector forms ("I", "U", and "L") the argument \code{perm}
  specifies the arrangement of the components of the filter in that
  form. For the I- and U-forms the default is \code{mf_period(x):1}, for
  the L-form it is \code{1:mf_period(x)}.

  Currently \code{perm} may take on
  values that can  be obtained from the default by rotation, e.g. if the
  period is 4,  \code{perm} may be one of
  (4,3,2,1), (1,4,3,2), (2,1,4,3), (3,2,1,4) for the U-form,
  and
  (1,2,3,4), (4,1,2,3), (3,4,1,2), (2,3,4,1) for the L-form.
  Other permutations may be usefull in some situations but may not
  result in U- or L- forms (without further transformations).
  For I-form any permutation should be permissible when implemented
  (todo:).

  For \code{mf_order} the argument \code{perm} affects the computation
  only, not the ordering in the result.  The result (if vector) is not
  permuted unless the argument \code{i} asks for this.
  For \code{mf_VSform} however such a behaviour would be very peculiar
  and the rows of the result are for the permuted seasons.
  In short, the i-th element of the result of \code{mf_order} (if
  vector) gives the order (in the requested form) of the i-th season
  but the i-th row of any of the matrices returned by  \code{mf_VSform}
  depends on \code{perm} and \code{form}.

  Note: the terminology here reflects application to pc processes,
  probably should be made more neutral in this respect.

  todo: (2013-03-26) \code{mf_order} seems unfinished.
}
\author{Georgi N. Boshnakov}
\references{%
  \insertRef{boshnakov2002mc}{mcompanion}
  
  \insertRef{boshnakov2009gen}{mcompanion}
}

\seealso{
  \code{\linkS4class{MultiFilter}} and the examples there,
  \code{\link{mcStable}}
}
\examples{
## simulate a 3x3 2-companion matrix
##  and turn it into a multi-filter
(m <- mCompanion("sim", dim=3, mo=2))
(flt <- new("MultiFilter", mc = m ))
mf_period(flt)
mf_poles(flt)
abs(mf_poles(flt))
mf_VSform(flt,form="U")
mf_VSform(flt,form="L")
mf_VSform(flt,form="I")

## simulate a pc filter (2 seasons)
## and turn it into a multi-filter object
(rfi <- sim_pcfilter(2, 3))
(flt <- new("MultiFilter", coef = rfi$pcfilter))
mf_period(flt)
mf_poles(flt)
abs(mf_poles(flt))
mf_VSform(flt, form="U")
mf_VSform(flt, form="I")
mf_VSform(flt, form="L")

## indexing can be used  to extract filter coefficients
flt[]
flt[1,]
## the rest are some checks of numerical performance.
rfi
rfi$mat==0

zapsmall(rfi$mat)
mCompanion(zapsmall(rfi$mat))
unclass(mCompanion(zapsmall(rfi$mat)))
unclass(mCompanion(rfi$mat))

flt1 <- new("MultiFilter", mc = mCompanion(zapsmall(rfi$mat)))
flt2 <- flt

flt1[]
flt2[]
flt1[] - flt2[]
rfi$pcfilter - rfi$mat[1:2,]

mf_poles(flt1)
abs(mf_poles(flt1))

svd(rfi$mat)
rcond(rfi$mat)
Matrix::rcond(Matrix::Matrix(rfi$mat),"O")
1/Matrix::rcond(Matrix::Matrix(rfi$mat),"O")
}
\keyword{ ts }
