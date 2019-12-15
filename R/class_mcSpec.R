setClassUnion("optionalMatrix", c("matrix", "NULL"))   # 2014-06-08

                                        # new 2013-10-10
mcSpec <-
setClass("mcSpec"      # 2014-11-23 slots was: "representation" which is obsolete from R-3.0.0
         , slots = list(  dim     = "numeric"     # a single number
                          , mo      = "numeric"     # multi-companion order; period in ts
                          , ev.type = "character"   # currently "r" and "cp"
                          , co.type = "character"   # "top" or "bottom, not used currently
                          , order = "numeric"  # orders of the factors, currently set to
                                               # rep(dim, mo) but may be used to deduce
                                               # mo.col
                          , n.root = "numeric" # number of non-zero roots; currently = dim

                          , ev.abs = "numeric"
                          , ev.arg = "numeric"
                          , block.length = "numeric"

                          , co.abs = "matrix"
                          , co.arg = "matrix"

                          , mo.col = "numeric"   # 2014-06-08 new slots
                          , F0bot = "optionalMatrix"

                          )
         #, prototype=list(m=matrix(NA,nrow=4,ncol=9) )
         )

.Hz_real <- function(x){
    ifelse(x >= 0, 0, 1/2) # 0 for positive real; 1/2 for negative (Hz) !!!
}

spec_root1 <- function(mo, root1 = numeric(0), iorder = 0, siorder = 0){
    wrk <- rep(siorder, mo)
    wrk[1] <- wrk[1] + iorder

    wrk <- if(length(root1) == mo)
               wrk + root1
           else
               c(wrk, root1)

    wrk <- wrk[wrk > 0]
    if(length(wrk) > mo)
        stop("Conflicting specifications of the unit roots.")

    if(length(wrk) == 0){
        list()
    }else{
        co1 <- spec_seeds1(wrk, mo)     # co parameters for roots = 1

        stopifnot(sum(wrk) == ncol(co1))  # todo: for testing

        list(mo = mo
             , ev.type = rep("r", length(wrk))  # roots  = 1 are real
             , co.type = rep("r", length(wrk))
                  #, order
             , n.root = sum(wrk)
             , ev.abs = rep(1, length(wrk))
             , ev.arg = rep(0, length(wrk))   # 0 for positive ev
             , block.length = wrk
             , co.abs = abs(co1)
             , co.arg = .Hz_real(co1)         # 0 for positive; 1/2 for negative

             , co1 = co1 # temporary
            )
    }
}

spec_seeds1 <- function(len.block, mo){           # Specify the "co" things for the unit roots
    resnew <- spec_core(mo, 1, len.block)
    resnew$co
}

spec_root0 <- function(dim, mo, mo.col){
    stopifnot(mo.col <= dim)

    if(mo.col == dim)
        return(list())

    ## mo.col < dim

    wrk <- mc_0chains(dim, mo, mo.col) # structural zero-chains
    n.blocks <- length(wrk$len.block)

                                        # 2014-06-27 - use argument drop
                                        # 2014-07-21 - bug fix - need two commas!  [ , ,]
                # was: co0 <- wrk$eigvec[(dim - mo + 1) : dim, drop = FALSE]  # bottom mo rows
    co0 <- wrk$eigvec[(dim - mo + 1) : dim, , drop = FALSE]  # bottom mo rows

    ev.type <- rep("r", n.blocks)
                                      # todo: is there a need to include mo.col in the result?
                                      #       or rather, why not include it?
    list(mo = mo
         , ev.type = ev.type
         , co.type = ev.type
                  #, order
         , n.root = 0
         , ev.abs = numeric(n.blocks)
         , ev.arg = numeric(n.blocks)   # 0 for positive ev
         , block.length = wrk$len.block
         , co.abs = abs(co0)
         , co.arg = .Hz_real(co0)         # 0 for positive; 1/2 for negative

         , co0 = co0 # redundant but keep it for now.
         )
}

.adjust_mo_col <- function(mo.col, n.roots, order, unit.roots){
    if(!identical(n.roots, mo.col)  && is.null(mo.col))
        mo.col <- n.roots

    if(is.null(mo.col))
        max(order)
    else if(identical(mo.col, "+ones"))
        max(order) + unit.roots$n.roots
    else if(is.numeric(mo.col) && length(mo.col) == 1)
        mo.col
    else
        stop("'mo.col' can be a number, the string '+ones', or NULL")
}


.bind <- function(len, x, y, z){
    if(is.null(z))
        z <- numeric(0)
    len.na <- len - (length(x) + length(y) + length(z))
    stopifnot(len.na >= 0)
    c(x, y, z, rep(NA_real_, len.na))
}

