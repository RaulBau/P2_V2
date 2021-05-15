function [imOr] = kLawSpace(L_K, nombreA, recorta)
  ##Se lee la imagen(en escala de grises)
  recI =imread(nombreA);
  YIni = fft2(double(recI));
 imOr = (abs(YIni).^L_K).*exp(j*angle(YIni));
endfunction