## 2013-11-26 - changing mCsim.pcfilter. This file had not been changed since 2007-07-24!

# n.root - number of non-zero roots. Stepenta (order) na filtara e ravna na n.root.
# po printzip order mozhe da bade vector, no v momenta tyabva da e skalar.

             # 2013-11-26 - new argument mo.col;
             #              allow n.root < order (before, it had been assumed equal to order)
             #
             # 2014-10-21 renamed mCsim.pcfilter to sim_pcfilter;
             #            keeping mCsim.pcfilter with a warning that it will be removed.
sim_pcfilter <- function(period, n.root, order=n.root, mo.col, ...){
  if(missing(n.root))
    n.root <- max(order)    # pretsiziray kogato vavedesh vazmozhnost order da e vektor.
                            # 2013-11-26 order => max(order)
    ## 2013-11-26
    #if(order <= period){
    #  mo.col <- order
    #  # 12/05/2007 m <- period + 1 # krapka, za da mozhe dim da e po-golyamo ot multi-order.
    #                     # programite na nisko nivo tryabva da se nagodyat da tretirat
    #                     # tazi vazmozhnost.!
    #  m <- period
    #}else{
    #  m <- max(order,period,n.root)
    #  mo.col <- n.root
    #}

  if(missing(mo.col))
      mo.col <- n.root

  m <- max(order, period, n.root)

  wrk <- sim_mc(m, period, mo.col, ...)
  a <- mc_factorize(wrk$mat, period, mo.col)

  wrk$pcfilter <- a[period:1, 1:mo.col, drop=FALSE] # reverse the order since F is factored
                                                    # as F=Ad*...*A2*A1 with Ai for season i.
  wrk
}

## 2014-10-21 moved sim_real, sim_complex and sim_numbers to gbutils.

## 2015-10-18  renamed mCsim.co to sim_mcseeds
## 2015-10-26 new: argarg with a default in (0,pi)
## 2015-12-02 renamed from sim_mcseeds() to sim_chains()

##            !!! Renamed arguments: mo => dim, co => vectors, len.block => heights
##                Now type, vectors and heights default to NULL and checks with missing() are
##                replaced by checks with is.null().
##
## TODO: dovarshi, proveryavay za non-singular, mozhe bi arg. za condition number;
##                 normalizatsiya, kanonizatsiya (e.g. za higher chains) i t. n.
sim_chains <- function(dim = nrow(vectors), type = NULL, heights = NULL, vectors = NULL,
                           argarg = list(0, pi), ... ){
    if(is.null(heights))
        heights <- rep(1, if(is.null(vectors)) length(type)
                            else                 ncol(vectors) )

    if(is.null(vectors))  # as.numeric() since sim_numbers() will return complex, if necessary
        vectors <- matrix(as.numeric(NA), nrow = dim, ncol = sum(heights))

    exttype <- if(is.null(type))
                   rep("cp", ncol(vectors))
               else
                   rep(type, times = heights)

    rwrk <- rep(as.numeric(NA), length(vectors))

    alltype <- rep(exttype, each = dim)

    sel <- which(is.na(vectors))
    wrk <- sim_numbers(alltype[sel], rwrk[sel], rwrk[sel], argarg = argarg, ...)
    vectors[sel] <- wrk$values

    ## TODO: additional processing

    vectors
}

                                                         # 2014-10-21 renamed mC.sim to sim_mc
sim_mc <- function(dim, mo, mo.col=dim, eigval, len.block, type.eigval=NULL,
                   co, eigabs, eigsign, type="real", value="real", value.type="", ... ){

  use.eigval <- !missing(eigval)

  if(is.null(type.eigval)){
    type.eigval <- if(missing(eigval)){
                     c( rep("r",mo.col %% 2), rep("cp", mo.col %/% 2) )
                   }else{
                     if(mode(eigval)=="character"){  # compatibility with the old version
                       use.eigval <- FALSE
                       eigval
                     }else
                       ifelse(Im(eigval)==0,"r","cp")
                   }
  }

  nr  <- sum(type.eigval=="r")      # number of real roots
  ncp <- sum(type.eigval=="cp")     # number of complex pairs
  ncn <- sum(type.eigval=="c")      # number of complex (non-paired) roots
  nc  <- ncn + 2*ncp
  n   <- nr  +   ncp + ncn

  if(missing(eigabs))
    eigabs <- rep(as.numeric(NA),n)

  if(missing(eigsign))
    eigsign <- rep(as.numeric(NA),n)

  if( missing(len.block) )
    len.block <- rep(1,length(type.eigval))

  ev <- if(use.eigval)
          # sim_numbers(type.eigval,eigabs,eigsign,absgen,csigngen,signprob,...)
          sim_numbers(type.eigval, eigabs, eigsign, values=eigval, ...)
        else
          sim_numbers(type.eigval, eigabs, eigsign, ...)

  co <- if(missing(co))
                     # 2015-12-02 was: sim_mcseeds(mo=mo,len.block=len.block,type=ev$type,...)
            sim_chains(dim = mo, heights = len.block, type = ev$type, ...)
        else
               # 2015-12-02 was: sim_mcseeds(mo=mo,len.block=len.block,co=co,type=ev$type,...)
            sim_chains(dim = mo, heights = len.block, vectors = co, type = ev$type, ...)

  eigval <- c(     ev$values[ev$type=="r"]  ,
                   ev$values[ev$type=="cp"] ,
              Conj(ev$values[ev$type=="cp"]),
                   ev$values[ev$type=="c"]  )

                            # 2014-06-27 was :   exttype <- rep(ev$type,times=len.block)
                            #      TODO: this is a quick fix! check! similar error in sim_mcseeds
  exttype <- rep(ev$type, times = len.block)

  co <- cbind(     co[,exttype=="r"]  ,
                   co[,exttype=="cp"] ,
              Conj(co[,exttype=="cp"]),
                   co[,exttype=="c"]  )

  len.block <- c(len.block[ev$type=="r"],
                 len.block[ev$type=="cp"],
                 len.block[ev$type=="cp"],
                 len.block[ev$type=="c"]  )

                                                          # 2014-06-10 pass on mo.col, as well
  res <- make_mcmatrix(eigval, co, dim, len.block, what.co="bottom", type=type, what.res="list"
                , mo.col = mo.col )

  if(value.type=="matrix")
    return(res$mat)
  else if(value.type=="list")
    return(res)

  res
}

sim_Jordan <- function(values, heights = rep(1, length(values)), vectors = NULL, type = NULL,
                       ... ){
    if(is.null(type)){  # deduce the types
        type <- rep("cp", length(values)) ## default is "cp", also for NA's in values
        type[which(Im(values) == 0)] <- "r"
    }

    dim <- if(!is.null(vectors))
               nrow(vectors)
           else if(is.null(dim))
               sum(type == "r") + 2 * sum(type == "cp") + sum(type == "c")

    na.flags <- is.na(values)
    if(any(na.flags))
        sim_numbers(type[na.flags], values[na.flags], values[na.flags], ...)

    vectors <- sim_chains(dim = dim, type = type, heights = heights, vectors = vectors, ...)

    ## TODO: unfinished!

    vectors
}
