                                                                        # class MultiCompanion
           # 2014-11-23 "representation" is deprecated from R-3.0.0, now using 'slots' instead
setClass("MultiCompanion",
         slots = c(xtop   = "matrix",   # variable part
                   mo     = "numeric",  # number of non-trivial rows
                   ido    = "numeric",  # dimension of the identity part: nc-mo
                   mo.col = "numeric",  # nonzero columns in the top rows
                              # razni = "list",    # lazy! temporary...; macham na 31/10/2006.
                   pad    = "objectPad"
                   ),
         contains = c("ddenseMatrix", "generalMatrix")
         #, prototype=list(m=matrix(NA,nrow=4,ncol=9) )
         )

                                                                          # begin: As methods
setAs("MultiCompanion", "matrix",
      function(from){
        rbind(from@xtop, diag(1, nrow=from@ido, ncol=ncol(from)) )
      }
      )
                # need to define the S3 method since as.matrix doesn't see S4 methods for as()
as.matrix.MultiCompanion <-
    function(x, ...){
        as(x, "matrix") # rbind(x@xtop, diag(1,nrow=x@ido,ncol=ncol(x)) )
    }


setAs("matrix", "MultiCompanion",
      function(from) mCompanion(from, detect="mo") )


setAs("MultiCompanion", "dgeMatrix",
      function(from){
          ## 2022-10-19 was: as(as(from, "matrix"), "dgeMatrix") )
          ##     as(<matrix>, "dgeMatrix") is deprecated since Matrix 1.5-0; do
          ##         as(as(as(., "dMatrix"), "generalMatrix"), "unpackedMatrix")
          ##     instead.
          ## Note that once this method is defined, it can be used in my functions when the 
          ## argument is "MultiCompanion", since package Matrix doesn't forbid me that. 
          ## TODO: but it will beprudent to make this method convert to something allowed 
          ##       also by Matrix.  
          m <- as(from, "matrix")
          as(as(as(m, "dMatrix"), "generalMatrix"), "unpackedMatrix")
      })

setAs("dgeMatrix", "MultiCompanion",
      function(from)  as(as(from, "matrix"), "MultiCompanion") )
                                                                          #   end: As methods

                                                      #  begin: create MultiCompanion objects
setMethod("initialize", "MultiCompanion",
    function(.Object, xtop, mo, n, mo.col, ido, x, dimnames, detect="nothing", misc=list()) {
        ## function patched many times, hardly readable...

        ## xtop -  missing, vector, matrix or admits as.matrix(xtop)
        if( !missing(xtop) ){
            flag.xtop <- TRUE
            if( is.vector(xtop) ){    # class(x)=="numeric" fails for other types of vector
                                        # (integer, complex,...)
                xtop <- matrix(xtop, nrow=1)
            }else{
                if( !is.matrix(xtop) )
                    xtop <- as.matrix(xtop)
            }
            wrk.n <- ncol(xtop)
            wrk.mo <- nrow(xtop)
            if(missing(x) && wrk.n==wrk.mo){
                ## 02/05/2007 xtop is probably x in this case,
                ##            now check for consistency with mo.
                tmptmpmo <- mc_order(xtop)
                stopifnot(missing(mo)  ||  !is.numeric(mo) || tmptmpmo == mo)
                wrk.mo <- tmptmpmo
            }
            wrk.ido <- wrk.n - wrk.mo
                                        # todo: dimnames ...
        }else{
            flag.xtop <- FALSE
        }

        ## x -  missing, vector, matrix or admits as.matrix(x)
        if( !missing(x) ){
            flag.x <- TRUE
            if( is.vector(x) ){
                if( as.integer(sqrt(length(x)))^2 != length(x) )
                    stop("square root of length x  must be integer, if x is present")
                else
                    x <- matrix(as.numeric(x), nrow = as.integer(sqrt(length(x))) )
            }else{
                if( !is.matrix(x) )
                    x <- as.matrix(x)
            }
            xwrk.n <- ncol(x)

            xwrk.mo <- if(detect=="mo")  # should "mo" be default for detect?
                           mc_order(x)
                       else if( !missing(mo) )
                           mo
                       else if( flag.xtop )
                           wrk.mo
                       else
                           xwrk.n

            xwrk.ido <- xwrk.n - xwrk.mo

                                        # todo: dimnames ...
        }else{
            flag.x <- FALSE
        }

        ##  both xtop and x given - check for consistency
        if( flag.xtop && flag.x ){       # stop if x and xtop are not consistent
            stopifnot(xwrk.n == wrk.n,
                      xwrk.mo == wrk.mo,
                                        # all( xtop[1:length(xtop)] == x[1:length(xtop)] )
                      all( xtop[1:wrk.mo,] == x[1:wrk.mo,] )
                      )
        }else if( flag.x ){
            xtop <- x[1:xwrk.mo,1:xwrk.n,drop=FALSE]
            wrk.n <- xwrk.n
            wrk.mo <- xwrk.mo
            wrk.ido <- xwrk.ido
        }
        stopifnot(  missing(mo)  || mo  == wrk.mo
                  , missing(n)   || n   == wrk.n
                  , missing(ido) || ido == wrk.ido
                  )

        ## an additional check - a patch introduced together with tmptmpmo (see above)
        if( !flag.x ){
            if( nrow(xtop) < ncol(xtop) )
                x <- rbind(xtop, diag(1,nrow=wrk.ido,ncol=wrk.n))
            else{ # xtop is actually x here
                x <- xtop
                xtop <- xtop[1:wrk.mo,]
            }
        }
                               # todo: check validity of dimnames (or set up a validity check)
        ## set and validate mo.col
        missmo.col <- missing(mo.col)
        if(missmo.col || is.character(mo.col) ){                         # 03/12/2006
            wrk.mo.col <- wrk.n                                 # lazy, e.g. mo.col="detect"
                 # 20/03/2007  if(detect=="all" || detect=="mo.col" || is.character(mo.col) )
            if(detect=="all" || detect=="mo.col" || (!missmo.col && is.character(mo.col)) ){
                while(all(xtop[,wrk.mo.col]==0))
                    wrk.mo.col <- wrk.mo.col - 1
            }                                                    # give warning if xtop==0 ?
        }else
            wrk.mo.col <- mo.col

        ## initialise the pad
        wrk.pad <- new("objectPad")
        for( s in names(misc))
            pad(wrk.pad, s) <- misc[[s]]


        .Object@Dim      <- c(wrk.n, wrk.n)        # Dim, Dimnames and x are  inherited slots.
        .Object@Dimnames <- list(NULL, NULL) # lazy
        .Object@x        <- as.numeric(x) # todo: will not work e.g. for complex

        .Object@xtop   <- xtop
        .Object@mo     <- wrk.mo
        .Object@mo.col <- wrk.mo.col
        .Object@ido    <- wrk.ido

        .Object@pad    <- wrk.pad
        ## .Object@razni <- razni   31/10/2006

        .Object
    }
)

