// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// rpi_spi_WriteAndRead
int rpi_spi_WriteAndRead(int mystuff, char morestuff);
RcppExport SEXP _rpigpior_rpi_spi_WriteAndRead(SEXP mystuffSEXP, SEXP morestuffSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type mystuff(mystuffSEXP);
    Rcpp::traits::input_parameter< char >::type morestuff(morestuffSEXP);
    rcpp_result_gen = Rcpp::wrap(rpi_spi_WriteAndRead(mystuff, morestuff));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_rpigpior_rpi_spi_WriteAndRead", (DL_FUNC) &_rpigpior_rpi_spi_WriteAndRead, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_rpigpior(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
