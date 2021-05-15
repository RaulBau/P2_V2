##
# FACULTAD DE INGENIERÍA UASLP
# Examen Parcial 2 v2
# Nombre: Bautista Robles Raúl
# Clave: 229563
# Fecha: 15/05/2021
##

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
##vv=aviread("10292009083301.avi",4200);##p3

##vv=aviread("10292009083301.avi",1250);##d1
##vv=aviread("10292009083301.avi",2100);##d2
##vv=aviread("10292009083301.avi",3500);##d3

##Creación de Filtros

##Se recorta la imagen del filtro
##imFiltro=rgb2gray(imcrop(vv,[157,192,19,11]));##p1
##imFiltro=rgb2gray(imcrop(vv,[110,155,17,11]));##p2
##imFiltro=rgb2gray(imcrop(vv,[155,99,13,5]));##p3

##imFiltro=rgb2gray(imcrop(vv,[91,176,19,11]));##d1
##imFiltro=rgb2gray(imcrop(vv,[169,145,17,9]));##d2
##imFiltro=rgb2gray(imcrop(vv,[140,92,15,7]));##d3

##imO=rgb2gray(vv);
##imshow(imO);
##return

##Se completa la imagen para hacerla cuadrada
##imH=padarray(imFiltro,[64,60]);##p1
##imH=padarray(imFiltro,[64,61]);##p2
##imH=padarray(imFiltro,[67,63]);##p3

##imH=padarray(imFiltro,[64,60]);##d1
##imH=padarray(imFiltro,[65,61]);##d2
##imH=padarray(imFiltro,[66,62]);##d3

##imwrite(imH,"Filtros/p1.bmp");##p1
##imwrite(imH,"Filtros/p2.bmp");##p2
##imwrite(imH,"Filtros/p3.bmp");##p3

##imwrite(imH,"Filtros/d1.bmp");##d1
##imwrite(imH,"Filtros/d2.bmp");##d2
##imwrite(imH,"Filtros/d3.bmp");##d3

##imshow(imFiltro);
##return

##Fin Creación de Filtros


##Filtros p
rutaP="Filtros/p";
LK=0.4;
NImages=3;
H_Filtro_P=filtroC_LK(LK,rutaP,NImages,0.6);
##FinFiltros

##Filtros d
rutaD="Filtros/d";
LK=0.4;
NImages=3;
H_Filtro_D=filtroC_LK(LK,rutaD,NImages,0.6);
##FinFiltros

##Creación de la mascara
mascara=ones(3);
mascara=mascara*-1;
mascara(2,2)=10;
cc=1;
##Fin Creación mascara


####Leemos el filtro
##imH=imread("filtro.bmp");
####PAsamos la imagen al dominio de furier
##imH1=fft2(imH);
####Obtenemos la informaciï¿½n del video
##info=aviinfo("10292009083301.avi");
arr_P=zeros(info.NumFrames/3,7);
arr_D=zeros(info.NumFrames/3,7);

iCont=1;
for iRec=1:3:info.NumFrames-130
  ##Obtenemos el frame
  frm=rgb2gray(aviread("10292009083301.avi",iRec));
  ##Recortamos la imagen
  frm=imcrop(frm,[95,85, 139, 139]);
  ##Creamos un respaldo del frame
  frmRes=frm;
  ##Se recorta la imagen del fondo
  ##imO=rgb2gray(imcrop(frm,[105,45,195,195]));
  imO=frm;
  
  ##Aplicamos el filtro P
  O_Filtro=kLawSpaceV(LK,frmRes);
  resp=O_Filtro.*(conj(H_Filtro_P)./abs(H_Filtro_P));
  corl=real(ifftshift(ifft2(resp)));
  maximo1=max(corl(:));
  [yy1,xx1]=find(maximo1==corl);
  corl2=imfilter(corl,mascara);
  maximo2=max(corl2(:));
  [yy2,xx2]=find(maximo2==corl2);
  arr_P(iCont,1)=iRec;
  arr_P(iCont,2)=xx1;
  arr_P(iCont,3)=yy1;
  arr_P(iCont,4)=maximo1;
  arr_P(iCont,5)=xx2;
  arr_P(iCont,6)=yy2;
  arr_P(iCont,7)=maximo2;
  
  ##Aplocamos el filtro D
  O_Filtro=kLawSpaceV(LK,frmRes);
  resp=O_Filtro.*(conj(H_Filtro_D)./abs(H_Filtro_D));
  corl=real(ifftshift(ifft2(resp)));
  maximo1=max(corl(:));
  [yy1,xx1]=find(maximo1==corl);
  corl2=imfilter(corl,mascara);
  maximo2=max(corl2(:));
  [yy2,xx2]=find(maximo2==corl2);
  arr_D(iCont,1)=iRec;
  arr_D(iCont,2)=xx1;
  arr_D(iCont,3)=yy1;
  arr_D(iCont,4)=maximo1;
  arr_D(iCont,5)=xx2;
  arr_D(iCont,6)=yy2;
  arr_D(iCont,7)=maximo2;
  iCont=iCont+1;

endfor

csvwrite("res_P.csv",arr_P);
csvwrite("res_D.csv",arr_D);