### setGeneric("MultiCompanion", def = function(x,...){standardGeneric("MultiCompanion")},
###            useAsDefault = FALSE
###            )

mCompanion <- function(x, detect = "nothing", misc = list(), ...){   # sig changes: 3/12/2006
    if(length(x) == 1 && x == "sim"){# here ... are for the generator, not new("multi...") !
        wrk <- sim_mc(...)
    }else if(length(x) == 1 && x == "gen"){
        ## TODO: assumes "..."  contains what.res = "list"
        ##       otherwise wrk$mat below raises an error!
        wrk <- make_mcmatrix(...)
    }else if(detect == "gen"){                      # x is from make_mcmatrix or sim_mc
        wrk <- x
    }else{
        wrk <- list()
    }

    if(length(wrk) > 0){
        xtop <- wrk$mat[1:wrk$mo, ]
        wrk$mat <- NULL             # remove mat from wrk
        mo.col <- wrk$mo.col
        xmisc <- c(misc, wrk)      # this will be put in the pad, some info here is redundant.
        new("MultiCompanion", xtop = xtop, detect = "nothing", mo.col = mo.col, misc = xmisc)
    }else if(detect == "mo"){
        new("MultiCompanion", x = x, detect = detect, misc = misc, ...)
    }else
        new("MultiCompanion", xtop = x, detect = detect, misc = misc, ...)
}
                                                        #   end: create MultiCompanion objects


                                                                         # begin: subscripting

################# Note: replacement is inherited from dgeMatrix, a method here would
################# be useful for cases when replacement of a row keeps the MultiCompanion type.

# "[" - modified from denseMatrix.R in Matrix

# get rows: result is not square, so cannot be multicompanion unless all rows are selected.
setMethod("[", signature(x = "MultiCompanion", i = "index", j = "missing",
			 drop = "logical"),
          function (x, i, drop) {

            r <- as(x, "matrix")[i, , drop=drop]
            if(is.null(dim(r)))
              r
            else if(nrow(r)==ncol(r))          # assumes nrow and ncol are defined for r
              mCompanion(r, detect="mo")
            else
              as(as(as(r, "dMatrix"), "generalMatrix"), "unpackedMatrix")
          })

