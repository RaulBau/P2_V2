##
# FACULTAD DE INGENIER?A UASLP
# Examen Parcial 2 v2
# Nombre: Bautista Robles Ra?l
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
vvp1=aviread("10292009083301.avi",1250);##p1
vvp2=aviread("10292009083301.avi",2100);##p2
vvp3=aviread("10292009083301.avi",4200);##p3

vvd1=aviread("10292009083301.avi",1250);##d1
vvd2=aviread("10292009083301.avi",2100);##d2
vvd3=aviread("10292009083301.avi",3500);##d3

##Creaci?n de Filtros

##Se recorta la imagen del filtro
imFiltrop1=rgb2gray(imcrop(vvp1,[157,192,19,11]));##p1
imFiltrop2=rgb2gray(imcrop(vvp2,[110,155,17,11]));##p2
imFiltrop3=rgb2gray(imcrop(vvp3,[155,99,13,5]));##p3

imFiltrod1=rgb2gray(imcrop(vvd1,[91,176,19,11]));##d1
imFiltrod2=rgb2gray(imcrop(vvd2,[169,145,17,9]));##d2
imFiltrod3=rgb2gray(imcrop(vvd3,[140,92,15,7]));##d3

##Se completa la imagen para hacerla cuadrada
imHp1=padarray(imFiltrop1,[64,60]);##p1
imHp2=padarray(imFiltrop2,[64,61]);##p2
imHp3=padarray(imFiltrop3,[67,63]);##p3

imHd1=padarray(imFiltrod1,[64,60]);##d1
imHd2=padarray(imFiltrod2,[65,61]);##d2
imHd3=padarray(imFiltrod3,[66,62]);##d3

imwrite(imHp1,"Filtros/p1.bmp");##p1
imwrite(imHp2,"Filtros/p2.bmp");##p2
imwrite(imHp3,"Filtros/p3.bmp");##p3

imwrite(imHd1,"Filtros/d1.bmp");##d1
imwrite(imHd2,"Filtros/d2.bmp");##d2
imwrite(imHd3,"Filtros/d3.bmp");##d3

##Fin Creaci?n de Filtros


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

##Creamos el arreglo de resultados del filtro P
arr_P=zeros(info.NumFrames/3,7);
##Creamos el arreglo de resultados del filtro D
arr_D=zeros(info.NumFrames/3,7);

iCont=1;
iRec=4200;
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
  ##Se crea el filtro
  O_Filtro=kLawSpaceV(LK,frmRes);
  resp=O_Filtro.*(conj(H_Filtro_P)./abs(H_Filtro_P));
  ##Aplicamos lla correlaci?n
  corl=real(ifftshift(ifft2(resp)));
  ##Creamos un arreglo con los datos de la correlaci?n
  vmax=reshape(corl,[],1);
  ##Ordenamos los datos
  vmax10=sort(vmax,'descend');
  ##Obtemos el primer valor maximo
  maximo1=vmax10(1);
  ##Obtenemos el segundo valor maximo
  maximo2=vmax10(2);
  ##Buscamos el maximo1 en la correlaci?n
  [yy1,xx1]=find(maximo1==corl);
  ##Buscamos el maximo2 en la correlaci?n
  [yy2,xx2]=find(maximo2==corl);
  ##Guardamos los datos en el arreglo
  arr_P(iCont,1)=iRec;
  arr_P(iCont,2)=xx1;
  arr_P(iCont,3)=yy1;
  arr_P(iCont,4)=maximo1;
  arr_P(iCont,5)=xx2;
  arr_P(iCont,6)=yy2;
  arr_P(iCont,7)=maximo2;
  
  ##Aplocamos el filtro D
  ##Se crea el filtro
  O_Filtro=kLawSpaceV(LK,frmRes);
  resp=O_Filtro.*(conj(H_Filtro_D)./abs(H_Filtro_D));
  ##Aplicamos lla correlaci?n
  corl=real(ifftshift(ifft2(resp)));
  ##Creamos un arreglo con los datos de la correlaci?n
  vmax=reshape(corl,[],1);
  ##Ordenamos los datos
  vmax10=sort(vmax,'descend');
  ##Obtemos el primer valor maximo
  maximo1=vmax10(1);
  ##Obtenemos el segundo valor maximo
  maximo2=vmax10(2);
  ##Buscamos el maximo1 en la correlaci?n
  [yy1,xx1]=find(maximo1==corl);
  ##Buscamos el maximo2 en la correlaci?n
  [yy2,xx2]=find(maximo2==corl);
  ##Guardamos los datos en el arreglo
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




