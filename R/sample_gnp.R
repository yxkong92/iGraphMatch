#' @title Sample correlated G(n,p) random graphs
#'
#' @description Sample a pair of correlated G(n,p) random graphs with correlation between
#' two graphs being \code{rho} and edge probability being \code{p}.
#'
#' @param n An integer. Number of total vertices for the sampled graphs.
#' @param corr A number. The target Pearson correlation between the adjacency matrices
#' of the generated graphs. It must be in open (0,1) interval.
#' @param p A number. Edge probability between two vertices. It must be in open
#' (0,1) interval.
#' @param ncore An integer. Number of core vertices.
#' @param directed A logical. Whether to generate directed graphs.
#' @param permutation A vector of number. A permutation vector that is applied on the
#' vertices of the first graph, to get the second graph. If \code{NULL}, the vertices
#' are not permuted.
#'
#' @rdname sample_gnp
#' @return \code{sample_correlated_gnp_pair} returns a list of two igraph object, named
#' \code{graph1} and \code{graph2}, which are two graphs whose adjacency matrix entries
#' correlated with \code{rho}.
#' @examples
#' sample_correlated_gnp_pair(50, 0.3, 0.5)
#' @export
#'
sample_correlated_gnp_pair <- function (n, corr, p, directed = FALSE, permutation = NULL)
{
  igraph::sample_correlated_gnp_pair(n,corr,p,directed,permutation)
}
#' @export
#' @rdname sample_gnp
#' @return \code{sample_correlated_gnp_pair_w_junk} returns a list of two igraph object, named
#' \code{graph1} and \code{graph2}, which are two graphs whose adjacency matrix entries
#' correlated with \code{rho} and with first ncore vertices being core vertices and the rest being
#' junk vertices.
#' @examples
#' sample_correlated_gnp_pair_w_junk(50, 0.3, 0.5, 40)
#'
#'
sample_correlated_gnp_pair_w_junk <- function(n, corr, p, ncore=n){
  core <- 1:ncore
  junk <- (ncore+1):n

  cgnp_pair <- sample_correlated_gnp_pair(ncore,corr,p)

  if(ncore != n){
    pref_junk <- matrix(c(0,p,p,p),2,2)
    A <- sample_sbm(n,pref_junk,c(ncore,n-ncore))
    B <- sample_sbm(n,pref_junk,c(ncore,n-ncore))

    cgnp_pair <- with(cgnp_pair,{
      list(graph1=A %u% graph1,graph2=B %u% graph2)
    })
  }
  cgnp_pair
}


