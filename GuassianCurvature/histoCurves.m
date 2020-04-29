function [fig1, fig2] = histoCurves(MV)
    fig1 = figure();
    for i = 1:size(MV,2)
hf=histfit(MV(i).gaussianCurvature);
delete(hf(1));
x=get(hf(2),'XData'); 
y=get(hf(2),'YData');
p1 = plot(x,y)
hold on
    end
    
    Legend=cell(size(MV,2),1)
    for iter = 1:size(MV,2)
        str1 = MV(iter).label;
        Legend{iter} = strcat(str1);
    end
    legend(Legend);
    
    fig2 = figure();
      for i = 1:size(MV,2)
hf=histfit(MV(i).meanCurvature);
delete(hf(1));
x=get(hf(2),'XData'); 
y=get(hf(2),'YData');
p1 = plot(x,y)
legend(p1, MV(i).label);
hold on

end