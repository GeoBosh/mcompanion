# Version 0.5.8 (CRAN)

- added a couple of methods for`%*% to avoid some methods for "MultiCompanion" 
  being masked in the forthcoming v1.6-2 of Matrix.


# Version 0.5.7 (CRAN)

- fixed a CRAN error in a test that was checking unwisely the exact text of a
  warning from `chol` about rank defficiency. That text changed recently,
  causing test error from the package on CRAN.


# Version 0.5.6 (CRAN)

- added `[` methods for class "MultiCompanion" with `drop = missing` for v1.5.5
  of Matrix.


# Version 0.5.5 (CRAN)

- require Matrix (>= 1.5-0) to avoid problems for users who have an earlier
  version of Matrix on their device. This may not be really needed for
  `mcompanion` but packages that require it do.

- added further tests.

- add `lagged` to `Suggests` as it is used in some tests.

- fixed `doi` links to use `\doi`.

- now all references use Rd macros (references inserted before the introduction
  of Rd macros were still using the old mechanism).

- use Github actions, drop travisCI.


# Version 0.5-3 (CRAN)

- building the pdf manual was failing on R old release (3.5.2 and 3.5.3).
  Fixed by building the package under R-3.5.2.


# Version 0.5-2 (CRAN)

- remove description of unused argument "..." in "./man/mf_VSform.Rd".


# Version 0.5-1 (CRAN)

- Built it under R-3.5.2 to avoid installation error on R old release (3.5.2 and
  3.5.3).


# Version 0.5-0 (CRAN)

- `null_complement` now treats a numeric `m` as a matrix with one column in all
  cases.

- removed a volatile test causing "Additional issues" on CRAN.

- removed `sim_mcseeds()`, it had been superceded by `sim_chains()` for some
  time.

- doi for Boshnakov (2002) was pointing erroneously to Boshnakov (2007).

- numerous small code fixes and documentation edits.


# Version 0.4-5 (CRAN)

- another tunning of DESCRIPTION.

- first CRAN version


# Version 0.4-4

- added examples to user facing functions/classes which didn't have them.

- added references in DESCRIPTION per the CRAN team request.

- some documentation clean-up.


# Version 0.4-1

- moved 'methods' and 'Matrix' from Depends: to Imports:.

- created Org directory; now some files are generated from org sources.  Names
  of R files generated from Org sources start with "auto_" to distinguish from
  the rest.


# Version 0.3-3

- renamed `mc.0chain.transf()` to `reduce_chains_simple()` - the name was
  misleading since the algorithm is valid for any eigenvalues and is not
  specific to mc-matrices.

- renamed `mc.0chain.triang()` to `mc_chains_triangulate()` - works for any
  eigenvalue, not only zero.

- other renaming.


# Version 0.3-2

- completed (almost?) the handling of 0chains.

- new function `Jordan_submatrix`.

- renamed `smc2co` to `smc_chains`.

- `chains_to_list` converts a similarity matrix to list of chains.
  (`mc_chain_to_list` still exists but is not mc specific and will be removed).

- Streamlining and bug fixes of code for 0chains, non0 chains and related
  functions.  Some arguments were removed. The low level functions dealing with
  individual mc-chains should not consider the case `mo.col < mo` - it should be
  dealt with at the level of functions dealing with all (or a number of
  chains). The work on this is not finished yet.


# Version 0.3-1

- now generation of mc-matrices covers all cases involving zero eigenvalues.

- introduced class SmallMultiCompanion for complete treatment of the case
  `mo < mo.col`.

- additional clean-up.


# Version 0.3-0

- wholesale renaming and clean-up.


# Version 0.2-11

- Further consolidated function names, moved a view of the old functions to
  package obsmcompanion in case someone needs to run old code.


# Version 0.2-10

- defined S3 method for `as.matrix`, `as.matrix.MultiCompanion`, for contexts
  where `as()` doesn't see the S4 method.

- defined explicit methods for matrix multiplication of "MultiCompanion" and
  "matrix". For some reason an error started to popup (change in package methods
  or Matrix?).


# Version 0.2-9

- `var2mf` was still buggy. Changed the return value to be more consistent.

- `var2mf` now has an argument, "perm", for specifications of the order of the
  variables when treating them as seasons.



# Version 0.2-8

- corrected a bug in `mcSpec`.

- `mCfromfilter` now works also when the order of the filter is smaller than the
  periodicity.

- bugfix: `mfVSform` gave wrong value for `Phi0inv` when `form = "I"`.


# Version 0.2-7

- improved `mc_ev` and the subspace parameters; now all tests from version 0.2-5
  are passed.


# Version 0.2-6

- `mc_ev` now works and is called by `mC.ss` from package pcts.
  Partial implementation of subspace parameters.


# Version 0.2-5

- added a keyword "internal" to a number of functions which are rarely used or
  essentially internal, so that their documentation does not appear in the pdf
  manual. The documentation is still there and can be viewed with the help
  command.

- continuing consolidaation from 0.2-4, renamed more functions the old names
  will be valid for some time.

- The index in mcompanion-package.Rd now lists only selected functions and does
  this by topic (needs clean up though).

- `mc.0chain.structObsolete` is now obsolete.

- introduced `mcev_core()`, seems to work but will be developed further and is
  not used elsewhere yet.


# Version 0.2-4

- moved `sim_real` and similar to gbutils.

- renamed a number of functions, hopefully with more user friendly names; the
  old names will be valid for some time.


# Version 0.2-2

- `mC.gen.evecs` gets new argument `mo.col`, the code adapted to handle it
  properly.

- renamed and rewrote `mc.chain.transf` to `mc.chain.scale`.


# Version 0.2-1

- `mC.gen.evec` and `mC.gen.gevec` now give error when `what.co = "top"` for a
  zero eigenvalue

- the functions for Jordan chains corresponding to zero eigenvalues were
  debugged and somewhat cleaned up.

- new slots for `mcSpec` - `mc.col` and `F0bot`.


# Version 0.2-0

- updated `rblockmult()` to work with non-square second argument.

- rename `mC.sim.r` to `sim_real`; `mC.sim.c` to `sim_complex`; `mCsim.eigval`
  to `sim_numbers`.

- bug fixes and improvements to `mcSpec`.

- renamed `mc0chains.struct` to `mc.0chain.struct`, `mCchain.struct0` to
  `mc.0chain.structObsolete`, `mCchain.triang0` to `mc.0chain.triang`.

- other changes.


# Version 0.1-31

- Import "gbutils" instead of "pad" (the latter is now part of gbutils).

- Small corrections to the documentation files.
