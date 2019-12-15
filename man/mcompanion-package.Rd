\name{mcompanion-package}
\alias{mcompanion-package}
\alias{mcompanion}
\docType{package}
\title{
  \Sexpr[stage=build,results=hide]{pd <- packageDescription("mcompanion")}
  \Sexpr[stage=build,results=hide]{lb <- library(help="mcompanion", character.only=TRUE)}
  \Sexpr[stage=build,results=hide]{lbinfo <- if(!is.null(lb$info[[2]])) lb$info[[2]] else "No_matches"}
  \Sexpr[stage=build,results=hide]{anypat <- function(string, pat, ...){ any(sapply(pat, function(x) grepl(x, string, ...))) }}
  \Sexpr[stage=build,results=hide]{
    lbsubset <- function(lbinfo, pat){
      if(length(lbinfo) == 0) return("No entries")
      ind.start <- which(sapply(lbinfo, function(x) anypat(x, pat)))
      if(length(ind.start) == 0) return("No entries")
      ind.ws <- which(grepl("^[[:space:]]+", lbinfo))
      res <- ind.start
      for(ind in ind.start){
	while(any((ind+1) - ind.ws == 0)){
	  ind <- ind + 1
	  res <- c(res, ind)
	}
      }
      lbinfo[ sort(res) ]
    }
  }
  \Sexpr[stage=build,results=hide]{lbpaste <- function(pat) paste("\\\\preformatted{",
    {wrk <- lbsubset(lbinfo,pat);
    paste(if(length(wrk) > 0) wrk else "No entries", collapse="\\n")}, "}", sep="")}

  \Sexpr[stage=build]{pd$Title}
}
\description{
  \Sexpr[stage=build]{pd$Description}
}
\details{
   \tabular{ll}{
   Package:  \tab \Sexpr[stage=build]{pd$Package}\cr
   Type:     \tab \Sexpr[stage=build]{pd$Type}\cr
   Version:  \tab \Sexpr[stage=build]{pd$Version} \cr
   Date:     \tab \Sexpr[stage=build]{pd$Date}\cr
   License:  \tab \Sexpr[stage=build]{pd$License}\cr
   LazyLoad: \tab \Sexpr[stage=build]{pd$LazyLoad}\cr
   Built:    \tab \Sexpr[stage=build]{pd$Built}\cr
   }

   % 2014-10-30 slagam tematichen index.
  \strong{Index of the main exported objects, classes and methods:}
% \Sexpr[stage=build,results=rd]{paste("\\\\preformatted{", paste(if(!is.null(lb$info[[2]])) lb$info[[2]] else "No entries",collapse="\n"), "}", sep="")}


  % \subsection{Dummy example}{
  % \Sexpr[stage=build,results=rd]{lbpaste(c("^[^[:space:]]+"))
  %   }
  % }

    \subsection{Classes and generators}{
  \Sexpr[stage=build,results=rd]{lbpaste(
    c("[^[:space:]]+-class[[:space:]]+",
      "mCompanion", "mcSpec",
      "mf_VSform", "VAR2pcfilter"
    )
  )}

    }

    \subsection{Utilities for multi-companion matrices}{
  \Sexpr[stage=build,results=rd]{lbpaste(
    c("mc_eigen", "mc_factorize", "mc_from_factors", "mc_full", "mc_order", "is_mc_bottom",
      "^mc_factors"
    )
  )}

    }

  % \subsection{Generator functions for classes:}{
  % \Sexpr[stage=build,results=rd]{lbpaste(
  %   paste(c("^pcSeason", "^slMatrix", "^pcAcf", "^pcts", "^sVector"),
  %         "[[:space:]]", sep = "")
  % )}
  %
  %   }

  \subsection{Simulation}{
  \Sexpr[stage=build,results=rd]{lbpaste(
    c("^sim_")
  )}

    }

  \subsection{Generic matrix utilities}{
  \Sexpr[stage=build,results=rd]{lbpaste(
    c("Jordan_matrix", "rblockmult", "mcStable")
  )}

    }

  \subsection{Spectral description of mc-matrices}{
  \Sexpr[stage=build,results=rd]{lbpaste(
    c("^spec_.+", "spec_seeds1", "^mC[.]gen.*")
  )}

    }

  \subsection{Low-level functions}{   %       "^mC[.]0.+", "^mC[.]non0.+",
  \Sexpr[stage=build,results=rd]{lbpaste(
    c("^mc[.]chain.*",
      "^sim_mcseeds", "^mc_0chains", "mc_chain_extend"
    )
  )}

    }



% ~~ An overview of how to use the package, including the most important ~~
% ~~ functions ~~
\strong{Overview of the package}

Package "mcompanion" implements multi-companion matrices as discussed by
Boshnakov (2002) and Boshnakov and Iqelan (2009). The main feature is
the provided parsimonious parameterisation of such matrices based on
their eigenvalues and the seeds for their eigenvectors.  This can be
used for specification and parameterisation of models for time
series and dynamical systems in terms of spectral characteristics, such
as the poles of the associated filters or transition matrices.

A multi-companion matrix of order k is a square \eqn{n\times n}{n x n}
matrix with arbitrary k rows put on top of an identity
\eqn{(n-k)\times(n-k)}{(n-k)x(n-k)} matrix and a zero \eqn{(n-k)\times
k}{(n-k)x k} matrix. The number \eqn{k} is the multi-companion order of
the matrix.  It may happen that the top \eqn{k \times n}{k x n} block,
say T, of an mc-matrix has columns of zeroes at its end.  In this
documentation we say that an \eqn{n\times n}{n x n} matrix has dimension
\eqn{n} and size \eqn{n\times n}{(n,n)}.
% We will say that the column order of the multi-companion matrix is
%  \eqn{m} if ...

Multi-companion matrices can be created by the functions \code{new} and
\code{\link{mCompanion}}, the latter being more versatile. Some of the other
functions  in this package return such objects, as well.

\code{\link{sim_mc}} generates a multi-companion matrix with partially or fully
specified spectral properties. If the specification is incomplete, it
completes it with simulated values.

\code{\link{sim_pcfilter}} is a convenience function (it uses \code{sim_mc})
for generation of filters for periodically correlated models.  These can
be converted to various multivariate models, such as VAR, most
conveniently using class \code{\linkS4class{MultiFilter}}, see
below.

Class "MultiFilter" is a formal representation of periodic
filters with methods for conversion between periodic and (non-periodic)
multivariate filters. Several forms of VAR models are provided, see
\code{\link{mf_VSform}},
\code{\link{VAR2pcfilter}},
\code{\linkS4class{MultiFilter}},
and the examples there.




% The core code for this package was written mainly between
% 2004--2008.

}
\author{
  \Sexpr[stage=build]{pd$Author}

Maintainer: \Sexpr[stage=build]{pd$Maintainer}
}
\references{% bibentry:all
Boshnakov GN (2002).
``Multi-companion matrices.''
\emph{Linear Algebra Appl.}, \bold{354}, pp. 53--83.
ISSN 0024-3795, \url{http://dx.doi.org/10.1016/S0024-3795(01)00475-X}.

Boshnakov GN (2007).
``Singular value decomposition of multi-companion matrices.''
\emph{Linear Algebra Appl.}, \bold{424}(2-3), pp. 393--404.
ISSN 0024-3795, \url{http://dx.doi.org/10.1016/j.laa.2007.02.010}.

Boshnakov GN and Iqelan BM (2009).
``Generation of time series models with given spectral
properties.''
\emph{J. Time Series Anal.}, \bold{30}(3), pp. 349--368.
ISSN 0143-9782, \url{http://dx.doi.org/10.1111/j.1467-9892.2009.00617.x}.
% end:bibentry:all
}
\seealso{
  for examples, see
  \code{\link{mCompanion}},
  \code{\link{sim_mc}},
  \code{\link{sim_pcfilter}},
  \code{\link{mf_VSform}},
  \code{\link{VAR2pcfilter}},\cr
  \code{\linkS4class{MultiFilter}},
  \code{\linkS4class{MultiCompanion}},
}
\examples{
## see the examples in the links in section 'See Also' above.
}
\keyword{ package }
