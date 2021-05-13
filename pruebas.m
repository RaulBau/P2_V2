##Se limpia la consola
clc;
clear;

##Se cargan los paquetes
pkg load image;
pkg load video;

##Se lee la informacion del video
info=aviinfo("Examen2.avi");
##Se obtiene un frame en especifico
vv=aviread("Examen2.avi",1735);
##Se recorta la imagen del filtro
##im2=rgb2gray(imcrop(vv,[144,148,15,11]));
##Se recorta la imagen del fondo
imO=rgb2gray(imcrop(vv,[105,45,195,195]));

##Se completa la imagen para hacerla cuadrada
##imH=padarray(im2,[92,90]);
##imshow(im2);
##imwrite(imH,"filtro.bmp");
##return

##Leemos el filtro
imH=imread("filtro.bmp");
##PAsamos la imagen al dominio de furier
imH1=fft2(imH);
##Obtenemos la información del video
info=aviinfo("Examen2.avi");
arr=zeros(info.NumFrames/3,6);

iCont=1;
for iRec=1:3:info.NumFrames-130
  im1=rgb2gray(aviread("Examen2.avi",iRec));
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




