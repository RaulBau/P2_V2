##Se limpia la consola
clc;
clear;

##Se cargan los paquetes
pkg load image;
pkg load video;
##140
##Se lee la informacion del video
info=aviinfo("10292009083301.avi");
##Se obtiene un frame en especifico
##vv=aviread("10292009083301.avi",1250);##p1
##vv=aviread("10292009083301.avi",2100);##p2
vv=aviread("10292009083301.avi",4200);##p3

##Filtros

##Se recorta la imagen del filtro
##imFiltro=rgb2gray(imcrop(vv,[157,192,19,11]));##p1
##imFiltro=rgb2gray(imcrop(vv,[110,155,17,11]));##p2
imFiltro=rgb2gray(imcrop(vv,[155,99,13,5]));##p3

##Fin Filtros

##Se recorta la imagen del fondo
imO=rgb2gray(imcrop(vv,[105,45,195,195]));
imO=rgb2gray(vv);

##imshow(imO);
##return

##Se completa la imagen para hacerla cuadrada
##imH=padarray(imFiltro,[64,60]);##p1
##imH=padarray(imFiltro,[64,61]);##p2
imH=padarray(imFiltro,[67,63]);##p3
imshow(imFiltro);
##imwrite(imH,"Filtros/p1.bmp");##p1
##imwrite(imH,"Filtros/p2.bmp");##p2
imwrite(imH,"Filtros/p3.bmp");##p3
return

##Leemos el filtro
imH=imread("filtro.bmp");
##PAsamos la imagen al dominio de furier
imH1=fft2(imH);
##Obtenemos la informaci�n del video
info=aviinfo("10292009083301.avi");
arr=zeros(info.NumFrames/3,6);

iCont=1;
for iRec=1:3:info.NumFrames-130
  im1=rgb2gray(aviread("10292009083301.avi",iRec));
  imO=imcrop(im1,[105,45,195,195]);
  imF=imO;
  imO=fft2(imO);
  
  cor1=real(ifftshift(ifft2(imO.*conj(imH1./abs(imH1)))));
  vmax=reshape(cor1,[],1);
  vmax10=sort(vmax,'descend');
  [yy,xx]=find(vmax10(1)==cor1);
  arr(iCont,1)=xx;
  arr(iCont,2)=yy;
  arr(iCont,3)=vmax10(1);
  [yy,xx]=find(vmax10(2)==cor1);
  arr(iCont,4)=xx;
  arr(iCont,5)=yy;
  arr(iCont,6)=vmax10(2);
  iCont=iCont+1;
endfor

csvwrite("pruebas.csv",arr);




