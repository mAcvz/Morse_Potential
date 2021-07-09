program  main_2_0
    implicit none
    include "fftw3.f"
    integer, parameter :: dp = kind(0.0D0) 
    integer :: N,F,i,j
    real(kind=dp) :: h, L !,tic, toc 
    real(kind=dp),dimension(:),allocatable :: x 
    complex(kind=dp),dimension(:),allocatable :: in,out
    real(kind=dp),dimension(:,:),allocatable :: V
    integer(kind=dp) :: plan 
    !lettura
    open(unit=1,file='file_input.dat')
    read(unit=1,fmt=*)
    read(unit=1,fmt=*)N,L,F
    close(unit=1)
    allocate(x(N))
    allocate(in(N))
    allocate(out(N))
    allocate(V(N,N))

    !
    h = L/dble(N)
    do i=1, N
        x(i) = -L/2.d0 + (h*(i-1))    
        in(i) = x(i)**2
    end do
    !call cpu_time(tic)    
    call dfftw_plan_dft_1d(plan,N,in,out,FFTW_forward,fftw_estimate)
    call dfftw_execute(plan,in,out)
    call dfftw_destroy_plan(plan)
    ! call cpu_time(toc)
    open(unit=2,file='file_output.dat')
    write(unit=2,fmt="(i6,f30.15,a3,f30.15,a2)")(i,real(out(i)),"  ",(aimag(out(i)))," i",i=1,N)
    close(unit=2)
    ! write(*,*) toc - tic 
    do i=0,N-1
        do j = 1, N-i 
            V(j,j+i)= real(out(i+1))
        end do
    end do 


end program  main_2_0
