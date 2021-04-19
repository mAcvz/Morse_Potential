program  main_morse
    !
        implicit none 
        include "fftw3.f"
        !
        integer, parameter :: dp = kind(0.0D0) 
        real(kind=dp), parameter :: pi = acos(-1.d0)
        integer :: N, i, j, INFO, LWORK 
        character, parameter :: JOBZ = 'V', UPLO = 'U'
        real(kind=dp) :: h, L, alpha!,tic, toc 
        real(kind=dp),dimension(:),allocatable :: x, W, K_vec, RWORK
        complex(kind=dp),dimension(:),allocatable :: in, out, WORK
        complex(kind=dp),dimension(:,:),allocatable :: Ham, V
        integer(kind=dp) :: plan 
        !lettura
        open(unit=1,file='file_input.dat')
        read(unit=1,fmt=*)
        read(unit=1,fmt=*)N,L,alpha
        close(unit=1)
        !
        LWORK = 6600 ! valore ottimale per LWORK 
        !allocazione
        allocate(x(N))
        allocate(in(N))
        allocate(out(N))
        allocate(V(N,N))
        allocate(Ham(N,N))
        allocate(W(N))
        allocate(WORK(LWORK))
        allocate(K_vec(N))
        allocate(RWORK(3*N-2))
        !
        h = 2*L/dble(N)
        do i=0, N-1
            x(i+1) = h*i
            in(i) = (1 - exp(-(alpha)*(x(i)- L/8.d0) ))**2
        end do
        !call cpu_time(tic)    
        !UTILIZZO FFTW3
        call dfftw_plan_dft_1d(plan,N,in,out,FFTW_forward,fftw_estimate)
        call dfftw_execute(plan,in,out)
        call dfftw_destroy_plan(plan)
        out = out/dble(N)        
        ! call cpu_time(toc)
        open(unit=2,file='file_output.dat')
        write(unit=2,fmt="(i6,f30.15,a3,f30.15,a2)")(i,real(out(i)),"  ",(aimag(out(i)))," i",i=1,N)
        close(unit=2)
        ! write(*,*) toc - tic 
        ! COSTRUZIONE MATRICE V
        do i=0,N-1
            do j = 1, N-i 
                V(j,j+i)= (out(i+1))  
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
        !
        do i=1,N
            Ham(i,i) = K_vec(i)**2
        end do 
        !
        open(unit=3,file='riga_v.txt')
        write(unit=3,fmt="(i4,f15.5)")(i,real(V(1,i)),i=1,N)
        close(unit=3)
        !    
        Ham = Ham + V       ! FFTW
        !
        call zheev(JOBZ,UPLO,N,Ham,N,W,WORK,LWORK,RWORK,INFO)
        ! http://www.netlib.org/lapack/explore-html/df/d9a/group__complex16_h_eeigen_gaf23fb5b3ae38072ef4890ba43d5cfea2.html#gaf23fb5b3ae38072ef4890ba43d5cfea2
        print*, real(WORK(1))
        print*, INFO 
        write(*,fmt="(i4,f15.10)")(i,W(i)/2 ,i=1,5)
        !
        open(unit=6,file='autovet.txt')
        write(unit=6,fmt="(f15.5)")(real(Ham(i,1)),i=1,N) ! non corrispondono a quelli dello spazio reale
        close(unit=6)
    !  
    end program  main_morse
    