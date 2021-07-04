program  main_2_0
    implicit none
    include "fftw3.f"
    integer, parameter :: dp = kind(0.0D0) 
    integer,parameter :: N 
    integer :: i
    real(kind=dp) :: h, L 
    real(kind=dp),dimension(:),allocatable :: x 
    complex(kind=dp),dimension(:),allocatable :: in,out
    integer(kind=dp) :: plan 
    Input.txt
    open(unit=1,file='file_input.dat')
    write(unit=1,fmt=*)N,L,F
    close(unit=1)
    allocate(x(0:N-1))
    allocate(in(0:N-1))
    allocate(out(0:N-1))
    !
    h = L/N
    do i=0, N-1
        x(i) = -L/2.d0 + (h*i)
        in(i) = x(i)**2
    end do
    call dfftw_plan_dft_1d(plan,N,in,out,FFTW_forward,fftw_estimate)
    call dfftw_execute(plan,in,out)
    call dfftw_destroy_plan(plan)
    open(unit=2,file='file_output.dat')
    write(unit=2,fmt="(i6,f30.15,a3,f30.15,a2)")(i,real(out(i)),"  ",(aimag(out(i)))," i",i=1,N/2 + 1)
    close(unit=2)

end program  main_2_0
