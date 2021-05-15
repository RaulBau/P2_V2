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

##Creación de Filtros

##Se recorta la imagen del filtro
##imFiltro=rgb2gray(imcrop(vv,[157,192,19,11]));##p1
##imFiltro=rgb2gray(imcrop(vv,[110,155,17,11]));##p2
##imFiltro=rgb2gray(imcrop(vv,[155,99,13,5]));##p3

##  imO=rgb2gray(vv);
##imshow(imO);
##return

##Se completa la imagen para hacerla cuadrada
##imH=padarray(imFiltro,[64,60]);##p1
##imH=padarray(imFiltro,[64,61]);##p2
##imH=padarray(imFiltro,[67,63]);##p3
##imshow(imFiltro);
##imwrite(imH,"Filtros/p1.bmp");##p1
##imwrite(imH,"Filtros/p2.bmp");##p2
##imwrite(imH,"Filtros/p3.bmp");##p3
##return

##Fin Creación de Filtros


##Filtros p
ruta="Filtros/p";
LK=0.4;
NImages=3;
H_Filtro_P=filtroC_LK(LK,ruta,NImages,0.6);
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
arr_P=zeros(info.NumFrames/3,6);

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
  
  ##Aplicamos el filtro
  O_Filtro=kLawSpaceV(LK,frmRes);
  resp=O_Filtro.*(conj(H_Filtro_P)./abs(H_Filtro_P));
  corl=real(ifftshift(ifft2(resp)));
  maximo1=max(corl(:));
  [yy1,xx1]=find(maximo1==corl);
  corl2=imfilter(corl,mascara);
  maximo2=max(corl2(:));
  [yy2,xx2]=find(maximo2==corl2);
  arr_P(iCont,1)=xx1;
  arr_P(iCont,2)=yy1;
  arr_P(iCont,3)=maximo1;
  arr_P(iCont,4)=xx2;
  arr_P(iCont,5)=yy2;
  arr_P(iCont,6)=maximo2;
  iCont=iCont+1;

##  cor1=real(ifftshift(ifft2(imO.*conj(imH1./abs(imH1)))));
##  vmax=reshape(cor1,[],1);
##  vmax10=sort(vmax,'descend');
##  [yy,xx]=find(vmax10(1)==cor1);
##  arr(iCont,1)=xx;
##  arr(iCont,2)=yy;
##  arr(iCont,3)=vmax10(1);
##  [yy,xx]=find(vmax10(2)==cor1);
##  arr(iCont,4)=xx;
##  arr(iCont,5)=yy;
##  arr(iCont,6)=vmax10(2);
##  iCont=iCont+1;
endfor

csvwrite("res_P.csv",arr_P);