setMethod("[", signature(x = "MultiCompanion",  i = "missing", j = "index",
			 drop = "logical"),
          function (x, j, drop) {
            r <- as(x, "matrix")[, j, drop=drop]
            if(is.null(dim(r)))
              r
            else if(nrow(r)==ncol(r))          # assumes nrow and ncol are defined for r
              mCompanion(r, detect="mo")
            else
              as(as(as(r, "dMatrix"), "generalMatrix"), "unpackedMatrix")
          })

setMethod("[", signature(x = "MultiCompanion",  i = "index", j = "index",
			 drop = "logical"),
          function (x, i, j, drop) {
            # v denseMatrix call'at za tozi sluchay e:
            #                 r <- callGeneric(x = as(x, "matrix"), i=i, j=j, drop=drop)
            # ne mi e mnogo yasno kakva e razlikata. Efektivnost?
            r <- as(x, "matrix")[i, j, drop=drop]
            if(is.null(dim(r)))
              r
            else if(nrow(r)==ncol(r))          # assumes nrow and ncol are defined for r
              mCompanion(r, detect="mo")
            else
              as(as(as(r, "dMatrix"), "generalMatrix"), "unpackedMatrix")
          })
                                                                         #   end: subscripting

                                                                                  # begin: %*%
setMethod("%*%", signature(x = "MultiCompanion", y = "MultiCompanion"),
          function(x,y){
              wrk <- x@xtop %*% as(y,"matrix")

              m <- min( x@ido, y@mo )
              if( m > 0 ){
                  wrk2 <- y@xtop[1:m,]
                  wrk <- rbind(wrk,wrk2)
              }
              res <- mCompanion(wrk)
              res
          },
          valueClass = "MultiCompanion"
          )

# special method for diagonal matrix? keep MultiCompanion type if mult by identity?

# needs specific implementation but is ok
setMethod("%*%", signature(x = "MultiCompanion", y = "ANY"),
          function(x,y){
              as(x, "dgeMatrix") %*% y   # use something like callGeneric instead?
          }
          )

## needs specific implementation but is ok
setMethod("%*%", signature( x = "ANY", y = "MultiCompanion"),
          function(x,y){
              x %*% as(y, "dgeMatrix")
          }
          )

## 2015-07-24 adding methods with signature "matrix" to resolve the following error and
##            warning from the last example in mCompanion:
##
## > m4 <- rbind(c(1,2,rep(0,4)),c(3,4,rep(0,4)))
## > x4a <- mCompanion(m4,mo=2,mo.col=2)
## > ev <- mc_eigen(x4a)
## > x4a %*% ev$vectors
## Note: method with signature 'ddenseMatrix#matrix chosen for function '%*%',
##  target signature 'MultiCompanion#matrix'.
##  "MultiCompanion#ANY" would also be valid
## Error in x4a %*% ev$vectors :
##   invalid class 'MultiCompanion' to dup_mMatrix_as_geMatrix
## Calls: %*% -> %*%
##
##  TODO: may need more extensive checking since something may have changed in Matrix package
##        that affects other computations without specific methods for MultiCompanion
##        matrices.

setMethod("%*%", signature(x = "MultiCompanion", y = "matrix"),
          function(x,y){
              as(x, "dgeMatrix") %*% y   # use something like callGeneric instead?
          }
          )

# needs specific implementation but is ok
setMethod("%*%", signature( x = "matrix", y = "MultiCompanion"),
          function(x,y){
              x %*% as(y, "dgeMatrix")
          }
          )
                                                                                  #   end: %*%


# change when other types of MultiCompanion are implemented.                       # transpose
setMethod("t", signature(x = "MultiCompanion"),
          function(x){
              t(as(x, "dgeMatrix"))
          }
          )

setMethod("mcStable", signature( x = "MultiCompanion" ),
          function(x){
              wrk <- mc_eigenvalues(x)
              all(abs(wrk) < 1)
          }
          )
                                                                    # end class MultiCompanion

                                                 # 2014-10-21 renamed mC.factors to mc_factors
mc_factors <- function(x,what="mc"){ # 15/05/2007 new  arg: "what" to vary type of result
    if(what == "mc"  &&  padcheck(x,"mC.factors"))
        return( pad(x,"mC.factors") )
    else if(what != "mc"  &&  padcheck(x,"mC.factorsmat"))
        return( pad(x,"mC.factorsmat") )

    if(padcheck(x,"mC.factorsmat"))
        wrk <- pad(x,"mC.factorsmat")
    else if(padcheck(x,"mC.factors")){
        tmp <- pad(x,"mC.factors")
        wrk <- tmp[[1]][1,]
        for(s in tmp[-1])
            wrk <- rbind(wrk,s[1,])
    }else{
        wrk <- if(x@mo == 1)
                   x
               else
                   mc_factorize(x,x@mo,x@mo.col)
    }

    if(what == "mc"){
        if(x@mo == 1)
            res <- list(wrk)
        else{
            xmocol <- x@mo.col
            res <- apply(wrk,1,function(y) mCompanion(y,mo.col=xmocol) )
        }
        pad(x,"mC.factors") <- res    # expects that the original x will be changed,
                                      # not the local copy supplied to this function.
    }else{
        res <- wrk
        pad(x,"mC.factorsmat") <- res
    }

    res
}

