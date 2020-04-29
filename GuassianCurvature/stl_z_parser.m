%% Test script 
function MV = stl_z_parser(FV, gC, mC, includeEdges, numOfSlices);
% inputs: 
% FV - file vertex structure 
% gC - vertex-indexed Gaussian Curvature array 
% mC - vertex-indexed Mean Curvature array
% includeEdges - true/false input for including edges 
% Set boundrary limits here for stl file 
% Units must match up to stl vertex coordinates (see FV.vertices

x_min = min(FV.vertices(:,1));  % These values designate the bounds in the x, y, and z
x_max = max(FV.vertices(:,1)); 
y_min = min(FV.vertices(:,2));
y_max = max(FV.vertices(:,2)); 
z_min = min(FV.vertices(:,3));
z_max = max(FV.vertices(:,3));  % This will be the step profile 

MV = FV;                        % Varible copies the FV file struct which 
                                % contains the faces and vertices (see
                                % gaussianCurvature.m 

step_size = numOfSlices;  % set number of steps 
z_step = (z_max-z_min)/step_size; % Finds step size for 
z_entire = (z_max-z_min)/1;       % Entire profile 
z_bounds =  z_min + z_step.*(0:step_size); % Finds bounds for z_profile 


for i = 0:step_size 
    if (i == 0)
      [r] = (FV.vertices(:,1)>x_min & FV.vertices(:,1) < x_max & ...
             FV.vertices(:,2)>y_min & FV.vertices(:,2) < y_max & ...
             FV.vertices(:,3)>z_bounds(1) & FV.vertices(:,3) < z_bounds(length(z_bounds)));
       str1 = num2str(z_min);
       str2 = num2str(z_max);
       str3 = append('Full Profile : ',str1,' to ',str2);
      MV(i+1).label = str3; 
      MV(i+1).vertices   = FV.vertices;
      MV(i+1).gaussianCurvature         = gC;
      MV(i+1).meanCurvature             = mC;
    else
        if (includeEdges)
            [r] =(FV.vertices(:,1)>=x_min & FV.vertices(:,1)<= x_max & ...
                  FV.vertices(:,2)>=y_min & FV.vertices(:,2)<= y_max & ...
                  FV.vertices(:,3)>=z_bounds(i) & FV.vertices(:,3)<=z_bounds(i+1));
        else
            [r] = (FV.vertices(:,1)>x_min & FV.vertices(:,1)< x_max & ...
                   FV.vertices(:,2)>y_min & FV.vertices(:,2)< y_max & ...
                   FV.vertices(:,3)>z_bounds(i) & FV.vertices(:,3) < z_bounds(i+1));
        end
       str1 = num2str(z_bounds(i));
       str2 = num2str(z_bounds(i+1));
       str3 = append(str1,' to ',str2);
       MV(i+1).label = str3;
                      
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
                                
MV(i+1).faces = FV.faces(find(xyzSum == 3),:);

                                % Chekcs all indices that have all 3
                                % vertices that are within x,y, and z
                                % bounds 


gc_final = gC(unique(MV(i+1).faces));
mc_final = mC(unique(MV(i+1).faces));
MV(i+1).gaussianCurvature = gc_final;
MV(i+1).meanCurvature = mc_final;

MV(i+1).vertices = FV.vertices(unique(MV(i+1).faces),:);           %Refactors vertices and faces for new STL files
[is_it_there,index]=ismember(MV(i+1).faces,unique(MV(i+1).faces));
MV(i+1).faces = index;

end;

end;



end 

