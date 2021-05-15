##
# FACULTAD DE INGENIERÍA UASLP
# Examen Parcial 2 v2
# Nombre: Bautista Robles Raúl
# Clave: 229563
# Fecha: 15/05/2021
#
# Convierte la imagen al dominio de Fourier
##

function [imOr] = kLawSpaceV(L_K, nombreI)  
  YIni = fft2(double(nombreI));
  imOr = (abs(YIni).^L_K).*exp(j*angle(YIni));
endfunction
