function [] = curveGiffer3(x,y, z, fileName, t, stepsPerFrame, xBounds, yBounds, zBounds)
%Generates a gif of the parametric curve defined by x(t), y(t), z(t).
%
%inputs: (x,y, z, fileName, t, stepsPerFrame, xBounds, yBounds, zBounds)
%
%   ~stepsPerFrame, xBounds, yBounds, and zBounds are optional~
%
%x, y, and z must be function handles of a single variable, using element-wise operations. For example:
%   x = @(t) t
%   y = @(t) t.^2
%   z = @(t) t.^3
%
%fileName is the name given to the generated gif file. Do not include
%extension.
%
%t is the array of values at which the points on the curve are calculated. For example:
%   t = 0:0.001:1
%
%stepsPerFrame is the number of calculations between each frame of the gif.
%
%xBounds, yBounds, and zBounds, are the bounds of their respective axes and
%must be of the form [min, max].

gifFile = append(fileName, '.gif'); 

xT = x(t);
yT = y(t);
zT = z(t);

% default variable values if none are entered
if ~exist('stepsPerFrame','var')
      stepsPerFrame = ceil(length(t) / 100);
end
if ~exist('xBounds', 'var')
      xBounds = [min(xT)-0.1, max(xT)+0.1];
end
if ~exist('yBounds', 'var')
      yBounds = [min(yT)-0.1, max(yT)+0.1];
end
if ~exist('zBounds', 'var')
      zBounds = [min(zT)-0.1, max(zT)+0.1];
end

curve = animatedline('LineWidth', 2);
set(gca, 'XLim', xBounds, 'YLim', yBounds, 'ZLim', zBounds);
view(3);
hold on;
grid on;

exportgraphics(gca, gifFile);
for i=1:length(t)
    addpoints(curve, xT(i), yT(i), zT(i));
    head = scatter3(xT(i), yT(i), zT(i), 'filled', 'MarkerFaceColor', 'magenta', 'MarkerEdgeColor', 'magenta');

    if ~mod(i, stepsPerFrame)
    exportgraphics(gca, gifFile, 'Append', true);
    end

    delete(head);
end

close;
end