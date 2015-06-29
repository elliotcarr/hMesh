commandwindow
clc
close all
clear all

% Add path to unzipped BiMesh directory
addpath('..')

% Path to gmsh
gmsh_path = '/Volumes/gmsh-2.8.5-MacOSX/Gmsh.app/Contents/MacOS/gmsh ';

image  = 'Fractures.png'; % Image of domain
r      = 0.02;            % Mesh refinement parameter
width  = 1;               % Width of domain
height = 1;               % Height of domain
domain = 'B';             % Domain 
fname  = ['mesh',domain]; % File name of gmsh .geo file

% Generate gmsh .geo file
mesh_geo(image,fname,r,width,height,domain);

% Call gmsh and mesh the geometry
fprintf('%% Meshing microscopic domain\n');
system([gmsh_path,[fname,'.geo -2']]);

% Read gmsh .msh file and create mesh properties
mesh      = read_msh(fname);
nodes     = mesh.nodes;
elements  = mesh.elements;
subdomain = mesh.subdomain;

figure;
% colormap([1,0,0; 0,1,0])
colormap([1,0,0; 1,1,0])
p = patch('Faces',elements,'Vertices',nodes(:,1:2),'FaceColor','flat');
set(p,'FaceVertexCData',subdomain');
hold on
box on
caxis([1,2])
axis([0,width,0,height]);
set(gca,'DataAspectRatio',[1,1,1],'FontSize',14)
drawnow