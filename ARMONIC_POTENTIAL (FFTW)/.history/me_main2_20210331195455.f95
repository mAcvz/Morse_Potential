program  me_main2
    implicit none
    include "fftw3.f"
    integer, parameter :: dp = kind(0.0D0) 
    integer,parameter :: N = 8092
    integer :: i
    real(kind=dp) :: h, L = 20.d0
    real(kind=dp),dimension(0:N-1) :: x 
    complex(kind=dp),dimension(0:N-1) :: in,out
    integer(kind=dp) :: plan 
    !
    h = L/2.d0
    do i=0, N-1
        x(i) = -L/2.d0 + (h*i)
        in(i) = x(i)**2
    end do
    call dfftw_plan_dft_1d(plan,in,out,FFTW_forward,fftw_estimate)
    call dfftw_execute(plan,in,out)
    call dfftw_destroy_plan(plan)
    open(unit=1,file='file_output.dat')
    write(UNIT=1,fmt="(i6,f30.15,a3,f30.15,a2)")(i,real(out(i)),"  ",(aimag(out(i)))," i",i=1,N/2 + 1)

end program  me_main2
