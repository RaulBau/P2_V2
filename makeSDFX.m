function [h] = makeSDFX(X,vectoru)
  d = sqrt(size(X,1));
  hx = X; %% Matriz con imagenes en las columnas
  hsdf = hx*inv(hx'*hx)*vectoru; %% Se aplica el filtro sdf
  h=reshape(hsdf,d,d);
  h=h'; % Convierto el vector HSDF en una matriz
endfunction
