test_that("sim_XXX is ok",
{
    set.seed(1234)
    m0 <- sim_mc(3, 2)   # simulate 3x3 2-companion matrix
    ## this is an error (notice  " cp", should be "cp"); TODO: catch and give informative message
    ## m1 <- sim_mc(3, 2, eigabs = c(0.25, 0.5), type.eigval = c("r", " cp"))
    m1 <- sim_mc(3, 2, eigabs = c(0.25, 0.5), type.eigval = c("r", "cp"))
    ## compatibility, in older version eigval could also define type.eigval
    ##     TODO: maybe remove the compatibility code from the sources and this test?
    sim_mc(3, 2, eigabs = c(0.25, 0.5), eigval = c("r", "cp"))
    
    m2 <- sim_mc(6, 4, eigsign = pi * c(1/2, 1, -1/2))

    sim_mc(3, 2, value.type = "matrix")
    sim_mc(3, 2, value.type = "list")
    sim_mc(3, 2, eigval = c(0.25, 0.5, 0.75))

    sim_pcfilter(2, 3)
    sim_pcfilter(2, order = 3)
    expect_error(sim_pcfilter(2))

    ## examples from mc_eigen.Rd
    
x <- sim_mc(6,4,mo.col=2)
x
y <- mCompanion(x,detect="gen")
y
z <- as.matrix(y)
xx <- mCompanion(x=z,mo.col=2)
mc_eigen(xx)


    ## examples from VAR2pcfilter.Rd
    
## create a pc filter
rfi <- sim_pcfilter(2,3)
rfi$pcfilter

## turn it into VAR form
flt <- new("MultiFilter", coef = rfi$pcfilter)
I1 <- mf_VSform(flt, form="I")

## from VAR to scalar form
flt2 <- VAR2pcfilter(I1$Phi, Sigma = I1$Phi0inv %*% t(I1$Phi0inv))

## confirm that we are back to the original
##   (VAR2pcfilter doesn't drop redundant zeroes, so we do it manually)
all.equal(flt2[ , 1:3], rfi$pcfilter) ## TRUE

    ## more examples
    flt[ , 1:3, lag0 = TRUE]
    
    flt[ , 1:2, form = "vs"]
    flt[ , 1:2, form = "v"]
    mf_VSform(flt)
    mf_VSform(flt, form = "I")


    ## examples from mf_VSform
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
    mf_order(flt, form = "U")
    mf_order(flt, i = 1, form = "U")

    mf_order(flt, form = "L")
    mf_order(flt, i = 1, form = "L")
    
mf_order(flt, i = 1)
mf_order(flt, i = "all")
mf_order(flt, i = "all", form  = "L")

    mf_poles(flt)
mf_poles(flt, blocks = TRUE)
abs(mf_poles(flt))
    mcStable(flt)
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

    ## more examples
    mf_order(flt)    
mf_order(flt, form = "L")    
mf_VSform(flt, form="U", perm = 2:1)
    ## TODO: this gives error, looks like a bug:
    ## VAR2pcfilter(I1$Phi, Sigma = I1$Phi0inv %*% t(I1$Phi0inv), perm = 2:1)
    VAR2pcfilter(I1$Phi, Sigma = I1$Phi0inv %*% t(I1$Phi0inv), what = "coef.and.var")
    VAR2pcfilter(I1$Phi, Sigma = I1$Phi0inv %*% t(I1$Phi0inv), what = "")
    expect_error(VAR2pcfilter(I1$Phi), "One of Sigma, Phi0, Phi0inv must be specified")
    expect_error(VAR2pcfilter(I1$Phi, Phi0 = I1$Phi0), "argument.*is missing, with no default")

})








