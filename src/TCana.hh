#ifndef TCana_hh
#define TCana_hh

//My
#include "TCbase.hh"

//root
#include <TROOT.h>

class TChain;
class TFile;
class TTree;
class TString;
class TBranch;


class TCana: public TCbase {
public:
  TCana(TString fileList) : TCbase(fileList)
  {
  }

  TCana(TString file, Int_t key) : TCbase(file, key)
  {
  }

  void Loop(TString histOut);

};

#endif
