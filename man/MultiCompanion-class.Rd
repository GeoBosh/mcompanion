\name{MultiCompanion-class}
\docType{class}
\alias{MultiCompanion-class}
\alias{\%*\%,MultiCompanion,ANY-method}
\alias{\%*\%,ANY,MultiCompanion-method}
\alias{\%*\%,MultiCompanion,vector-method}
\alias{\%*\%,vector,MultiCompanion-method}
\alias{\%*\%,MultiCompanion,MultiCompanion-method}
\alias{\%*\%,MultiCompanion,matrix-method}
\alias{\%*\%,matrix,MultiCompanion-method}
\alias{[,MultiCompanion,index,missing,logical-method}
\alias{[,MultiCompanion,index,index,logical-method}
\alias{[,MultiCompanion,missing,index,logical-method}
\alias{coerce,dgeMatrix,MultiCompanion-method}
\alias{coerce,matrix,MultiCompanion-method}
\alias{coerce,MultiCompanion,matrix-method}
\alias{coerce,MultiCompanion,Matrix-method}
\alias{coerce,MultiCompanion,dgeMatrix-method}
\alias{mcStable,MultiCompanion-method}
\alias{t,MultiCompanion-method}

\alias{[,MultiCompanion,index,index,missing-method}
\alias{[,MultiCompanion,index,missing,missing-method}
\alias{[,MultiCompanion,missing,index,missing-method}

\title{Class "MultiCompanion"}
\description{Objects and methods for multi-companion matrices}
\section{Objects from the Class}{
  For ordinary usage objects from this class should behave as matrices
  and there should be no need to access the slots directly.

  Objects can be created with the function \code{\link{mCompanion}}.
  Other functions in the mcompanion package also produce
  \code{MultiCompanion} objects.

  It is possible also to call \code{new()} directly:
  \preformatted{
    new("MultiCompanion", xtop, mo, n, mo.col, ido, x, dimnames,
        detect, misc)
  }

  Arguments:

  \describe{

    \item{\code{xtop}}{ is the top of the matrix. }

    \item{\code{mo}}{ is the multi-companion order of the matrix. }

    \item{\code{n}}{ is the dimension. }

    \item{\code{mo.col}}{ is the top order, meaniing that columns
      mo.col+1,...,n of the top of the matrix are zeros. \code{mo.col}
      may also be set to "detect", in which case it is determined by
      scanning \code{xtop} or \code{x}. }

    \item{\code{ido}}{ the dimension of the identity sub-matrix. }

    \item{\code{x}}{ the whole matrix. }

    \item{\code{dimnames}}{ is not used currently. }

    \item{\code{detect}}{ controls whether automatic detection of
      \code{mo} and \code{mo.col} should be attempted. The values tested
      are "mo", "mo.col", "all", and "nothing" with obvious meanings. }

    \item{\code{misc}}{ todo: describe this argument! }
  }

  Normally one of \code{xtop} and \code{x} is supplied but if both are,
  they are checked for consistency, including the elements of the matrix
  (equality is tested with \code{==}).  To facilitate calls with one
  unnamed argument, when \code{xtop} is a square matrix it is taken
  to be the entire matrix (provided that \code{x} is missing).

  Aside from \code{xtop} (or \code{x}), most of the remaining arguments
  can be deduced automatically.  The number of rows and columns of
  \code{xtop} give the multi-companion order and the dimension of the
  matrix, respectively. A vector \code{xtop} is taken to stand for a
  matrix with one row. \code{x} needs to be square or a vector of length
  equal to exact square. \code{mo} and \code{mo.col} may be determined
  from the contents of \code{x} and \code{xtop}. There is no harm in
  ignoring \code{mo.col} but it is useful for our applications. Note
  that by default it is to set to the number of columns and not
  determined by scanning the matrix.

  The contents of the  \code{misc} argument are  stored in the pad of
  the new object.
}
\section{Slots}{
	 \describe{
    \item{\code{xtop}:}{The top of the matrix, an object of class \code{"matrix"} }
    \item{\code{mo}:}{Multi-companion order, an object of class \code{"numeric"} }
    \item{\code{ido}:}{dimension of the identity submatrix, object of class \code{"numeric"}}
    \item{\code{mo.col}:}{number of non-zero columns in top rows, object of class \code{"numeric"}}
    \item{\code{pad}:}{storage for additional info, object of class \code{"objectPad"} }
    \item{\code{x}:}{inherited, object of class \code{"numeric"} }
    \item{\code{Dim}:}{inherited, object of class \code{"integer"} }
    \item{\code{Dimnames}:}{inherited, object of class \code{"list"} }
    \item{\code{factors}:}{inherited, object of class \code{"list"} }
  }
}
\section{Extends}{
Class \code{"ddenseMatrix"}, directly.
Class \code{"generalMatrix"}, directly.
Class \code{"dMatrix"}, by class \code{"ddenseMatrix"}.
Class \code{"denseMatrix"}, by class \code{"ddenseMatrix"}.
Class \code{"Matrix"}, by class \code{"ddenseMatrix"}.
Class \code{"Matrix"}, by class \code{"ddenseMatrix"}.
Class \code{"compMatrix"}, by class \code{"generalMatrix"}.
Class \code{"Matrix"}, by class \code{"generalMatrix"}.
}
\section{Methods}{
  \describe{
    \item{\%*\%}{\code{signature(x = "ANY", y = "MultiCompanion")}: ... }
    \item{\%*\%}{\code{signature(x = "MultiCompanion", y = "MultiCompanion")}: ... }
    \item{\%*\%}{\code{signature(x = "MultiCompanion", y = "ANY")}: ... }
    \item{[}{\code{signature(x = "MultiCompanion", i = "index", j = "index",
        drop = "logical")}: ... }
    \item{[}{\code{signature(x = "MultiCompanion", i = "index", j = "missing", drop = "logical")}: ... }
    \item{[}{\code{signature(x = "MultiCompanion", i = "missing", j =
        "index", drop = "logical")}: ... }
    \item{coerce}{\code{signature(from = "dgeMatrix", to = "MultiCompanion")}: ... }
    \item{coerce}{\code{signature(from = "matrix", to = "MultiCompanion")}: ... }
    \item{coerce}{\code{signature(from = "MultiCompanion", to = "matrix")}: ... }
    \item{coerce}{\code{signature(from = "MultiCompanion", to = "dgeMatrix")}: ... }
    \item{initialize}{\code{signature(.Object = "MultiCompanion")}:
      This method is called implicitly when the user calls
      \code{new("MultiCompanion",...)}.
    }
    \item{mcStable}{\code{signature(x = "MultiCompanion")}: ... }
    \item{t}{\code{signature(x = "MultiCompanion")}: ... }


    \item{\%*\%}{\code{signature(x = "matrix", y = "MultiCompanion")}: ... }
    \item{\%*\%}{\code{signature(x = "MultiCompanion", y = "matrix")}: ... }
    \item{[}{\code{signature(x = "MultiCompanion", i = "index", j = "index", drop = "missing")}: ... }
    \item{[}{\code{signature(x = "MultiCompanion", i = "index", j = "missing", drop = "missing")}: ... }
    \item{[}{\code{signature(x = "MultiCompanion", i = "missing", j = "index", drop = "missing")}: ... }
    \item{\%*\%}{\code{signature(x = "MultiCompanion", y = "vector")}: ... }
    \item{\%*\%}{\code{signature(x = "vector", y = "MultiCompanion")}: ... }
    \item{coerce}{\code{signature(from = "MultiCompanion", to = "Matrix")}: ... }
    \item{coerce<-}{\code{signature(from = "MultiCompanion", to = "Matrix")}: ... }
    \item{Math}{\code{signature(x = "MultiCompanion")}: ... }
    \item{Math2}{\code{signature(x = "MultiCompanion")}: ... }
    \item{Ops}{\code{signature(e1 = "ANY", e2 = "MultiCompanion")}: ... }
    \item{Ops}{\code{signature(e1 = "complex", e2 = "MultiCompanion")}: ... }
    \item{Ops}{\code{signature(e1 = "logical", e2 = "MultiCompanion")}: ... }
    \item{Ops}{\code{signature(e1 = "matrix", e2 = "MultiCompanion")}: ... }
    \item{Ops}{\code{signature(e1 = "MultiCompanion", e2 = "ANY")}: ... }
    \item{Ops}{\code{signature(e1 = "MultiCompanion", e2 = "complex")}: ... }
    \item{Ops}{\code{signature(e1 = "MultiCompanion", e2 = "logical")}: ... }
    \item{Ops}{\code{signature(e1 = "MultiCompanion", e2 = "matrix")}: ... }
    \item{Ops}{\code{signature(e1 = "MultiCompanion", e2 = "Matrix")}: ... }
    \item{Ops}{\code{signature(e1 = "MultiCompanion", e2 = "MultiCompanion")}: ... }
    \item{Ops}{\code{signature(e1 = "MultiCompanion", e2 = "numeric")}: ... }
    \item{Ops}{\code{signature(e1 = "MultiCompanion", e2 = "vector")}: ... }
    \item{Ops}{\code{signature(e1 = "numeric", e2 = "MultiCompanion")}: ... }
    \item{Ops}{\code{signature(e1 = "vector", e2 = "MultiCompanion")}: ... }
    \item{Summary}{\code{signature(x = "MultiCompanion")}: ... }}
}
\references{%
  \insertRef{boshnakov2002mc}{mcompanion}
  
  \insertRef{boshnakov2009gen}{mcompanion}
  
}
\author{Georgi N. Boshnakov}
\note{
  The implementation is rather redundant, this class probably should
  inherit in a different way from classes in Matrix package or may be
  not inherit at all.

  Methods to get the multi-order, mo.col, and others, would be useful
  but first the terminology needs to be made consistent.

  Other matrix arithmetic operations?

  Argument \code{n} is called \code{dim} in other functions.
}
\seealso{
  \code{\link{mCompanion}} and  the examples there;
  the following functions produce multi-companion matrices but do not
  return \code{MultiCompanion} objects:

  \code{\link{sim_mc}}, \code{\link{make_mcmatrix}}

%	or \code{\link{CLASSNAME-class}} for links to other classes
}
\examples{
a1 <- matrix(1:12, nrow = 2)
mc1 <- new("MultiCompanion", xtop = a1)
new("MultiCompanion", a1)   # same

a2 <- matrix(c(1:6, rep(0, 4)), nrow = 2)   # 1st 3 columns of a2 are non-zero
mc2 <- new("MultiCompanion", a2)
mc2
mc2@mo.col     # =5, because the default is to set mo.col to ncol

mc2a <- new("MultiCompanion", a2, detect = "mo.col")
mc2a@mo.col   # =3, compare with above

b <- as(mc2, "matrix")  # b is ordinary R matrix
mcb <- new("MultiCompanion", x = b)
       new("MultiCompanion", b)   # same as mcb

mcb@mo        # 2 (mo detected)
mcb@mo.col    # 5 (no attempt to detect mo.col)

mcba <- new("MultiCompanion", b, detect = "all")
mcba@mo        # 2 (mo detected)
mcba@mo.col    # 3 (mo.col detected)
}
\keyword{classes}
