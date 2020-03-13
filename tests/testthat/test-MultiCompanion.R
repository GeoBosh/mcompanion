
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

    
})