mc_eigenvalues <- function(x, ...){
    if( !is.null(pad(x, "eigval")) )
        pad(x, "eigval")
    else{
        wrk <- eigen(x, only.values = TRUE)
        wrk$values
    }
}

mc_eigen <- function(x, ...){
    if(!is(x, "MultiCompanion")) #2015-10-29 new check; TODO: should it process other classes?
        stop("x must be from class MultiCompanion")

    if(!is.null(pad(x, "eigval")) && !is.null(pad(x, "eigvec"))){
        res <- list(values = pad(x, "eigval"),
                    vectors = pad(x, "eigvec"),
                    len.block = if(!is.null(pad(x, "len.block")))
                                    pad(x, "len.block") # TODO: proveri dali tova se poddarzha
                                                        # ot MultiCompanion???
                                else
                                    rep(1, length(res$values))
                    )
    }else if(x@mo.col == ncol(x)){
        res <- eigen(x)
        res$len.block <- rep(1, length(res$values))
    }else{                # 10/05/2007 kombiniram sluchaite x@mo.col >= x@mo i x@mo.col < x@mo
        wrk <- x[1:x@mo.col, 1:x@mo.col, drop = FALSE] # 2015-12-26 added drop = ...
        wr2 <- eigen(wrk)

        evnew <- list(eigval    = wr2$values,
                      eigvec    = wr2$vectors,
                      len.block = rep(1, length(wr2$values)),
                      mo.col    = x@mo.col,
                      mo        = x@mo )

        if(x@mo.col < x@mo){# 2015-12-26 changing to use small multi-companion; was:
                            #   mc_chain_extend(evnew,x@mo,ncol(x),
                            #     F0bot=as.matrix(x[(x@mo.col+1):x@mo,1:x@mo.col,drop=FALSE]))
            smc <- new("SmallMultiCompanion", Mtop = as.matrix(wrk),
                       Mbot = as.matrix(x[(x@mo.col + 1):x@mo, 1:x@mo.col, drop = FALSE]),
                       jdMtop = evnew)
            smc_ch <- smc_chains(smc)
            evnew <- mc_chain_extend(smc_ch, ncol(x))
        }
        wrk3 <- mc_chain_extend(evnew, ncol(x))

        res <- list(values = wrk3$eigval, vectors = wrk3$eigvec, len.block = wrk3$len.block)
    }
    res      # vrasta list() kato eigen() + component len.block; TODO: da dobavya mo i mo.col?
}            #     c(res, list(mo = x@mo, mo.col = x@mo.col))

###                                                                         # class McVector
### setClass("McVector"
###          , representation(  mo     = "numeric"
###                           , eigval = "vector"
###                           , eigvec = "vector"
###                           , seed   = "vector"
###                           , seed.pos   = "numeric"
###                           , normalised = "character"
###                           )
###          #, contains = c("ddenseMatrix", "generalMatrix")
###          #, prototype=list(m=matrix(NA,nrow=4,ncol=9) )
###          )

##############################################################################################
# library(Matrix)
# source("c:\\Az\\Work\\R\\percorr\\pcts\\R\\pc990.r")
# m <- mCompanion(matrix(rnorm(8),nrow=2))

# class ? "Matrix"
# class ? "pMatrix"

# m + Matrix(diag(4))
# m %*% Matrix(diag(4))
# m + Matrix(1,nrow=4,ncol=4)
# m %*% Matrix(1,nrow=4,ncol=4)
# m %*% as(4:1,"pMatrix")
# as(4:1,"pMatrix")
#  as(4:1,"pMatrix")m %*% as(4:1,"pMatrix")
#  t(as(4:1,"pMatrix")) %*% m %*% as(4:1,"pMatrix")
# t(m)
# showMethods("t")
# expm(m)
# eigen(m)
# t(m)
# m

### numeric, dense, general matrices, see Matrix package.
### setClass("dgeMatrix", contains = c("ddenseMatrix", "generalMatrix"),
### 	 ## checks that length( @ x) == prod( @ Dim):
### 	 validity =
### 	 function(object) .Call(dgeMatrix_validate, object)
### 	 )
