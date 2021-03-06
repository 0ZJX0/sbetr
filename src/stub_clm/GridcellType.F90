module GridcellType

  !-----------------------------------------------------------------------
  ! !DESCRIPTION:
  ! Gridcell data type allocation
  ! --------------------------------------------------------
  ! gridcell types can have values of
  ! --------------------------------------------------------
  !   1 => default
  !
  ! PET: 9 Feb 2015: Preparing to change the sub-grid hierarchy to include
  ! 	 topographic units between gridcell and landunit.
  !
  use shr_kind_mod   , only : r8 => shr_kind_r8
  use shr_infnan_mod , only : nan => shr_infnan_nan, assignment(=)
  use landunit_varcon, only : max_lunit
  use clm_varcon     , only : ispval, spval
  !
  ! !PUBLIC TYPES:
  implicit none
  save
  private
  !
  type, public :: gridcell_type

     ! topological mapping functionality, local 1d gdc arrays
     integer , pointer :: gindex           (:) => null() ! global index
     real(r8), pointer :: area             (:)=> null() ! total land area, gridcell (km^2)
     real(r8), pointer :: lat              (:) => null() ! latitude (radians)
     real(r8), pointer :: lon              (:)=> null() ! longitude (radians)
     real(r8), pointer :: latdeg           (:)=> null() ! latitude (degrees)
     real(r8), pointer :: londeg           (:)=> null() ! longitude (degrees)

     ! Daylength
     real(r8) , pointer :: max_dayl        (:) => null()! maximum daylength for this grid cell (s)
     real(r8) , pointer :: dayl            (:) => null()! daylength (seconds)
     real(r8) , pointer :: prev_dayl       (:)=> null() ! daylength from previous timestep (seconds)

     ! indices into landunit-level arrays for landunits in this grid cell (ispval implies
     ! this landunit doesn't exist on this grid cell) [1:max_lunit, begg:endg]
     ! (note that the spatial dimension is last here, in contrast to most 2-d variables;
     ! this is for efficiency, since most loops will go over g in the outer loop, and
     ! landunit type in the inner loop)
     integer , pointer :: landunit_indices (:,:) => null()

   contains

     procedure, public :: Init
     procedure, public :: Clean

  end type gridcell_type
  type(gridcell_type), public, target :: grc    !gridcell data structure
  !------------------------------------------------------------------------

contains

  !------------------------------------------------------------------------
  subroutine Init(this, begg, endg)
    !
    ! !ARGUMENTS:
    class(gridcell_type) :: this
    integer, intent(in)  :: begg, endg
    !------------------------------------------------------------------------

    ! The following is set in InitGridCells
    allocate(this%gindex    (begg:endg)) ; this%gindex    (:) = ispval
    allocate(this%area      (begg:endg)) ; this%area      (:) = spval
    allocate(this%lat       (begg:endg)) ; this%lat       (:) = spval
    allocate(this%lon       (begg:endg)) ; this%lon       (:) = spval
    allocate(this%latdeg    (begg:endg)) ; this%latdeg    (:) = spval
    allocate(this%londeg    (begg:endg)) ; this%londeg    (:) = spval

    ! This is initiailized in module DayLength
    allocate(this%max_dayl  (begg:endg)) ; this%max_dayl  (:) = spval
    allocate(this%dayl      (begg:endg)) ; this%dayl      (:) = spval
    allocate(this%prev_dayl (begg:endg)) ; this%prev_dayl (:) = spval

    allocate(this%landunit_indices(1:max_lunit, begg:endg)); this%landunit_indices(:,:) = ispval

  end subroutine Init

  !------------------------------------------------------------------------
  subroutine Clean(this)
    !
    ! !ARGUMENTS:
    class(gridcell_type) :: this
    !------------------------------------------------------------------------

    deallocate(this%gindex           )
    deallocate(this%area             )
    deallocate(this%lat              )
    deallocate(this%lon              )
    deallocate(this%latdeg           )
    deallocate(this%londeg           )
    deallocate(this%max_dayl         )
    deallocate(this%dayl             )
    deallocate(this%prev_dayl        )
    deallocate(this%landunit_indices )

  end subroutine Clean

end module GridcellType
