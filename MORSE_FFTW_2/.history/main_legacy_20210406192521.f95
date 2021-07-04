program  main_2_0    !V_true(i,j) = (((((j-i)*L)**2) -2.d0)*sin((j-i)*L) + 2*L*(j-i)*cos((j-i)*L))  /  (((j-i)**3)*L)
    implicit none
    include "fftw3.f"
    integer, parameter :: dp = kind(0.0D0) 
    integer :: N,F,i,j,k,kp
    real(kind=dp) :: h, L !,tic, toc 
    real(kind=dp),dimension(:),allocatable :: x 
    complex(kind=dp),dimension(:),allocatable :: in,out
    real(kind=dp),dimension(:,:),allocatable :: V, V_true
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
    allocate(V_true(N,N))
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
    out = out/dble(N)
    ! call cpu_time(toc)
    open(unit=2,file='file_output.dat')
    write(unit=2,fmt="(i6,f30.15,a3,f30.15,a2)")(i,real(out(i)),"  ",(aimag(out(i)))," i",i=1,N)
    close(unit=2)
    ! write(*,*) toc - tic 
    do i=0,N-1
        do j = 1, N-i 
            V(j,j+i)= real(out(i+1))
            if (i .ne. 0 ) then 
                V(j+i,j)= real(out(i+1))
            end if  
        end do
    end do 

    open(unit=3,file='colonna_v.txt')
    write(unit=3,fmt="(i4,f15.5)")(i,real(V(i,1)),i=1,N)
    close(unit=3)


    do k = 1, N 
        do kp = 1, N 
            if (j .ne. i) then 
            
                V_true(k,kp) = () / (L*(kp-k)**3)
            end if 
        end do 
    end do 
    do i = 1, N
        V_true(i,i) = (L**2)/3
    end do 
    open(unit=4,file='colonna_v_true.txt')
    write(unit=4,fmt="(i4,f15.5)")(i,real(V_true(i,1)),i=1,N)
    close(unit=4)

end program  main_2_0
