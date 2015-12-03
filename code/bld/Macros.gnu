LKFLAG = -O2 -o
LKFLAG = -fdefault-real-8 -g -o
FCPFLAG = -fdefault-real-8 -c -cpp

CCPFLAG = -c
CPPDEFS+=  -DCPRGNU -DHIDE_MPI -ffree-line-length-0
F90 = $(FCOMP) $(CPPDEFS)
NETCDF_PATH = /opt/local
NETCDFLIB    =-L$(NETCDF_PATH)/lib -lnetcdff -llapack -lblas
NETCDFINC    =-I$(NETCDF_PATH)/include

INCS = $(NETCDFINC)
LIBS = $(NETCDFLIB)

FFLAGS = $(FFLAGS_IN) $(LKFLAG) #-r8

F90C=$(F90) $(FCPFLAG) $(INCS)
F90L=$(F90) $(LIBS) $(FFLAGS)
