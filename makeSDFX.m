##
# FACULTAD DE INGENIER�A UASLP
# Examen Parcial 2 v2
# Nombre: Bautista Robles Ra�l
# Clave: 229563
# Fecha: 15/05/2021
#
# Se ajusta el tama�o del vector
##
function [h] = makeSDFX(X,vectoru)
  d = sqrt(size(X,1));
  hx = X;## Matriz con imagenes en las columnas
  hsdf = hx*inv(hx'*hx)*vectoru; ## Se aplica el filtro sdf
  h=reshape(hsdf,d,d);
  h=h';## Se convierte el vector HSDF en una matriz
endfunction
