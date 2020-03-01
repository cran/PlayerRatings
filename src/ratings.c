#include <R.h>
#include <Rmath.h>

void elo_c(int *np, int *nr, int *white, int *black, double *score, 
  double *crats, double *gamma, double *dscore);

void elom_c(int *np, int *nr, int *nn, int *player, double *score, 
            double *crats, double *dscore);

void glicko_c(int *np, int *nr, int *white, int *black, double *score, 
  double *crats, double *gdevs, double *gamma, double *dscore);
  
void glicko2_c(int *np, int *nr, int *white, int *black, double *score, 
              double *crats, double *gdevs, double *gamma, double *dscore);

void stephenson_c(int *np, int *nr, int *white, int *black, double *score, 
  double *crats, double *gdevs, double *gamma, double *bval, double *dscore);

void elo_c(int *np, int *nr, int *white, int *black, double *score, 
  double *crats, double *gamma, double *dscore)
{
  double *escore;
  double *ascore;
  int k;

  escore = (double *)R_alloc(*np, sizeof(double));
  ascore = (double *)R_alloc(*np, sizeof(double));

  for(k=0;k<*np;k++) {  
    escore[k] = 0;
    ascore[k] = 0;
  }  

  for(k=0;k<*nr;k++) {
    ascore[white[k]] = ascore[white[k]] + score[k];
    escore[white[k]] = escore[white[k]] + 
      1/(1 + R_pow(10,(crats[black[k]] - crats[white[k]] - gamma[k])/400));
    ascore[black[k]] = ascore[black[k]] + 1 - score[k];
    escore[black[k]] = escore[black[k]] + 
      1/(1 + R_pow(10,(crats[white[k]] - crats[black[k]] + gamma[k])/400)); 
  }
  for(k=0;k<*np;k++) dscore[k] = ascore[k] - escore[k];
}

void elom_c(int *np, int *nr, int *nn, int *player, double *score, 
           double *crats, double *dscore)
{
  double *escore;
  double *ascore;
  double avetab;
  int k,p,ntp;
  
  escore = (double *)R_alloc(*np, sizeof(double));
  ascore = (double *)R_alloc(*np, sizeof(double));
  
  for(k=0;k<*np;k++) {  
    escore[k] = 0;
    ascore[k] = 0;
  }  
  
  for(k=0;k<*nr;k++) {
    avetab = 0;
    ntp = 0;
    for(p=0;p<*nn;p++) {
      if(player[*nn*k+p] != -1) {
        avetab = avetab + crats[player[*nn*k+p]];
        ntp++;
      }
    }
    avetab = avetab / ntp;
    for(p=0;p<*nn;p++) {
      if(player[*nn*k+p] != -1) {
        ascore[player[*nn*k+p]] = ascore[player[*nn*k+p]] + score[*nn*k+p];
        escore[player[*nn*k+p]] = escore[player[*nn*k+p]] + 
          (crats[player[*nn*k+p]] - avetab)/40;
      }
    }
  }
    
  for(k=0;k<*np;k++) dscore[k] = ascore[k] - escore[k];
}

void glicko_c(int *np, int *nr, int *white, int *black, double *score, 
  double *crats, double *gdevs, double *gamma, double *dscore)
{

  double *escore;
  double *ascore;
  double *dval;
  double escorek;
  double qv2 = R_pow(M_LN10/400, 2);
  int k;

  escore = (double *)R_alloc(*np, sizeof(double));
  ascore = (double *)R_alloc(*np, sizeof(double));
  dval = (double *)R_alloc(*np, sizeof(double));

  for(k=0;k<*np;k++) {  
    escore[k] = 0;
    ascore[k] = 0;
    dval[k] = 0;
  }  


  for(k=0;k<*nr;k++) {
    ascore[white[k]] = ascore[white[k]] + score[k];
    escorek = 1/(1 + R_pow(10,(gdevs[black[k]] * (crats[black[k]] - crats[white[k]] - gamma[k]))/400));
    escore[white[k]] = escore[white[k]] + escorek;
    dval[white[k]] = dval[white[k]] + qv2 * R_pow(gdevs[black[k]],2) * escorek * (1-escorek);
    dscore[white[k]] = dscore[white[k]] + gdevs[black[k]] * (score[k] - escorek);

    ascore[black[k]] = ascore[black[k]] + 1 - score[k];
    escorek = 1/(1 + R_pow(10,(gdevs[white[k]] * (crats[white[k]] - crats[black[k]] + gamma[k]))/400));
    escore[black[k]] = escore[black[k]] + escorek;
    dval[black[k]] = dval[black[k]] + qv2 * R_pow(gdevs[white[k]],2) * escorek * (1-escorek);
    dscore[black[k]] = dscore[black[k]] + gdevs[white[k]] * (1 - score[k] - escorek);
  }
  for(k=0;k<*np;k++) dscore[k + *np] = dval[k];
}

