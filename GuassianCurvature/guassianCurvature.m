% @Khristian Jones
% Subzero Lab, Montana State University
% Feb 2020


% This script is used to calculate the guassian curvature of STL files
% This code has not been optimized in any way 

% This function requires the use of several matlab scripts: 
% For STL file parsing: 
% stlread.m

% For GausianCurvature calculation: 
% CalcCurvature.m
% CalcCurvatureDerivatie.m
% CalcFaceNormals.m
% CalcVertexNormals.m
% GetCurvatures.m
% getPrincipalCurvatures.m
% ProjectCTensor.m
% ProjectCurvatureTensor.m
% RotateCoordinateSystem.m

% All GausianCurvatue scripts written by Itzik Ben Shabat 

clear all 
clear workspace


%File name here 
filename = 'test1.stl'

% Read in the stl file as a trinagulation struct 
triangulationStruct = stlread(filename);

% Creates new struct from triangulation of faces and vertices 
FV.faces = triangulationStruct.ConnectivityList;
FV.vertices = triangulationStruct.Points;


% This variable will indicating wether or not to calcualte curvature derivatives
% RECOMMENDED TO KEEP AT 0, otherwise it will take a LONG time 
getderivatives=0;  

%Will return the PrincipalCurvatures. If getDeriatives = 1, will return
%FaceCMatrix, VertexCMatrix, and Cmagnitude (
[PrincipalCurvatures,PrincipalDir1,PrincipalDir2,FaceCMatrix,VertexCMatrix,Cmagnitude]= GetCurvatures(FV ,getderivatives);

%Multiplies the principal curvatures together to get the GausianCurvature
GausianCurvature=PrincipalCurvatures(1,:).*PrincipalCurvatures(2,:);

%% 

g = GausianCurvature;

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
mesh_h=patch(FV,'FaceVertexCdata',GausianCurvature','facecolor','flat','edgecolor','none','EdgeAlpha',0);
%set some visualization properties
set(mesh_h,'ambientstrength',0.1);
axis('image');
view([-135 35]);
camlight('headlight');
material('dull');
colorbar();

