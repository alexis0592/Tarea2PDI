%--------------------------------------------------------------------------
%------- TAREA 2 Reconocimiento de Placas----------------------------------
%------- Procesamiento Digital de Iágenes----------------------------------
%------- Por: Yefry Alexis Calderón Yepes yefry.calderon@udea.edu.co ------
%------- Farley Rua Suarez farley.rua@udea.edu.co -------------------------
%-------   Estudiantes Ingeniería de Sistemas  ----------------------------
%-------  Universidad de Antioquia ----------------------------------------
%------- 24 Mayo 2015-----------------------------------------------------
%--------------------------------------------------------------------------

%se inicializa las variables, se cierran todas las ventanas y procesos
%activos, se limpia la ventana de comandos
clear all; close all; clc

for i=1:198
    %----------------------------------------------------------------------
    %----------------- Recorta la imagen original   -----------------------
    %----------------------------------------------------------------------

    %----------------- Tomamos la Imagen  ---------------
      
    imagen=['carro (',num2str(i),').jpg'];
    cont=i;
    fotoOriginal=imread(imagen);
    [fil,col,cap]=size(fotoOriginal);
    figure(1); imshow(fotoOriginal);
    
    %Disminuye de luminosidad
    fotoOriginal = fotoOriginal ./ 0.54;    
    
    %----------------- La recortamos  --------------
    [b, a_org] = recortarImagen(fotoOriginal, fil,col,cap);
%     figure;imshow(b)
%     pause;
   
    %----------------- Extraen componentes de color -----------------------
    
    %----------------- b  ---------------

    fotoOriginal = b;
    aa = rgb2gray(fotoOriginal); %convierte la imagen RGB a una escala de 
    %grises, eliminando la información de hue y saturación mientras retiene la iluminación
    
    cform = makecform('srgb2lab'); %crea una estructura de transformación del
    %color, convirtiendo de un espacio RGB a L*a*b espacio de color
    a1 = applycform(fotoOriginal, cform); %aplica la transformación del espacio 
    %de color a la imagen
    a11 = a1;
    a1 = double(a1); 
    a1 = a1/max(a1(:)) * 255;
    a1 = uint8(a1);
%     figure;imshow(a1);
%     pause;

    %----------------- y  ---------------
    cform = makecform('srgb2cmyk'); %crea una estructura de transformación del color, 
    %convirtiendo de RGB a un espacio de color CMYK
    a3 = applycform(fotoOriginal, cform); %se aplica la transformación a la imagen
    a33 = a3;
    a3 = double(a3); 
    a3 = a3/max(a3(:))*255;
    a3 = uint8(a3);
    %----------------- s  ---------------
    
    a8 = rgb2hsv(fotoOriginal); %convierte un mapa de color RGB a un mapa de color HSV
    a88 = a8;
    a8 = double(a8); 
    a8 = a8/max(a8(:))*255;
    a8 = uint8(a8);    

    [fil,col,cap]=size(fotoOriginal);
    a1 = reshape(a1,[fil, col*cap]); %lab
    a3 = reshape(a3,[fil, col*(cap+1)]); %cmyk 
    a7 = a3(:,(col*3)+1:col*4);
    a7 = [a7,a7,a7]; %k de cmyk
    a6 = a3(:,1:col*3); %cmy
    a8 = reshape(a8,[fil,col*cap]); %hsv
    a9 = reshape(fotoOriginal,[fil,col*cap]); %rgb
%     figure;imshow(a9);
%     pause;
    %----------------- se extraen las capas b y s  ---------------
    b = a1(:,(col*2+1):col*3);
    y = a6(:,(col*2+1):col*3);
    s = a8(:,(col+1):col*2);
    bb = a9(:,(col*2+1):col*3); 
    bb=255 - bb; % imagen en blanco y negro
%     figure;imshow(bb);
%     pause;

    %----------------- extraemos los máximos entre todos ---------
    b1=max(b,y); 
    b2=max(b,s);
    b3=max(y,s);
    b4=max(b1,s);
  
%----------------------------------------------------------------------
    fotoOriginal=b1;
    
    b = filterImage(fotoOriginal);%llama función para aplicar filtros a la imagen
    fotoOriginal=b3;
    b(find(b<180))=0;
    b(find(b>0))=255;
%     figure;imshow(b);
%     pause;
%----------------------------------------------------------------------
    [l,num] = bwlabel(b); %se etiquetan elementos en la imagen
    l1 = l*0;
    area = []; %vector para almacenar areas de elementos
    
    for j = 1:num %ciclo para calcular áreas de elementos en la imagen a blanco y negro
        l1(find(l==j)) = 1;
        areaI = sum(l1(:));
        area = [area,areaI];
        l1 = l*0;
    end
    
    area_M = max(area(:)); %se extrae el área mayor de la imagen, que es el de la placa
    ind = find(area==area_M);
    l1(find(l==ind)) = 255;
    l1 = uint8(l1);
    [fil,col] = find(l1>0);
    %se extrae las filas y columnas máximas y minimas para recortar la
    %imagen
    fil_m = min(fil);
    fil_M = max(fil);
    col_m = min(col);
    col_M = max(col);

    placa = a_org(fil_m:fil_M, col_m:col_M); %se recorta la imagen, se deja la 
    %placa sola
%     figure;imshow(placa);
%     pause;
    placa = imresize(placa, [1000 2600]); %se redimensiona la imagen a un tamaño estandar
   

    %Umbralizar la imagen
    levelUmbral = graythresh(placa);
    
    placaUmbralizada = im2bw(placa,levelUmbral); %se binariza la imagen
    placaUmbralizada = (placaUmbralizada == 0); %se invierte los colores del fondo y la letra
%     figure;imshow(placaUmbralizada);
%     pause;

    %----------------Erosionar la imagen - Dilatar la imagen--------------
    
    ee = strel('square', 5);    
    it = 2;
    placaUmbralizada = merode(placaUmbralizada, ee, it);
    placaUmbralizada = medilate(placaUmbralizada, ee, it);
%     figure;imshow(placaUmbralizada);
%     pause;
    
% Quitar bordes
    placaUmbralizada = imclearborder(placaUmbralizada);
% Eliminar ruido
    placaUmbralizada = bwareaopen(placaUmbralizada, 10000); 
    
% --------------------Segmentar la imagen binarizada----------------------
    
%     figure;imshow(placaUmbralizada);
%     pause;
    [l,num]=bwlabel(placaUmbralizada); %se etiqueta los elementos de la placa binarizada
    
    if num >= 6
        % Mostrar cada uno de los elementos
        imgFinal = showElements(placaUmbralizada,l,num); 
        %imgFinal = regionprops(imgFinal,'FilledImage');
        figure(6);imshow(imgFinal);
        pause;
    end    
    clear all; close all; clc
end

