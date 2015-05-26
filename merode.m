%--------------------------------------------------------------------------
%------- TAREA 2 Reconocimiento de Placas----------------------------------
%------- Procesamiento Digital de Iágenes----------------------------------
%------- Por: Yefry Alexis Calderón Yepes yefry.calderon@udea.edu.co ------
%------- Farley Rua Suarez farley.rua@udea.edu.co -------------------------
%-------   Estudiantes Ingeniería de Sistemas  ----------------------------
%-------  Universidad de Antioquia ----------------------------------------
%------- 24 Mayo 2015-----------------------------------------------------
%--------------------------------------------------------------------------

%MERODE Erosiona una imagen dada (a) un elemento estructurante y el numero de
%iteraciones it
function [b] = merode(a, ee, it)

% Erosiona la imagen
    for i = 1:it
        a = imerode(a, ee);
%         figure(1); imshow(a)
%         pause
    end
    b = a;
end

