
test_that("MultiCompanion initialisation works properly", {
    a1 <- matrix(1:12, nrow = 2)
   
    mc1 <- new("MultiCompanion", xtop = a1)
    ## new("MultiCompanion",a1)   # same
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


    t(mc1)
    mc1 %*% t(a1)
    a1 %*% mc1
    mc1 %*% 1:6
    1:6 %*% mc1
# 
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
