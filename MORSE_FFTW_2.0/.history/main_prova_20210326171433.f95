program main_prova
    

    use, intrinsic :: iso_c_binding
    include "fftw3.f03"

    type(C_PTR) :: plan
    complex(C_DOUBLE_COMPLEX), dimension(1024,1000) :: in, out



    
end program main_prova
