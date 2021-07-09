program  main_2_0
    use fftw_module
    implicit none
    !
    integer,parameter :: dp = kind(0.d0) 
    integer(C_int) :: N,F,i,j
    real(C_double) :: h, L !,tic,toc
    real(C_double),dimension(:),allocatable :: x,in
    real(kind = dp),dimension(:,:),allocatable :: m_kk
    complex(C_double_complex),dimension(:),allocatable :: out, v_kk
    real(kind = dp),dimension(:,:),allocatable :: V
    type(C_ptr):: plan 
    !lettura
    open(unit=1,file='file_input.dat')
    read(unit=1,fmt=*)
    read(unit=1,fmt=*)N,L,F
    close(unit=1)
    !allocamento
    allocate(x(0:N-1))
    allocate(in(0:N-1))
    allocate(out(0:(N/2 + 1)))
    allocate(v_kk(N))
    allocate(m_kk(N,N))
    allocate(V(N,N))
    !
    h = L/N
    do i=0, N-1
        x(i) = -L/2.d0 + (h*i)
        in(i) = x(i)**2
    end do
    !creazione/esecuzione piano
    !call cpu_time(tic)
    plan = fftw_plan_dft_r2c_1d(N,in,out,fftw_estimate)
    call fftw_execute_dft_r2c(plan,in,out)
    call fftw_destroy_plan(plan)
    out = out/dble(N)
    !call cpu_time(toc)
    !
    open(unit=2,file='file_output.dat')
    write(unit=2,fmt="(i6,f30.15,a3,f30.15,a2)")(i,real(out(i)),"  ",(aimag(out(i)))," i",i=1,N/2 + 1)
    close(unit=2)
    !write(*,*) toc-tic
    do i=0,(N-1)-1
        do j = 1, (N-10)-i 
            V(j,j+i)= real(out(i+1))
            if (i .ne. 0 ) then 
                V(j+i,j)= real(out(i+1))
            end if  
        end do
    end do 

    open(unit=3,file='colonna_v_C++.txt')
    write(unit=3,fmt="(i4,f15.5)")(i,real(V(i,1)),i=1,N/2 + 1)
    close(unit=3)
    

end program  main_2_0