void glicko2_c(int *np, int *nr, int *white, int *black, double *score, 
              double *crats, double *gdevs, double *gamma, double *dscore)
{
  
  double *escore;
  double *ascore;
  double *dval;
  double escorek;
  int k;
  
  escore = (double *)R_alloc(*np, sizeof(double));
  ascore = (double *)R_alloc(*np, sizeof(double));
  dval = (double *)R_alloc(*np, sizeof(double));
  
  for(k=0;k<*np;k++) {  
    escore[k] = 0;
    ascore[k] = 0;
    dval[k] = 0;
  }  
  
  for(k=0;k<*nr;k++) {
    ascore[white[k]] = ascore[white[k]] + score[k];
    escorek = 1/(1 + exp(gdevs[black[k]] * (crats[black[k]] - crats[white[k]] - gamma[k])));
    escore[white[k]] = escore[white[k]] + escorek;
    dval[white[k]] = dval[white[k]] + R_pow(gdevs[black[k]],2) * escorek * (1-escorek);
    dscore[white[k]] = dscore[white[k]] + gdevs[black[k]] * (score[k] - escorek);
    
    ascore[black[k]] = ascore[black[k]] + 1 - score[k];
    escorek = 1/(1 + exp(gdevs[white[k]] * (crats[white[k]] - crats[black[k]] + gamma[k])));
    escore[black[k]] = escore[black[k]] + escorek;
    dval[black[k]] = dval[black[k]] + R_pow(gdevs[white[k]],2) * escorek * (1-escorek);
    dscore[black[k]] = dscore[black[k]] + gdevs[white[k]] * (1 - score[k] - escorek);
  }
  for(k=0;k<*np;k++) dscore[k + *np] = dval[k];
}

void stephenson_c(int *np, int *nr, int *white, int *black, double *score, 
  double *crats, double *gdevs, double *gamma, double *bval, double *dscore)
{

  double *escore;
  double *ascore;
  double *dval;
  double *l1t;
  double escorek, ascorek;
  double qv2 = R_pow(M_LN10/400, 2);
  int k;

  escore = (double *)R_alloc(*np, sizeof(double));
  ascore = (double *)R_alloc(*np, sizeof(double));
  dval = (double *)R_alloc(*np, sizeof(double));
  l1t = (double *)R_alloc(*np, sizeof(double));

  for(k=0;k<*np;k++) {  
    escore[k] = 0;
    ascore[k] = 0;
    dval[k] = 0;
    l1t[k] = 0;
  }  

  for(k=0;k<*nr;k++) {
    ascorek = score[k] + *bval;
    ascore[white[k]] = ascore[white[k]] + ascorek;
    escorek = 1/(1 + R_pow(10,(gdevs[black[k]] * (crats[black[k]] - crats[white[k]] - gamma[k]))/400));
    escore[white[k]] = escore[white[k]] + escorek;
    dval[white[k]] = dval[white[k]] + qv2 * R_pow(gdevs[black[k]],2) * escorek * (1-escorek);
    dscore[white[k]] = dscore[white[k]] + gdevs[black[k]] * (ascorek - escorek);
    l1t[white[k]] = l1t[white[k]] + crats[black[k]] - crats[white[k]];

    ascorek = 1 - score[k] + *bval;
    ascore[black[k]] = ascore[black[k]] + ascorek;
    escorek = 1/(1 + R_pow(10,(gdevs[white[k]] * (crats[white[k]] - crats[black[k]] + gamma[k]))/400));
    escore[black[k]] = escore[black[k]] + escorek;
    dval[black[k]] = dval[black[k]] + qv2 * R_pow(gdevs[white[k]],2) * escorek * (1-escorek);
    dscore[black[k]] = dscore[black[k]] + gdevs[white[k]] * (ascorek - escorek);
    l1t[black[k]] = l1t[black[k]] + crats[white[k]] - crats[black[k]];
  }
  for(k=0;k<*np;k++) {
    dscore[k + *np] = dval[k];
    dscore[k + 2 * *np] = l1t[k];
  }
}