.cbind <- function(nr, nc, x, y, z){
    if(is.null(x))
        x <- matrix(NA_real_, ncol = 0, nrow = nr)
    if(is.null(y))
        y <- matrix(NA_real_, ncol = 0, nrow = nr)
    if(is.null(z))
        z <- matrix(NA_real_, ncol = 0, nrow = nr)

                                 # 2014-06-27 was: nc.na <- nc - (ncol(x) + ncol(y) + ncol(z))
                                 #            TODO: tova e krapka, vzh lina/wrk23 and
                                 #                  zero.roots in mcSpec
    nc.na <- nc - (NCOL(x) + NCOL(y) + NCOL(z))
    stopifnot(nc.na >= 0)
    m <- matrix(NA_real_, nrow = nr, ncol = nc.na)
    cbind(x, y, z, m)
}


               # Note:  n.roots and mo.col are not necessarilly equal; TODO: think about this!
setMethod("initialize",        # 2014-05-26 significant updates and bug fixes to this function
          "mcSpec",
          function(.Object, dim, mo,
                   root1 = numeric(0), iorder = 0, siorder = 0,
                   order = rep(dim, mo), evtypes = NULL,
                   mo.col = NULL, # new 2013-10-29 (oversight that there is a slot n.roots?)
                   n.roots = mo.col,  # new 2014-05-27
                   ## 2014-05-26 TODO: argument block.length?
                   ... ){
              dots <- list(...)

              F0bot <- dots$F0bot

                                                             # special treatment for roots = 1
              unit.roots <- spec_root1(mo, root1, iorder, siorder) # process root = 1 specs
                                       # root1, iorder, siorder are not used after this point.

              mo.col <- .adjust_mo_col(mo.col, n.roots, order, unit.roots)
              stopifnot(mo.col <= dim)

              zero.roots <- spec_root0(dim, mo, mo.col)

              if(!is.null(evtypes)){   # 2014-06-05 evtypes => ev.type; deprecate arg. evtypes
                  print("Argument 'evtypes' is deprecated; use 'ev.type' instead.")
                  if(!is.null(dots$ev.type))
                      stop("Only one of 'evtypes' and 'ev.type' can be specified.")
                  dots$ev.type <- evtypes
              }

                      # character(0) to ensure "character" result, even if the others are NULL
              ev.type <- c(character(0),
                           unit.roots$ev.type, zero.roots$ev.type,
                           dots$ev.type # additional specs specified by arg. dots$ev.type
                           )

              block.length <- c(numeric(0),
                                unit.roots$block.length, zero.roots$block.length,
                                rep(1, length(dots$ev.type)) # dots$ev.type specifies simple
                                                             # roots
                                )                       # todo: allow multiple roots?

              root.count <- sum(block.length[ev.type == "r"]) +
                            2 * sum(block.length[ev.type == "cp"])

              stopifnot(root.count <= dim)

              if(root.count < dim){
                  # 2014-11-28 this was totally wrong
                  #
                  #     old.len.ev.type <- length(ev.type)
                  #     ev.type <- c(ev.type,
                  #                  rep("r", (dim - length(ev.type)) %% 2),  # 0 or 1 times
                  #                  rep("cp", (dim - length(ev.type)) %/% 2)
                  #                  )
                  ## 2014-06-27 was: block.length <- c(block.length, rep(1, dim - root.count))
                  #     block.length <- c(block.length,rep(1,length(ev.type)-old.len.ev.type))
                  # }

                             # for now assume that all other roots are simple and unspecified.
                  old.len.ev.type <- length(ev.type)
                  ev.type <- c(ev.type,
                               rep("r", (dim - root.count) %% 2),  # 0 or 1 times
                               rep("cp", (dim - root.count) %/% 2)
                               )
                  block.length <- c(block.length, rep(1, length(ev.type) - old.len.ev.type))
              }


              evlen <- length(ev.type)
              ncol <- sum(block.length)

              ev.abs <- .bind(evlen, unit.roots$ev.abs, zero.roots$ev.abs, dots$ev.abs)
              ev.arg <- .bind(evlen, unit.roots$ev.arg, zero.roots$ev.arg, dots$ev.arg)

              co.abs <- .cbind(mo, ncol, unit.roots$co.abs, zero.roots$co.abs, dots$co.abs)
              co.arg <- .cbind(mo, ncol, unit.roots$co.arg, zero.roots$co.arg, dots$co.arg)

              ## todo: co.type not assigned and not used currently

              .Object@dim          <- dim
              .Object@mo           <- mo
              .Object@ev.type      <- ev.type
              .Object@order        <- order
              .Object@ev.abs       <- ev.abs
              .Object@ev.arg       <- ev.arg
              .Object@block.length <- block.length
              .Object@co.abs       <- co.abs
              .Object@co.arg       <- co.arg

                                                     # broy na nelulevi koreni, often = mo.col
                                      # 2014-08-19 bug: wasn't accounting for complex pairs
              .Object@n.root       <- #  was: sum(block.length) - sum(zero.roots$block.length)
                  sum( (1 + (ev.type == "cp")) * block.length ) - sum(zero.roots$block.length)

              .Object@mo.col <- mo.col # 2014-06-08
              .Object@F0bot = F0bot

              .Object
          }
          )
