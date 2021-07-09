program main_prova
    include "fftw3.f03"
    use, intrinsic :: iso_c_binding
    implicit none 
   
    

    type(C_PTR) :: plan
    complex(C_DOUBLE_COMPLEX), dimension(1024,1000) :: in, out
    plan = fftw_plan_dft_2d(1000,1024, in,out, FFTW_FORWARD,FFTW_ESTIMATE)



    
end program main_prova
