// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// rpi_ioctl
Rcpp::List rpi_ioctl(int spiDeviceID, Rcpp::String ioctlRequest, Rcpp::List spiControl);
RcppExport SEXP _rpigpior_rpi_ioctl(SEXP spiDeviceIDSEXP, SEXP ioctlRequestSEXP, SEXP spiControlSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type spiDeviceID(spiDeviceIDSEXP);
    Rcpp::traits::input_parameter< Rcpp::String >::type ioctlRequest(ioctlRequestSEXP);
    Rcpp::traits::input_parameter< Rcpp::List >::type spiControl(spiControlSEXP);
    rcpp_result_gen = Rcpp::wrap(rpi_ioctl(spiDeviceID, ioctlRequest, spiControl));
    return rcpp_result_gen;
END_RCPP
}
// rpi_spi_read
Rcpp::NumericVector rpi_spi_read();
RcppExport SEXP _rpigpior_rpi_spi_read() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(rpi_spi_read());
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_rpigpior_rpi_ioctl", (DL_FUNC) &_rpigpior_rpi_ioctl, 3},
    {"_rpigpior_rpi_spi_read", (DL_FUNC) &_rpigpior_rpi_spi_read, 0},
    {NULL, NULL, 0}
};

RcppExport void R_init_rpigpior(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
