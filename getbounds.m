% This function will retrieve the tumor bounds from the .xml file as a
% function
% This requires parseXML.m
function [xmin, ymin, xmax, ymax] = getbounds(x) % x is the annotation filename
       dst = parseXML(x); % MATLAB data structure initialized
   % This converts the tumor bounds from str to num, store them in vector:
       xmin = str2num(dst.Children(14).Children(10).Children(2).Children.Data);
       ymin = str2num(dst.Children(14).Children(10).Children(4).Children.Data);
       xmax = str2num(dst.Children(14).Children(10).Children(6).Children.Data);
       ymax = str2num(dst.Children(14).Children(10).Children(8).Children.Data);
end