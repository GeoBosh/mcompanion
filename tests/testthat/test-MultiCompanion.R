
test_that("MultiCompanion initialisation works properly", {
    a1 <- matrix(1:12, nrow = 2)
   
    mc1 <- new("MultiCompanion", xtop = a1)
    ## new("MultiCompanion",a1)   # same
    dim(mc1) # 6 x 6
    nrow(mc1)
    ncol(mc1)
    
    ## subscripting
    mc1[]    
    mc1[ , 1:4]    
    mc1[1:2, ]    
    mc1[1:2, 1:4]    

    mc1[1:2, 1:2]    

    mc1[1, 1:4]
    mc1[1, ]
    mc1[ , 1]

    mc1[1:6, ]
    mc1[ , 1:6]

    ## arithmetic, result is Matrix but not MultiCompanion
    MnotMC <- function(x) {
        inherits(x, "Matrix") && !inherits(x, "MultiCompanion")
    }
    
    a6x6 <- matrix(1:36, nrow = 6)
    
    expect_true(MnotMC(mc1 + a6x6))
    expect_true(MnotMC(mc1 - a6x6))
    expect_true(MnotMC(mc1 * a6x6))
    expect_true(MnotMC(mc1 / a6x6))

    expect_true(MnotMC(a6x6 + mc1))
    expect_true(MnotMC(a6x6 - mc1))
    expect_true(MnotMC(a6x6 * mc1))
    expect_true(MnotMC(a6x6 / mc1))

    
    expect_true(MnotMC(mc1 + 3))
    expect_true(MnotMC(mc1 - 3))
    expect_true(MnotMC(mc1 * 3))
    expect_true(MnotMC(mc1 / 3))

    expect_true(MnotMC(3 + mc1))
    expect_true(MnotMC(3 - mc1))
    expect_true(MnotMC(3 * mc1))
    expect_true(MnotMC(3 / mc1))

    
    expect_true(MnotMC(mc1 + 3L))
    expect_true(MnotMC(mc1 - 3L))
    expect_true(MnotMC(mc1 * 3L))
    expect_true(MnotMC(mc1 / 3L))

    expect_true(MnotMC(3L + mc1))
    expect_true(MnotMC(3L - mc1))
    expect_true(MnotMC(3L * mc1))
    expect_true(MnotMC(3L / mc1))

    
    expect_true(MnotMC(mc1 + TRUE))
    expect_true(MnotMC(mc1 - TRUE))
    expect_true(MnotMC(mc1 * TRUE))
    expect_true(MnotMC(mc1 / TRUE))

    expect_true(MnotMC(TRUE + mc1))
    expect_true(MnotMC(TRUE - mc1))
    expect_true(MnotMC(TRUE * mc1))
    expect_true(MnotMC(TRUE / mc1))


    mnotMC <- function(x) {
        inherits(x, "matrix") && !inherits(x, "MultiCompanion")
    }
    mcompl <- matrix(1+1i, 6, 6)

    ## TODO: for this to work need to adjust the "matrix" methods for 'Ops',
    ##       as 'Matrix' doesn't have this yet.
    ##
    ## expect_true(mnotMC(mc1 + mcompl))
    ## expect_true(mnotMC(mc1 - mcompl))
    ## expect_true(mnotMC(mc1 * mcompl))
    ## expect_true(mnotMC(mc1 / mcompl))
    ## 
    ## expect_true(mnotMC(mcompl + mc1))
    ## expect_true(mnotMC(mcompl - mc1))
    ## expect_true(mnotMC(mcompl * mc1))
    ## expect_true(mnotMC(mcompl / mc1))

    ## these are catched by the 'complex' methods
    expect_true(mnotMC(mc1 + (1+1i)))
    expect_true(mnotMC(mc1 - (1+1i)))
    expect_true(mnotMC(mc1 * (1+1i)))
    expect_true(mnotMC(mc1 / (1+1i)))

    expect_true(mnotMC((1+1i) + mc1))
    expect_true(mnotMC((1+1i) - mc1))
    expect_true(mnotMC((1+1i) * mc1))
    expect_true(mnotMC((1+1i) / mc1))

    ## mc op mc
    mc1 + mc1
    

    ## mc op Matrix (but not mc)
    mc1 * mc2Matrix(mc1)
    mc2Matrix(mc1) * mc1

    Matrix(diag(3, 6, 6)) + mc1
    Matrix(diag(3, 6, 6)) - mc1
    Matrix(diag(3, 6, 6)) * mc1
    Matrix(diag(3, 6, 6)) / mc1

    mc1 + Matrix(diag(3, 6, 6))
    mc1 - Matrix(diag(3, 6, 6))
    mc1 * Matrix(diag(3, 6, 6))
    mc1 / Matrix(diag(3, 6, 6))

    ## these go to the 'vector' methods 
    expect_error(mc1 + "1")
    expect_error("1" - mc1)

    expect_true(MnotMC(mc1 + as(mc1, "Matrix")))

    exp(mc1)

    ## Math2
    round(mc1 + pi)
    round(mc1 + pi, 2)

    ## Summary
    max(mc1)
    min(mc1)
    range(mc1)
    prod(mc1)
    sum(mc1)
    any(mc1 > 0)
    all(mc1 > 0)
    ## with more than 1 argument
    max(mc1, 200)
    min(mc1, -100)
    range(mc1, -100)
    prod(mc1, 10)
    sum(mc1, 10)


    expect_true(class(mc1 %*% mc1) == "MultiCompanion")

    ## these currently give a subclass of 'Matrix'
    t(mc1)
    mc1 %*% t(a1)
    a1 %*% mc1
    mc1 %*% 1:6
    1:6 %*% mc1

    diag(mc1)
    expect_equal(diag(mc1), diag(as(mc1, "matrix")))

    mc1b <- mc1a <- mc1
    diag(mc1a) <- c(20, 20, rep(0,4)) # result is MultiCompanion
    diag(mc1b) <- rep(40, 6)          # ok, but result no longer MultiCompanion
    expect_error(diag(mc1a) <- c(30, 30)) # wrong length of value

 
# a2 <- matrix(c(1:6,rep(0,4)),nrow=2)   # 1st 3 columns of a2 are non-zero
# mc2 <- new("MultiCompanion",a2)
# mc2
# mc2@mo.col     # =5, because the default is to set mo.col to ncol
# 
# mc2a <- new("MultiCompanion",a2,detect="mo.col")
# mc2a@mo.col   # =3, compare with above
# 
# b <- as(mc2,"matrix")  # b is ordinary R matrix
# mcb <- new("MultiCompanion",x=b)
#        new("MultiCompanion",b)   # same as mcb
# 
# mcb@mo        # 2 (mo detected)
# mcb@mo.col    # 5 (no attempt to detect mo.col)
# 
# mcba <- new("MultiCompanion",b,detect="all")
# mcba@mo        # 2 (mo detected)
# mcba@mo.col    # 3 (mo.col detected)

    ## example from mc_factors.Rd
    m <- mCompanion(matrix(1:8, nrow = 2))
    mc_factors(m)

    ## 2020-03-21: some old testing examples from pcts (when mcompanion was part of pcts)
    ##
    ## parameters from 'm1_m2_phi_theta_new2.R'
    ## see pcts/Org/rds/param_old_RData.rds for the full precision param
    param <- c(1.0000000, 0.1049724, 0.4972376, 0.4972376)
    m1 <- rbind(c(1, 0, 0), c(1, param[3:4]))
    m2 <- rbind(c(1, 0, 0), c(1, 0, 0))
    testphi <- lagged::slMatrix(init = m1)
    testtheta <- lagged::slMatrix(init = m2)
    
    mCompanion(m1[ , -1])
    mCompanion(m1[ , -1], mo.col = 2)
    mCompanion(m1[ , -1][2:1], mo.col = 2)
    mCompanion(m1[ , -1][ , 2:1])
    mCompanion(m1[ , -1][2:1, ])
    
    mc_from_factors(m1[ , -1][2:1, ])
    mc_from_filter(m1[ , -1])
    
    eigen(mCompanion(m1[ , -1][2:1], mo.col = 2))
    eigen(mc_from_filter(m1[ , -1]))
})
