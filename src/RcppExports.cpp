// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// spiClose
int spiClose(int spiDeviceID);
RcppExport SEXP _rpigpior_spiClose(SEXP spiDeviceIDSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type spiDeviceID(spiDeviceIDSEXP);
    rcpp_result_gen = Rcpp::wrap(spiClose(spiDeviceID));
    return rcpp_result_gen;
END_RCPP
}
// rpi_spi_open
int rpi_spi_open(unsigned spiChan, unsigned spiBus, unsigned max_speed_hz);
RcppExport SEXP _rpigpior_rpi_spi_open(SEXP spiChanSEXP, SEXP spiBusSEXP, SEXP max_speed_hzSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< unsigned >::type spiChan(spiChanSEXP);
    Rcpp::traits::input_parameter< unsigned >::type spiBus(spiBusSEXP);
    Rcpp::traits::input_parameter< unsigned >::type max_speed_hz(max_speed_hzSEXP);
    rcpp_result_gen = Rcpp::wrap(rpi_spi_open(spiChan, spiBus, max_speed_hz));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_rpigpior_spiClose", (DL_FUNC) &_rpigpior_spiClose, 1},
    {"_rpigpior_rpi_spi_open", (DL_FUNC) &_rpigpior_rpi_spi_open, 3},
    {NULL, NULL, 0}
};

RcppExport void R_init_rpigpior(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
