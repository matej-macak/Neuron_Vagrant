#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;

extern void _ar_reg(void);
extern void _cad_reg(void);
extern void _caL3d_reg(void);
extern void _ca_reg(void);
extern void _CaT_reg(void);
extern void _HH2_reg(void);
extern void _h_reg(void);
extern void _inwardrect_reg(void);
extern void _kca_reg(void);
extern void _kir_reg(void);
extern void _km_reg(void);
extern void _kv_reg(void);
extern void _na_reg(void);
extern void _NMDA_Mg_T_reg(void);
extern void _release_BMK_reg(void);

void modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," ar.mod");
    fprintf(stderr," cad.mod");
    fprintf(stderr," caL3d.mod");
    fprintf(stderr," ca.mod");
    fprintf(stderr," CaT.mod");
    fprintf(stderr," HH2.mod");
    fprintf(stderr," h.mod");
    fprintf(stderr," inwardrect.mod");
    fprintf(stderr," kca.mod");
    fprintf(stderr," kir.mod");
    fprintf(stderr," km.mod");
    fprintf(stderr," kv.mod");
    fprintf(stderr," na.mod");
    fprintf(stderr," NMDA_Mg_T.mod");
    fprintf(stderr," release_BMK.mod");
    fprintf(stderr, "\n");
  }
  _ar_reg();
  _cad_reg();
  _caL3d_reg();
  _ca_reg();
  _CaT_reg();
  _HH2_reg();
  _h_reg();
  _inwardrect_reg();
  _kca_reg();
  _kir_reg();
  _km_reg();
  _kv_reg();
  _na_reg();
  _NMDA_Mg_T_reg();
  _release_BMK_reg();
}
