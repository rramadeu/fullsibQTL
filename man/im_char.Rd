% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/im_char.R
\name{im_char}
\alias{im_char}
\title{QTL characterization using Interval Mapping}
\usage{
im_char(
  fullsib,
  pheno.col = 1,
  addcovar = NULL,
  lg,
  pos,
  maxit = 1000,
  tol = 1e-10,
  verbose = FALSE
)
}
\arguments{
\item{fullsib}{An object from class \emph{fullsib}.}

\item{pheno.col}{Column number in the phenotype matrix (present in
\emph{fullsib} object) which should be used as the phenotype.}

\item{addcovar}{Additive covariates. If it is used, one must indicate the
design matrix for those source of variation. It should be noted that
additive covariates is included in the model as fixed effects, under
ordinary linear regression.}

\item{lg}{Indicates which linkage group contains the region to be
characterized.}

\item{pos}{String representing the name of the locus that will be studied.
This name is found as the row label for the matrix returned by
\code{cim_scan}.}

\item{maxit}{Maximum number of iteration in EM algorithm.}

\item{tol}{Tolerance for determining convergence in EM algorithm. See
details.}

\item{verbose}{If \code{TRUE} display information during EM algorithm. It
indicates the iteration of EM is performing, with log-likelihood,
convergence, genetics effects, square root of variance. The log-likelihood
of the model under \eqn{H_0} model is also showed.}
}
\value{
An object of class \emph{fullsib_char} is returned, consisting in a
matrix of one column and 15 rows. The information provided are for each row
are: linkage group that was analysed, position (cM),
\eqn{-\log_{10}(pvalue)}, LOD Score, model intercept (\code{mu}), QTL effect
for parent \eqn{P} (\code{alpha_p}) and its LOD Score (\code{LOD_H1}), QTL
effect for parent \eqn{Q} (\code{alpha_q}) and its LOD Score
(\code{LOD_H2}), dominance effect (\code{delta_pq} and its LOD Score
(\code{LOD_H3}). Additional tests are also performed to identify the
segregation pattern (\code{LOD_H4}, \code{LOD_H5} and \code{LOD_H6}). For
getting the segregation estimated \code{get_segr} function should be used.
The last row indicated the \code{model} used in the analysis. See
\pkg{fullsibQTL} Vignette for details.
}
\description{
Considering a detected QTL on a given position, this function allows to
estimate the genetic effects and also provides a series os estatistical test
allowing to infer QTL segregation patterns and its linkage phases with
flanking markers.
}
\details{
The method implemented in this package consists first to scan the genome for
a QTL (done with \code{im_scan}) and than on a second step, the QTL is
characterized (done with \code{im_char}).

In our model, QTL can segregate in one of four possible types: 1:1:1:1,
1:2:1, 3:1 or 1:1. The QTL segregation may vary as function of the number of
significative effects and their magnitude between each other. To understand
with details, check Gazaffi et al. (2014) and \pkg{fullsibQTL} Vignette. To
help the user with the understanding of mapped QTL, the function
\code{get_segr} and \code{draw_phase} were devolped to infer directly the
segregation pattern and the linkage phase between QTL and markers,
respectively.
}
\examples{
  data( "example_QTLfullsib" )

  fullsib <- create_fullsib( example_QTLfullsib,
                             list( LG1_final, LG2_final, LG3_final, LG4_final ),
                             step = 3, map.function = "kosambi", condIndex = 3.5)

  \dontrun{
  im1 <- im_scan( fullsib, pheno.col = 1 )
  summary( im1 )
  }

  qtl1 <- im_char( fullsib, pheno.col = 1, lg = 1, pos = "loc3" )
  qtl2 <- im_char( fullsib, pheno.col = 1, lg = 2, pos = "M27" )
  qtl3 <- im_char( fullsib, pheno.col = 1, lg = 3, pos = "loc63" )
  qtl4 <- im_char( fullsib, pheno.col = 1, lg = 4, pos = "loc57" )

  \dontrun{
  covar <- matrix( rep( c( 1, -1 ), each = 150 ), ncol = 1 )
  im2 <- im_scan( fullsib, pheno.col = 2, addcovar = covar )
  summary( im2 )

  qtl5 <- im_char( fullsib, pheno.col = 1, addcovar = covar, lg = 2, pos = "M27" )
  }

}
\references{
Gazaffi, R.; Margarido, G. R.; Pastina, M. M.; Mollinari, M.; Garcia, A. A.
F. (2014) A model for Quantitative Trait Loci Mapping, Linkage Phase, and
Segregation Pattern Estimation for a Full-Sib Progeny. \emph{Tree Genetics &
Genomes} 10(4): 791-801
}
\seealso{
\code{\link[fullsibQTL]{im_scan}}
\code{\link[fullsibQTL]{cim_char}}
\code{\link[fullsibQTL]{draw_phase}}
\code{\link[fullsibQTL]{get_segr}}
}
\author{
Rodrigo Gazaffi, \email{rgazaffi@gmail.com}
}
\keyword{utilities}
