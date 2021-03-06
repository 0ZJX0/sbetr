module BeTR_nitrogenfluxRecvType
  use bshr_kind_mod  , only : r8 => shr_kind_r8
  use betr_decompMod , only : betr_bounds_type
  use betr_varcon     , only : spval => bspval
implicit none
#include "bshr_alloc.h"
  private
  character(len=*), parameter :: mod_filename = &
       __FILE__
  type, public :: betr_nitrogenflux_recv_type
    real(r8), pointer :: f_denit_vr_col(:,:)  => null()
    real(r8), pointer :: f_n2o_denit_vr_col(:,:)=> null()
    real(r8), pointer :: f_nit_vr_col(:,:)  => null()
    real(r8), pointer :: f_n2o_nit_vr_col(:,:) => null()
    real(r8), pointer :: supplement_to_sminn_vr_col(:,:) => null()

    real(r8), pointer :: smin_no3_to_plant_patch(:)  => null() !will be summarized within the bgc model, gN/m2/s
    real(r8), pointer :: smin_nh4_to_plant_patch(:)  => null() !will be summarized within the bgc model, gN/m2/s
    real(r8), pointer :: smin_no3_to_plant_vr_patch(:,:)  => null() !will be summarized within the bgc model, gN/m3/s
    real(r8), pointer :: smin_nh4_to_plant_vr_patch(:,:)  => null() !will be summarized within the bgc model, gN/m3/s

    real(r8), pointer :: fire_decomp_nloss_vr_col(:,:) => null()  !will be summarized within the bgc model
    real(r8), pointer :: fire_decomp_nloss_col(:) => null()  !will be summarized within the bgc model
    real(r8), pointer :: som_n_leached_col(:) => null()
    real(r8), pointer :: som_n_runoff_col(:) => null()
    real(r8), pointer :: som_n_qdrain_col(:) => null()
    real(r8), pointer :: supplement_to_sminn_col(:) => null()
    real(r8), pointer :: smin_nh4_immob_col(:) => null()
    real(r8), pointer :: smin_no3_immob_col(:) => null()

    real(r8), pointer :: f_nit_col(:) => null()
    real(r8), pointer :: f_denit_col(:)  => null()
    real(r8), pointer :: f_n2o_nit_col(:)  => null()
    real(r8), pointer :: smin_no3_leached_col(:) => null()
    real(r8), pointer :: smin_no3_runoff_col(:) => null()
    real(r8), pointer :: smin_no3_qdrain_col(:) => null()
    real(r8), pointer :: smin_nh4_leached_col(:) => null()
    real(r8), pointer :: smin_nh4_runoff_col(:) => null()
    real(r8), pointer :: smin_nh4_qdrain_col(:) => null()
    real(r8), pointer :: nh3_soi_flx_col(:) => null()
    real(r8), pointer :: smin_nh4_to_plant_vr_col(:,:) => null()
    real(r8), pointer :: smin_no3_to_plant_vr_col(:,:) => null()
    real(r8), pointer :: smin_nh4_immob_vr_col(:,:) => null()
    real(r8), pointer :: smin_no3_immob_vr_col(:,:) => null()
  contains
    procedure, public  :: Init
    procedure, private :: InitAllocate
    procedure, public  :: reset
    procedure, public  :: summary
  end type betr_nitrogenflux_recv_type

 contains


  !------------------------------------------------------------------------
  subroutine Init(this, bounds)

  implicit none
  class(betr_nitrogenflux_recv_type), intent(inout)  :: this
  type(betr_bounds_type), intent(in) :: bounds

  call this%InitAllocate(bounds)
  end subroutine Init

  !------------------------------------------------------------------------
  subroutine InitAllocate(this, bounds)

  implicit none
  class(betr_nitrogenflux_recv_type), intent(inout) :: this
  type(betr_bounds_type), intent(in) :: bounds
  !temporary variables
  integer :: begp, endp
  integer :: begc, endc
  integer :: lbj, ubj
  begp = bounds%begp ; endp=bounds%endp
  begc = bounds%begc ; endc=bounds%endc
  lbj = bounds%lbj   ; ubj=bounds%ubj

  SPVAL_ALLOC(this%f_denit_vr_col(begc:endc,lbj:ubj))
  SPVAL_ALLOC(this%f_n2o_denit_vr_col(begc:endc,lbj:ubj))
  SPVAL_ALLOC(this%f_nit_vr_col(begc:endc,lbj:ubj))
  SPVAL_ALLOC(this%f_n2o_nit_vr_col(begc:endc,lbj:ubj))

  SPVAL_ALLOC(this%smin_no3_to_plant_patch(begp:endp))
  SPVAL_ALLOC(this%smin_nh4_to_plant_patch(begp:endp))
  SPVAL_ALLOC(this%smin_no3_to_plant_vr_patch(begp:endp, lbj:ubj))
  SPVAL_ALLOC(this%smin_nh4_to_plant_vr_patch(begp:endp, lbj:ubj))

  SPVAL_ALLOC(this%f_nit_col(begc:endc))
  SPVAL_ALLOC(this%f_denit_col(begc:endc))
  SPVAL_ALLOC(this%f_n2o_nit_col(begc:endc))
  SPVAL_ALLOC(this%smin_no3_leached_col(begc:endc))
  SPVAL_ALLOC(this%smin_no3_runoff_col(begc:endc))
  SPVAL_ALLOC(this%smin_nh4_leached_col(begc:endc))
  SPVAL_ALLOC(this%smin_nh4_runoff_col(begc:endc))
  SPVAL_ALLOC(this%som_n_leached_col(begc:endc))
  SPVAL_ALLOC(this%som_n_runoff_col(begc:endc))
  SPVAL_ALLOC(this%som_n_qdrain_col(begc:endc))
  SPVAL_ALLOC(this%smin_no3_qdrain_col(begc:endc))
  SPVAL_ALLOC(this%smin_nh4_qdrain_col(begc:endc))
  SPVAL_ALLOC(this%fire_decomp_nloss_col(begc:endc))
  SPVAL_ALLOC(this%supplement_to_sminn_col(begc:endc))
  SPVAL_ALLOC(this%smin_nh4_immob_col(begc:endc))
  SPVAL_ALLOC(this%smin_no3_immob_col(begc:endc))
  SPVAL_ALLOC(this%fire_decomp_nloss_vr_col(begc:endc,lbj:ubj))
  SPVAL_ALLOC(this%supplement_to_sminn_vr_col(begc:endc,lbj:ubj))
  SPVAL_ALLOC(this%nh3_soi_flx_col(begc:endc))
  SPVAL_ALLOC(this%smin_nh4_to_plant_vr_col(begc:endc, lbj:ubj))
  SPVAL_ALLOC(this%smin_no3_to_plant_vr_col(begc:endc, lbj:ubj))
  SPVAL_ALLOC(this%smin_nh4_immob_vr_col(begc:endc, lbj:ubj))
  SPVAL_ALLOC(this%smin_no3_immob_vr_col(begc:endc, lbj:ubj))
  end subroutine InitAllocate

  !------------------------------------------------------------------------
  subroutine reset(this, value_column)
  implicit none
  class(betr_nitrogenflux_recv_type)  :: this
  real(r8), intent(in) :: value_column


  this%f_denit_vr_col(:,:) = value_column
  this%f_n2o_denit_vr_col(:,:) = value_column
  this%f_nit_vr_col(:,:) = value_column
  this%f_n2o_nit_vr_col(:,:) = value_column
  this%fire_decomp_nloss_vr_col(:,:) = value_column
  this%som_n_leached_col(:) = value_column
  this%som_n_runoff_col(:) = value_column
  this%som_n_qdrain_col(:) = value_column
  this%supplement_to_sminn_vr_col(:,:)= value_column
  this%nh3_soi_flx_col(:) = value_column
  this%smin_no3_leached_col(:)=value_column
  this%smin_nh4_leached_col(:)=value_column
  this%smin_no3_qdrain_col(:) = value_column
  this%smin_nh4_qdrain_col(:) = value_column
  this%smin_no3_runoff_col(:) = value_column
  this%smin_nh4_runoff_col(:) = value_column
  this%smin_nh4_to_plant_vr_col(:,:) = value_column
  this%smin_no3_to_plant_vr_col(:,:) = value_column
  this%smin_nh4_immob_vr_col(:,:) = value_column
  this%smin_no3_immob_vr_col(:,:) = value_column
  end subroutine reset

  !------------------------------------------------------------------------
  subroutine summary(this, bounds, lbj, ubj, dz)

  implicit none
  class(betr_nitrogenflux_recv_type),intent(inout)  :: this
  type(betr_bounds_type), intent(in) :: bounds
  integer , intent(in) :: lbj, ubj
  real(r8), intent(in) :: dz(bounds%begc:bounds%endc,lbj:ubj)

  integer :: c, j

  this%f_nit_col(:) = 0._r8
  this%f_denit_col(:) = 0._r8
  this%f_n2o_nit_col(:) = 0._r8
  this%fire_decomp_nloss_col(:) = 0._r8
  this%supplement_to_sminn_col(:) = 0._r8
  this%smin_nh4_immob_col(:) = 0._r8
  this%smin_no3_immob_col(:) = 0._r8
  do j = lbj, ubj
    do c = bounds%begc, bounds%endc
      this%f_nit_col(c) = this%f_nit_col(c) + dz(c,j) * this%f_nit_vr_col(c,j)
      this%f_denit_col(c) = this%f_denit_col(c) + dz(c,j)* this%f_denit_vr_col(c,j)
      this%f_n2o_nit_col(c) = this%f_n2o_nit_col(c) + dz(c,j)*this%f_n2o_nit_vr_col(c,j)

      this%fire_decomp_nloss_col(c) = this%fire_decomp_nloss_col(c) + dz(c,j) * &
         this%fire_decomp_nloss_vr_col(c,j)

      this%supplement_to_sminn_col(c) = this%supplement_to_sminn_col(c) + dz(c,j) * &
         this%supplement_to_sminn_vr_col(c,j)

      this%smin_nh4_immob_col(c) = this%smin_nh4_immob_col(c) + dz(c,j) * &
         this%smin_nh4_immob_vr_col(c,j)

      this%smin_no3_immob_col(c) = this%smin_no3_immob_col(c) + dz(c,j) * &
         this%smin_no3_immob_vr_col(c,j)


    enddo
  enddo
  end subroutine summary
end module BeTR_nitrogenfluxRecvType
