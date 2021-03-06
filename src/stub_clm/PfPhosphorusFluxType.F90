module PfPhosphorusFluxType
  use clm_varcon             , only : spval, ispval
  use shr_kind_mod           , only : r8 => shr_kind_r8
  use decompMod              , only : bounds_type
  use clm_varpar             , only : nlevdecomp_full, ndecomp_pools
implicit none

  type, public :: pf_phosphorusflux_type
    real(r8), pointer :: sminp_to_plant                      (:)=> null()
    real(r8), pointer :: sminp_to_plant_trans(:) => null()
  contains

    procedure, public  :: Init
    procedure, private :: InitCold
    procedure, private :: InitAllocate
    procedure, private :: SetValues
  end type pf_phosphorusflux_type

contains

  !------------------------------------------------------------------------
  subroutine Init(this, bounds)

    class(pf_phosphorusflux_type) :: this
    type(bounds_type), intent(in) :: bounds

    call this%InitAllocate ( bounds )

    call this%InitCold ( bounds )

  end subroutine Init
  !------------------------------------------------------------------------
  subroutine InitAllocate(this, bounds)
    !
    ! !DESCRIPTION:
    ! Initialize module data structure
    !
    ! !USES:
    use shr_infnan_mod , only : nan => shr_infnan_nan, assignment(=)
    !
    ! !ARGUMENTS:
    class(pf_phosphorusflux_type) :: this
    type(bounds_type), intent(in) :: bounds
    !
    ! !LOCAL VARIABLES:
    integer :: begp, endp
    integer :: begc, endc
    !------------------------------------------------------------------------

    begp = bounds%begp; endp= bounds%endp
    begc = bounds%begc; endc= bounds%endc

    allocate(this%sminp_to_plant_trans(begp:endp))
  end subroutine InitAllocate

  !-----------------------------------------------------------------------
  subroutine initCold(this, bounds)
    !
    ! !USES:
    use spmdMod    , only : masterproc
    use fileutils  , only : getfil
    use clm_varctl , only : nsrest, nsrStartup
    use ncdio_pio
    !
    ! !ARGUMENTS:
    class(pf_phosphorusflux_type) :: this
    type(bounds_type), intent(in) :: bounds
    !
    ! !LOCAL VARIABLES:
    integer               :: g,l,c,p,n,j,m            ! indices
    real(r8) ,pointer     :: gdp (:)                  ! global gdp data (needs to be a pointer for use in ncdio)
    real(r8) ,pointer     :: peatf (:)                ! global peatf data (needs to be a pointer for use in ncdio)
    integer  ,pointer     :: soilorder_rdin (:)       ! global soil order data (needs to be a pointer for use in ncdio)
    integer  ,pointer     :: abm (:)                  ! global abm data (needs to be a pointer for use in ncdio)
    real(r8) ,pointer     :: gti (:)                  ! read in - fmax (needs to be a pointer for use in ncdio)
    integer               :: dimid                    ! dimension id
    integer               :: ier                      ! error status
    type(file_desc_t)     :: ncid                     ! netcdf id
    logical               :: readvar
    character(len=256)    :: locfn                    ! local filename
    integer               :: begc, endc
    integer               :: begg, endg



  end subroutine initCold


  !-----------------------------------------------------------------------
  subroutine SetValues ( this, &
       num, filter, value)
    !
    ! !DESCRIPTION:
    ! Set nitrogen flux variables
    !
    ! !ARGUMENTS:
    ! !ARGUMENTS:
    class (pf_phosphorusflux_type) :: this
    integer , intent(in) :: num
    integer , intent(in) :: filter(:)
    real(r8), intent(in) :: value

    integer :: fi, i


  end subroutine SetValues
end module PfPhosphorusFluxType
