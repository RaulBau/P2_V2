##
# FACULTAD DE INGENIERÍA UASLP
# Examen Parcial 2 v2
# Nombre: Bautista Robles Raúl
# Clave: 229563
# Fecha: 15/05/2021
#
# Se lee la imagen y se convierte al dominio de Fourier
##
function [imOr] = kLawSpace(L_K, nombreA, recorta)
  ##Se lee la imagen
  recI =imread(nombreA);
  YIni = fft2(double(recI));
  imOr = (abs(YIni).^L_K).*exp(j*angle(YIni));
endfunction