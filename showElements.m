%--------------------------------------------------------------------------
%------- TAREA 2 Reconocimiento de Placas----------------------------------
%------- Procesamiento Digital de Iágenes----------------------------------
%------- Por: Yefry Alexis Calderón Yepes yefry.calderon@udea.edu.co ------
%------- Farley Rua Suarez farley.rua@udea.edu.co -------------------------
%-------   Estudiantes Ingeniería de Sistemas  ----------------------------
%-------  Universidad de Antioquia ----------------------------------------
%------- 24 Mayo 2015-----------------------------------------------------
%--------------------------------------------------------------------------

%Función encargada de mostrar elemento por elemento de la placa binarizada
function b = showElements(r, l, num)
b=0; %variable que almacenara la nueva imagen con cada uno de los elementos sin elementos
%discriminados por área

for k = 1:num
    elem = r * 0;
    ind = find(l==k);
    elem(ind) = 255;
    areaI = sum(elem(:)); %area de un objeto en particular
    caracter = elem * 255;
    
    if areaI < 11000000 % se excluyen los elementos con area menor a 11000000
        caracter(:,:)=0; %se vuelve ese elemento negro, poniendo sus pixeles en 0
        elem(:,:)=0;
        continue;
    end
    % Aplicar regionprops
    %     c = regionprops(caracter,'FilledImage');
    %     b = c.FilledImage + caracter;
    b = b + caracter; %se recontruye la nueva imagen
    
    figure(5);imshow(caracter); %se muestra cada uno de los elementos
    title(['Objeto = ' , num2str(k), ' tiene area = ', num2str(areaI)]);
    %pause(1);
    
end

end