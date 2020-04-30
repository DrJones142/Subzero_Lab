function [fig1, fig2] = histoCurves(MV)
    fig1 = figure('Name',' Gaussian Curvature');
    for i = 1:size(MV,2)
        x = nanmean(MV(i).gaussianCurvature);
        scatter(x,i);
hold on
    end
    
    
    fig2 = figure('Name', 'Mean Curvature');
     for i = 1:size(MV,2)
        x = nanmean(MV(i).meanCurvature);
        scatter(x,i);
hold on
    end


end