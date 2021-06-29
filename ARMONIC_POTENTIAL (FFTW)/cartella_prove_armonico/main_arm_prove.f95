program  main_2_0  
!
    implicit none 
    include "fftw3.f"
    integer, parameter :: dp = kind(0.0D0) 
    real(kind=dp), parameter :: pi = acos(-1.d0)
    integer :: N,F,i,j,INFO,LWORK
    character, parameter :: JOBZ = 'V', UPLO = 'U'
    !
    real(kind=dp) :: h, L !,tic, toc 
    real(kind=dp),dimension(:),allocatable :: x ,W,WORK,K_vec
    complex(kind=dp),dimension(:),allocatable :: in,out
    real(kind=dp),dimension(:,:),allocatable :: V, Ham
    integer(kind=dp) :: plan 
    !lettura
    open(unit=1,file='input_prova.dat')
    read(unit=1,fmt=*)
    read(unit=1,fmt=*)N,L,F  ! F -> numero di punti su cui definiamo il potenziale reale
    close(unit=1)           
    !
    LWORK = 1700
    !
    allocate(x(F))
    allocate(in(F))
    allocate(out(N))
    allocate(V(N,N))
    allocate(Ham(N,N))
    allocate(W(N))
    allocate(WORK(LWORK))
    allocate(K_vec(N))
    !
    h = 2*L/dble(F)
    do i=1, F
        x(i) = -L + (h*(i-1))    
        in(i) = x(i)**2
    end do
    !call cpu_time(tic)    
    !UTILIZZO FFTW3
    call dfftw_plan_dft_1d(plan,N,in,out,FFTW_forward,fftw_estimate)
    call dfftw_execute(plan,in,out)
    call dfftw_destroy_plan(plan)
    out = out/dble(N)        ! Normalizzazione 

    ! call cpu_time(toc)
    open(unit=2,file='file_output.dat')
    write(unit=2,fmt="(i6,f30.15,a3,f30.15,a2)")(i,real(out(i)),"  ",(aimag(out(i)))," i",i=1,N)
    close(unit=2)
    ! write(*,*) toc - tic 

    !COSTRUZIONE MATRICE V
    do i=0,N-1
        do j = 1, N-i 
            V(j,j+i)= real(out(i+1))  
           ! if (i .ne. 0 ) then 
           !     V(j+i,j) = real(out(i+1))     !RIEMPIAMO SOLO SOPRA
           ! end if  
        end do  
    end do 
    !  k = i *(pi/L)     
    !
      
    Ham = 0.d0 
    do i=1,N
        if (i <= N/2) then
            K_vec(i) = i*(pi/L)
        else if (i > N/2) then 
            K_vec(i) = (i-N)*(pi/L)
        endif 
    end do 
    do i=1,N
        Ham(i,i) = K_vec(i)**2
    end do   
    
    open(unit=3,file='riga_v.txt')
    write(unit=3,fmt="(i4,f15.5)")(i,real(V(1,i)),i=1,N)
    close(unit=3)
    
    
    Ham = Ham + V


    call dsyev(JOBZ,UPLO,N,Ham,N,W,WORK,LWORK,INFO)
    print*, WORK(1)
    print*, INFO 
    write(*,fmt="(i4,f15.5)")(i,W(i)/2 ,i=1,5)
!  
end program  main_2_0
