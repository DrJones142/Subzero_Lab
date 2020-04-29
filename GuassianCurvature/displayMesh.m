function [fig1, fig2] = displayMesh(MV, i, coloraxis_gc, coloraxis_mc);  
% inputs - MV file structure 
%        - index to view (1 = full view, 
str1 = strcat(MV(i).label,' : Gaussian Curvature');
fig1 = figure('Name',str1);
mesh_gc=patch('Faces',MV(i).faces, 'Vertices',MV(i).vertices, 'FaceVertexCdata',MV(i).gaussianCurvature','facecolor','flat','edgecolor','none','EdgeAlpha',0);
%set some visualization properties
set(mesh_gc,'ambientstrength',0.1);
axis('image');
view([-135 35]);
camlight('headlight');
material('dull');
caxis(coloraxis_gc);
colorbar();

str2 = strcat(MV(i).label,' : Mean Curvature');
fig2 = figure('Name',str2);
mesh_mc=patch('Faces',MV(i).faces, 'Vertices',MV(i).vertices, 'FaceVertexCdata',MV(i).meanCurvature','facecolor','flat','edgecolor','none','EdgeAlpha',0);
%set some visualization properties
set(mesh_mc,'ambientstrength',0.1);
axis('image');
view([-135 35]);
camlight('headlight');
material('dull');
caxis(coloraxis_mc);
colorbar();
end