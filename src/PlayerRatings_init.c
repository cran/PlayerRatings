#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

extern void elo_c(void *, void *, void *, void *, void *, void *, void *, void *);
extern void elom_c(void *, void *, void *, void *, void *, void *, void *);
extern void glicko_c(void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void glicko2_c(void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void stephenson_c(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);

static const R_CMethodDef CEntries[] = {
    {"elo_c",  (DL_FUNC) &elo_c,  8},
    {"elom_c",  (DL_FUNC) &elom_c,  7},
    {"glicko_c", (DL_FUNC) &glicko_c, 9},
    {"glicko2_c", (DL_FUNC) &glicko2_c, 9},
    {"stephenson_c",  (DL_FUNC) &stephenson_c,  10},
    {NULL, NULL, 0}
};

void R_init_PlayerRatings(DllInfo *dll)
{
    R_registerRoutines(dll, CEntries, NULL, NULL, NULL);
    R_useDynamicSymbols(dll, TRUE);
}
