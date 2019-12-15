## basic computational routines for mc-matrices.

mc_matrix <- function(x){ # x is normally the top but may be the full matrix as well
    if(is.matrix(x))        # the returned value is the top or the full matrix, respectively.
        x
    else if(is.vector(x))                       # companion
        matrix(x, nrow = 1)
    else
        as.matrix(x)
}

mc_full <- function(x){    # x is the top or the full matrix
    wrk <- mc_matrix(x)
    nc <- ncol(wrk)
    ido <- nc - nrow(wrk)    # here ido=0 when either mcorder=nc or x is the full matrix.
    if(ido > 0)
        rbind(wrk, diag(1, nrow = ido, ncol = nc) )
    else if(ido == 0)
        wrk
    else
        stop("The top of the multi-companion matrix has more rows than columns.")
}

is_mc_bottom <- function(x){                         # todo: check x is a matrix-like object.
    (nrow(x) <= ncol(x)) && all( x == diag(1, nrow(x), ncol(x)) )
}

mc_order <- function(x){                                          # dali da razresha nc > nr ?
    nr <- nrow(x)
    if(nr != ncol(x)  ||  nr == 0) # 2013-03-26 allow 1x1 mat; was (nr != ncol(x) || nr == 1)
        stop("multi-companion order is defined for square matrices (at least 1x1) only.")

    for(i in 1:nr){
        if( is_mc_bottom( x[i:nr, 1:nr, drop = FALSE] ) )  # nr == nrow(x) == ncol(x)
            return(i - 1)
    }
    nr                   # considers a full matrix a particular case of multi-companion.
}

                                            # begin: companion factorization of MultiCompanion

mc_leftc <- function(x, mo, mo.col){ # written to work with the full matrix or top rows only;
    x <- mc_matrix(x)                  # in the former case arg mo should be used.
    m  <- ncol(x)
    nr <- nrow(x)
    if(missing(mo))
        mo <- nr

    if(nr == 1 || mo == 1)
        return(x[1, ])
    ## so, below we have nr >= 2 and mo >= 2

    if(missing(mo.col))
        mo.col <- m

    if(mo.col > m){
        stop("mo.col must be less than or equal to m")
    }else if(mo == 0){
        res <- NA      # todo: anything better here? maybe also warning?
    }else if(mo.col == 0){
        res <- numeric(m)
    }else if(mo <= mo.col){
        wrk <- x[2:mo, (mo.col - mo + 2):mo.col, drop = FALSE]
        u <- x[1, (mo.col - mo + 2):mo.col]

        res <- numeric(m)
        res[1:(mo-1)] <- qr.solve(t(wrk), u, tol = 1e-10) # 22/03/2007: solve(t(wrk),u)
        for(j in mo:mo.col){
            res[j] <- x[1, j - mo + 1]
            for(i in 1:(mo - 1)){
                res[j] <- res[j] - res[i] * x[i+1, j - mo + 1]
            }
        }
    }else if(mo.col < mo){
        wrk <- x[2:(mo.col + 1), 1:mo.col, drop = FALSE]
        u <- x[1, 1:mo.col]
        res <- numeric(m)
                                    # 2013-12-03 todo: the case when wrk is 1x1 and mo.col = 1
        res[1:mo.col] <- qr.solve(t(wrk), u, tol = 1e-10)  # solve(t(wrk),u)
    }

    res
}

mc_factorize <- function(x,mo,mo.col){                     # 2013--03-26 streamlining somewhat
    res <- mc_matrix(x)       # 2013-03-26 as.matrix(x)
    if(missing(mo.col))                     # 2013-03-26 flag <- missing(mo.col)
        mo.col <- ncol(res)
    for(i in 1:mo){
        res[i, ] <- mc_leftc(x[i:mo, , drop = FALSE], mo.col = mo.col)
    }
    res[1:mo, , drop = FALSE]    # 2014-10-20 was: res[1:mo,]
}


mc_from_factors <- function(x){        # this should not use MultiCompanion objects!
    mo <- if(is.vector(x))
              1
          else
              nrow(x)

    if(mo == 1){
        res <- mCompanion(x)
    }else{
        res <- mCompanion(x[1, ])               # this is lazy, can be done more economically.
        for(i in 2:mo)
            res <- res %*% mCompanion(x[i, ])
    }
    res[1:mo, ]                              # returns the top of the multi-companion matrix
}      # todo: (2014-10-20) do we need drop = FALSE here? Probably yes but for the functions
       #                    that use this one it probably doesn't matter.

                                            #   end: companion factorization of MultiCompanion

mc_from_filter <- function(x){     # rows v obraten red ponezhe i-tiyat red saotvestva
                                   # na i-tiya sezon, a faktorite se umnozhavat v obraten red.
                                         # rezultatat e Ftop, kakto pri mc_from_factors.
                   # 2015-02-11 - dobavyam proverka za nrow(x) > ncol(x)
    if(nrow(x) > ncol(x))
        x <- cbind(x, matrix(0, nrow = nrow(x), ncol = nrow(x) - ncol(x)))

    mc_from_factors(x[nrow(x):1, ])
}

make_mcev <- function(eigval, co, dim, what.co = "bottom"){
    n <- dim
    k <- length(co)
    res <- numeric(n)

    if(what.co == "bottom"){
        res[(n - k + 1):n] <- co
        if(k < n) # 4/4/2007
            for(i in (n - k):1){
                res[i] <- eigval * res[i + k]
            }
    }else{  # "top"                  but if eigval=0 then only the bottom is non-zero!
        res[1:k] <- co
        ## 4/4/2007 for(i in (k+1):n)
        if(k < n){
            if(eigval == 0) # 2014-06-03 here because if k=n "top" and "bottom" are equivalent
                stop("eigval must be different from 0 when what.co = 'top'")
            for(i in (k + 1):n){   # 4/4/2007
                res[i] <- res[i - k] / eigval          # eigval must be different from 0 here!
            }
        }
    }
    res
}

make_mcgev <- function(eigval, co, v, what.co = "bottom"){
    n <- length(v)
    k <- length(co)
    res <- numeric(n)

    if(what.co == "bottom"){
        res[(n - k + 1):n] <- co
        if(k < n) # 4/4/2007
            for(i in (n - k):1){
                res[i] <- eigval * res[i + k] + v[i + k]
            }
    }else{  # "top"                 note: if eigval=0 then only the bottom is non-zero!
        res[1:k] <- co
        if(k<n){ # 4/4/2007
            if(eigval == 0) # 2104-06-03 here because if k=n "top" and "bottom" are equivalent
                stop("eigval must be different from 0 when what.co = 'top'")
            for(i in (k + 1):n){
                res[i] <- (res[i - k] - v[i]) / eigval
            }
        }
    }
    res
}

## formerly mC.stable
mcStable <- function(x){           # x is a full matrix or the top of a multi-companion matrix
    x <- mc_full(x)
    wrk <- eigen(x, only.values = TRUE)
    all(abs(wrk$values) < 1)
}

setGeneric("mcStable")
