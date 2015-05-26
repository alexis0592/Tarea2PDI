%--------------------------------------------------------------------------
%------- TAREA 2 Reconocimiento de Placas----------------------------------
%------- Procesamiento Digital de I�genes----------------------------------
%------- Por: Yefry Alexis Calder�n Yepes yefry.calderon@udea.edu.co ------
%------- Farley Rua Suarez farley.rua@udea.edu.co -------------------------
%-------   Estudiantes Ingenier�a de Sistemas  ----------------------------
%-------  Universidad de Antioquia ----------------------------------------
%------- 24 Mayo 2015-----------------------------------------------------
%--------------------------------------------------------------------------

%MEDILATE Dilata una imagen dada (a) un elemento estructurante y el numero de
%iteraciones it
function [b] = medilate(a, ee, it)

% Erosiona la imagen
    for i = 1:it
        a = imdilate(a, ee);
%         figure(1); imshow(a)
%         pause
    end
    b = a;
end

