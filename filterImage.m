%--------------------------------------------------------------------------
%------- TAREA 2 Reconocimiento de Placas----------------------------------
%------- Procesamiento Digital de I�genes----------------------------------
%------- Por: Yefry Alexis Calder�n Yepes yefry.calderon@udea.edu.co ------
%------- Farley Rua Suarez farley.rua@udea.edu.co -------------------------
%-------   Estudiantes Ingenier�a de Sistemas  ----------------------------
%-------  Universidad de Antioquia ----------------------------------------
%------- 24 Mayo 2015-----------------------------------------------------
%--------------------------------------------------------------------------

%Funci�n que aplica filtros especiales a la imagen de la placa para su
%posterior extracci�n
function b = filterImage(a)

H = fspecial('motion',20,45); %crea un filtro predefinido 2-D tipo motion
b = imfilter(a,H,'replicate'); %se aplica el filtro

for ii=1:10
    H = fspecial('disk',2); %crea un filtro tipo disco a la imagen
    b = imfilter(a,H);
    a=b;
end
end