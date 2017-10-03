#include <Rcpp.h>

extern "C" {
#include <liblwgeom.h>
}

// [[Rcpp::export]]
std::string get_lwgeom_version() 
{
  return std::string(lwgeom_version());
}

