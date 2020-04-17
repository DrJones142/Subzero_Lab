%% Test script 

% Set boundrary limits here for stl file 
% Units must match up to stl vertex coordinates (see FV.vertices

x_min = min(FV.vertices(:,1));  % These values designate the bounds in the x, y, and z
x_max = max(FV.vertices(:,1)); 
y_min = min(FV.vertices(:,2));
y_max = max(FV.vertices(:,2)); 
z_min = 20.5;
z_max = 21;                  % This will be the step profile 

MV = FV;                        % Varible copies the FV file struct which 
                                % contains the faces and vertices (see
                                % gaussianCurvature.m 
                                
[r] = (FV.vertices(:,1)>x_min & FV.vertices(:,1) < x_max & ...
       FV.vertices(:,2)>y_min & FV.vertices(:,2) < y_max & ...
       FV.vertices(:,3)>z_min & FV.vertices(:,3) < z_max);
                                
                                % Creates a logical vector that shows all
                                % '1' (true) if vector is within bound, or
                                % '0' (false) if vector is out of bounds 
                                
xFace = r(FV.faces(:,1));           
yFace = r(FV.faces(:,2));           
zFace = r(FV.faces(:,3));
                                % Matches the faces that contain the acceptable vertices 
                                % xFace, yFace, zFace - logical vector N-vertices long
                                

xyzFace = [xFace yFace zFace];   
                                % Creates 3XN long array 

xyzSum = xyzFace(:,1)+xyzFace(:,2)+xyzFace(:,3);

                                % Adds x,y,and z logical vectors up 
                                
MV.faces = MV.faces(find(xyzSum == 3),:);

                                % Chekcs all indices that have all 3
                                % vertices that are within x,y, and z
                                % bounds 

gc_final = GausianCurvature(unique(MV.faces));
%MV.vertices = MV.vertices(unique(MV.faces),:);
%m = min(MV.faces);
%m = min(m);
%MV.faces = MV.faces - m +1;     


 %% 

if (abs(min(GausianCurvature))<abs(max(GausianCurvature)))
    t1 = abs(min(GausianCurvature));
else
    t1 = abs(max(GausianCurvature));
end;

cmp = linspace(-t1, t1, 100);
rgb = zeros(100,3);
for i = 1:50
    rgb(i,:) = [1 i*.02 i*.02];
end
for i = 1:50
    rgb(50+i,:) = [1-i*.02 1 1-i*.02];
end


 
figure('name','Triangle Mesh Curvature Example','numbertitle','off','color','w');
% color overlay the gaussian curvature, currently limited to [-1 1] 
%caxis([-t1 t1]);
mesh_h=patch(MV,'FaceVertexCdata',GausianCurvature','facecolor','flat','edgecolor','none','EdgeAlpha',0);
%set some visualization properties
set(mesh_h,'ambientstrength',0.1);
axis('image');
view([-135 35]);
camlight('headlight');
material('dull');
colorbar();


%% histogram for gc_final

figure();
hold on;
histfit(gc_final)