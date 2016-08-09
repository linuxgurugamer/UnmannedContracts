#!/bin/bash

ROOT=/d/Users/jbb

INSTALLDIR=$(ROOT)/install
MODDIR=GameData/ContractPacks/Spacetux/UnmannedContracts
OBJECTS=CHANGELOG-UnmannedContracts License-UnmannedContracts.txt UnmannedContracts.version coherentcontractsmod.cfg UnmannedContracts.dll group.cfg  UnmannedContracts.cfg group.cfg

AGENCY=spacetux

cd /d/Users/jbb/github/SpaceTux/GameData/Spacetux && make install

rm -fr $(INSTALLDIR)/$(MODDIR)/*
mkdir -p $(INSTALLDIR)/$(MODDIR)
cp $(OBJECTS) $(INSTALLDIR)/$(MODDIR)

