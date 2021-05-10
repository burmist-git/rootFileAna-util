//my
#include "TCana.hh"

//root
#include <TH2.h>
#include <TStyle.h>
#include <TCanvas.h>
#include <TString.h>
#include <TChain.h>
#include <TFile.h>
#include <TTree.h>
#include <TBranch.h>
#include <TGraph.h>
#include <TH1D.h>
#include <TH2D.h>
#include <TProfile.h>
#include <TRandom3.h>

//C, C++
#include <iostream>
#include <stdlib.h>
#include <assert.h>
#include <fstream>
#include <iomanip>
#include <time.h>
#include <bits/stdc++.h>

using namespace std;

void TCana::Loop(TString histOut){
  Int_t i = 0;
  TRandom3 *rnd = new TRandom3();
  TH1D *h1_dummyHisto = new TH1D("h1_dummyHisto","dummyHisto",100,0.0,100);
  TGraph *gr_dummyGraph[nChannels];
  tGraphInit(gr_dummyGraph, "gr_dummyGraph", "dummyGraph");
  TH1D *h1_dummyHistoArr[nChannels];
  h1D1Init(h1_dummyHistoArr,"h1_dummyHistoArr","h1_dummyHistoArr",100,-10.0,10);
  TH2D *h2_dummyHistoArr[nChannels];
  h2D2Init(h2_dummyHistoArr,"h2_dummyHistoArr", "dummyHistoArr", 100, -10.0, 10.0, 100, -10.0, 10.0);
  TProfile *pr_dummyArr[nChannels];
  tProfInit(pr_dummyArr,"pr_dummyArr", "dummyArr", 100, 0.0, 10.0);
  Long64_t nentries = fChain->GetEntriesFast();
  cout<<"nentries = "<<nentries<<endl;
  Long64_t nbytes = 0, nb = 0;
  for (Long64_t jentry=0; jentry<nentries;jentry++) {
    Long64_t ientry = LoadTree(jentry);
    if (ientry < 0) break;
    nb = fChain->GetEntry(jentry);   nbytes += nb;
    h1_dummyHisto->Fill(1);
    for(i = 0;i<nChannels;i++){
      gr_dummyGraph[i]->SetPoint(gr_dummyGraph[i]->GetN(), gr_dummyGraph[i]->GetN(), rnd->Gaus(0.0,1.0));
      h1_dummyHistoArr[i]->Fill(rnd->Gaus(0.0,1.0));
      h2_dummyHistoArr[i]->Fill(rnd->Gaus(0.0,1.0),rnd->Gaus(0.0,1.0));
      pr_dummyArr[i]->Fill(rnd->Uniform(0.0,10.0),rnd->Gaus(1.0,1.0));
    }
  }
  TFile* rootFile = new TFile(histOut.Data(), "RECREATE", " Histograms", 1);
  rootFile->cd();
  if (rootFile->IsZombie()){
    cout<<"  ERROR ---> file "<<histOut.Data()<<" is zombi"<<endl;
    assert(0);
  }
  else
    cout<<"  Output Histos file ---> "<<histOut.Data()<<endl;
  for(i = 0;i<nChannels;i++){
    gr_dummyGraph[i]->Write();
    h1_dummyHistoArr[i]->Write();
    h2_dummyHistoArr[i]->Write();
    pr_dummyArr[i]->Write();
  }
  h1_dummyHisto->Write();
  rootFile->Close();
}
