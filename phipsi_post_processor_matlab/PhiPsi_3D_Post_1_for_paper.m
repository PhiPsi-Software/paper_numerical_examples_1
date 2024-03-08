

%     .................................................
%             ____  _       _   ____  _____   _        
%            |  _ \| |     |_| |  _ \|  ___| |_|       
%            | |_) | |___   _  | |_) | |___   _        
%            |  _ /|  _  | | | |  _ /|___  | | |       
%            | |   | | | | | | | |    ___| | | |       
%            |_|   |_| |_| |_| |_|   |_____| |_|       
%     .................................................
%     PhiPsi:     a general-purpose computational      
%                 mechanics program written in Fortran.
%     Website:    http://phipsi.top                    
%     Author:     Fang Shi  
%     Contact me: shifang@ustc.edu.cn     

%-------------------------------------------------------------------
%--------------------- PhiPsi_Post_Plot ----------------------------
%-------------------------------------------------------------------

%---------------- Start and define global variables ----------------
clear all; close all; clc; format compact;  format long;
global Key_Dynamic Version Num_Gauss_Points 
global Filename Work_Dirctory Full_Pathname num_Crack
global Num_Processor Key_Parallel Max_Memory POST_Substep
global tip_Order split_Order vertex_Order junction_Order    
global Key_PLOT Key_POST_HF Num_Crack_HF_Curves
global Plot_Aperture_Curves Plot_Pressure_Curves Num_Step_to_Plot
global Key_TipEnrich Elements_to_be_Ploted Key_Plot_Elements
global Key_Plot_EleGauss EleGauss_to_be_Ploted Crack_to_Plot
global RESECH_CODE

% Number of Gauss points of enriched element (default 64) for integral solution 2.
Num_Gauss_Points = 64;       

%-------------------------- Settings -------------------------------
% Add path of source files.
addpath('src_fcw')
% addpath('src_geom3d')
% addpath('src_meshes3d')
addpath('src_phipsi_post_animate')
addpath('src_phipsi_post_cal')
addpath('src_phipsi_post_main')
addpath('src_phipsi_post_plot')
addpath('src_phipsi_post_read')
addpath('src_phipsi_post_tool')

% Set default figure colour to white.
set(0,'defaultfigurecolor','w')

% Set default figure visible off.
set(0,'DefaultFigureVisible','off')

% Output information of matlab command window to log file.
diary('Command Window.log');        
diary on;
% rotate3d on;
% Display welcome information.

set(gcf,'renderer','opengl')

Welcome  
       
tic;
Tclock=clock;
Tclock(1);

disp([' >> Start time is ',num2str(Tclock(2)),'/',num2str(Tclock(3)),'/',num2str(Tclock(1))...
     ,' ',num2str(Tclock(4)),':',num2str(Tclock(5)),':',num2str(round(Tclock(6))),'.'])
disp(' ') 

% Make the "patch" method supported by "getframe", added in version 4.8.10
% See more: http://www.mathworks.com/support/bugreports/384622
% opengl('software') 
opengl hardware     

%----------------------- Pre-Processing ----------------------------
disp(' >> Reading input file....') 

% -------------------------------------
%   Set color and font
% -------------------------------------                           
PhiPsi_Color_and_Font_Settings    

% -------------------------------------
%   Start Post-processor.      
% -------------------------------------   
Key_PLOT   = zeros(6,15);                                   % Initialize the Key_PLOT

%###########################################################################################################
%##########################            User defined part        ############################################
%###########################################################################################################
% Filename='3D_Block_21x21x21_Sur_Fixed';Work_Dirctory='X:\PhiPsi_Work\example_1\case1\3D_Block_21x21x21_Sur_Fixed';
% Filename='3D_Block_21x21x21_Sur_Fixed';Work_Dirctory='X:\PhiPsi_Work\example_1\case2\3D_Block_21x21x21_Sur_Fixed';
Filename='3D_Block_20x20x20_Fixed';Work_Dirctory='X:\PhiPsi_Work\example_1\case3\3D_Block_20x20x20_Fixed';
% Filename='3D_Block_20x20x20_Fixed';Work_Dirctory='X:\PhiPsi_Work\example_1\case4\3D_Block_20x20x20_Fixed';

Num_Step_to_Plot      = -999       ;       % Step number to be plot; -999: final step.
% Crack_to_Plot         = 3          ;     % Only plot specified crack.
Defor_Factor          = 1.0        ;       % Deformation amplification factor.


% Line 1, Plot Mesh(=1),
%                   2:Node(=1,only nodes;=2,plot nodes + node number)
%                   3:Element(=1,plot solid element;=2,plot only element number;=3,plot element number + element center),Gauss points(4),
%                   5: Cracks and crack coordinate points, etc
%                      =1,Plot crack surface;        =2,Plot crack surface & crack coordinate points;       =3,Plot crack surface & crack coordinate points number;
%                      =4,Plot crack surface and discrete points;          =5,Plot fracture surface and discrete points number,
%                   6: Calculation point (fluid node) and its number:
%                       =1, fluid unit and node; 
%                       =2, fluid unit and node + node number; 
%                       =3, fluid unit and node + unit number; 
%                       =4, fluid unit and number + calculation point and number
%                   7: Fluid unit calculation point and Gauss point related information:
%                       = 1, enhanced node load (vector); 
%                       = 2, calculated point net water pressure (vector); 
%                       = 3, calculated point flow rate (vector); 
%                       = 4, calculated point opening (vector);
%                       =11, the node load corresponding to the surface force (vector); 
%                       =12, the net water pressure of the fluid unit (cloud diagram); 
%                       =13, the flow rate of the fluid unit (cloud diagram); 
%                       =14, the opening of the fluid unit (cloud diagram),
%                       =21, external normal vector of Gauss point (single point integral) of fluid unit; 
%                       =22, local coordinate system of Gauss point (single point integral) of fluid unit; 
%                       =25, contact force of Gauss point (single point integral) of fluid unit
%                    8: Enriched node (=1, enhanced node; 
%                                      =2, enhanced node + enhanced unit (pure enhanced unit) mesh; 
%                                      =3, enhanced node + FEM node number corresponding to the enhanced node),
%                    9: Grid lines (=1, all grid lines), 10: Blank,
%                    11: Draw the specified unit and its node number (end unit number),
%                    12: All natural cracks (=1, natural cracks; =2, natural cracks + number), 
%                    13: element contact status, 
%                    14:crack number
%                    15:(only draw elements of a given material)
% Line 2, mesh deformation plot: 
%                  Deformation(1),Node(2),El(3),Gauss points(4)
%                  5:Crack Shape. =1,fracture surface; =2,fracture volume; =3, only the crack boundary is drawn (excluding discrete crack grids) and filled with color.
%                  6:Scaling Factor.
%                  7:Boundary Conditions. =1 or =2 or =3.
%                  8: Mesh before deformation. =1, all meshes before deformation; =2, mesh boundary before deformation
%                  9: mesh lines = 0, outer boundary line frame; 
%                                = 1, all grids; 
%                                = 2 (= 12, + number), Enriched element grid + outer boundary line frame; 
%                                = 3, surface grid + outer boundary line frame;
%                                = 4(=14,+number), Enriched element mesh + surface mesh;
%                                = 5(=15,+number), crack tip enhancement element (8 nodes are crack tip enhancement) mesh + outer boundary line frame);
%                                =6 (=16,+number), Heaviside Enriched element (8 nodes are crack tip Enriched) grid + outer boundary wire frame).
%                  10:=1, the local coordinate system of the discrete points on the crack boundary; 
%                     =2, the baseline of the crack tip enrichment element; 
%                     =3, the baseline of the crack tip enrichment element + the baseline local coordinate system; 
%                     =4 , the element corresponding to the crack tip enrichment node (reference element);
%                     =5, crack boundary discrete points and numbers
%                  11:=1, principal stress vector of crack front edge node;
%                  12: Miscellaneous control: =1, draw the crack tip stress calculation point, valid when CFCP=2; 
%                                             =2, draw the Gauss point in the calculation sphere, valid when CFCP=2;
%                                             =3, draw the actual displacement vector of the Enriched node; 
%                                             =4, draw the Enriched degree of freedom displacement vector of the Enriched node; 
%                                             =5, natural cracks.
%                  13: element contact status; 14: Enriched node (=1, Enriched node); 15: Fracture zone
% Line 3, stress (strain) contour:
%                 Nodal Stress (Strain) Contour (=1: stress node value; =2:x slice; =3:y slice; =4:z slice; =11, node strain value) ,
%                 component (2:=1,Only Mises stress;=2,only x component;=3,only y component;=4,only z component),
%                 principal stress (3:1, principal stress; 2, principal stress + direction; 3, maximum principal stress only), x or y or z slice location (4),
%                 Blank(5),Scaling Factor(6),
%                 undeformed or Deformed(8),mesh(9),
%                 Drawing coordinate system (10: 1, Cartesian coordinate system; 2, cylindrical coordinate system),
%                 Blank(11),Blank(12),Blank(13),Blank(14),Slice location(15).
% Line 4, displacement contour: 
%                              Nodal Displacement Contour(=1: node value contour;=2:x slice;=3:y slice;=4:z slice),
%                              (2=1,only x;=2,only y;=3,only z;=4,only vector sum, does not work for Slice),Blank(3),Blank(4),
%                              Plot crack(5=1),Scaling Factor(6),
%                              Blank(7),Blank(8),mesh(9),
%                              Drawing coordinate system (10: 1, Cartesian coordinate system; 2, cylindrical coordinate system),
%                              Blank(11),Blank(12),Blank(13),Blank(14),Slice location(15)
% Line 5, crack aperture: 1: Plot Crack Contour(=1,aperture contour;
%                                               =21, xx permeability contour, 
%                                               =22, yy permeability contour, 
%                                               =23, zz permeability contour, 
%                                               =24, xy permeability contour, 
%                                               =25, yz permeability contour, 
%                                               =26, xz permeability contour),
%                   2: =1, results of fluid elements and nodes; =2, results of discrete crack surface
%                   3-crack surface grid lines,
%                   4-For permeability plots, =0 is SI elements, =1 is mDarcy,
%                   5: Number drawing: =1, draw the fracture surface discrete point number (or fluid node number); 
%                                      =2, draw the fracture surface discrete element number (or fluid element number)
%                   6:Scaling Factor,7-Blank,8-Blank,
%                   9: mesh lines (=0, outer boundary wire frame; =1, all grids; =2, Enriched element grid + outer boundary wire frame; 
%                                  =3, surface grid + outer boundary wire frame; =4, Enriched element mesh mesh + surface mesh;
%                                  =5, Enriched element mesh), Blank(10), Blank(11),
%                   12: All natural cracks (=1, natural cracks; =2, natural cracks + number), Blank(13), Blank(14), Blank(15)

% Line 6, Plot curves:    (1=1, draw a curve),
%                         (2=1, draw the maximum principal stress curve of Vertex at the crack front;
%                           =2, draw the Keq curve of the equivalent stress intensity factor of Vertex at the crack front;
%                           =3, draw the I-type stress intensity factor KI curve of Vertex at the crack front;
%                           =4, draw the type II stress intensity factor KII curve of Vertex at the crack front;
%                           =5, draw the Type I stress intensity factor KIII curve of Vertex at the crack front;
%                           =6, draw the type I + type II + type III stress intensity factor KIII curve of Vertex at the crack front;
%                           =7, draw the pressure-time curve of HF analysis;
%                           =8, draw the pressure-expansion step curve of HF analysis);
%                           =9, draw the expansion step-crack volume curve;
%                           =10, draw the fracturing experiment simulation time-pressure curve.
%                           crack number (3), 4:=1 draws the data before smoothing, 5: wellbore number (=-999, draw all), 6: time element (=1,min;=2,s), Blank(6 -15)
% Line 7, other drawings: 1: =1, draw the element permeability (element is mDarcy) slice contour (note that it is the element result contour);
%                         2 (=1, x-axis slice, =2, y-axis slice, =3 , z-axis slice); 3 (slice coordinates); 4 (=1 draws element grid lines);
%                         5(=1, coordinate axis); 6(=1, log graph); 7-15(blank)
%      
%             
Location=  11.0;    %Key_PLOT(7,:),Slice Location. 
%       
%                         1    2         3    4    5   6              7    8   9  10      11    12  13  14          15
Key_PLOT(1,:)         = [ 1,   0,        0,   0,   1,  0,             0,   0,  0  ,0     ,0     ,0  ,0  ,0  ,       0];  
Key_PLOT(2,:)         = [ 1,   0,        0,   0,   1,  Defor_Factor,  0,   0,  0  ,0     ,0     ,5  ,0  ,0  ,       0];  
Key_PLOT(3,:)         = [ 0,   1,        0,   0,   0,  Defor_Factor,  0,   0,  0  ,1     ,0     ,0  ,0  ,0  ,Location];  
Key_PLOT(4,:)         = [ 0,   1,        0,   0,   1,  Defor_Factor,  0,   0,  0  ,1     ,0     ,0  ,0  ,0  ,Location];
Key_PLOT(5,:)         = [ 1 ,  2,        0,   1,   0,  Defor_Factor,  0,   0,  0  ,0     ,0     ,0  ,0  ,0  ,       0];   
Key_PLOT(6,:)         = [ 0,   7,        1,   1,-999,  2,             0,   0,  0  ,0     ,0     ,0  ,0  ,0  ,       0];   
Key_PLOT(7,:)         = [ 0,   3, Location,   1,   0,  1,             0,   0,  0  ,0     ,0     ,0  ,0  ,0  ,       0];   


Key_Plot_Elements = 1; % Draws the specified cell (Elements_to_be_Ploted). 
Key_Plot_EleGauss = 1; % Draws the Gauss integration point of the specified cell (for fixed integration algorithm only. *Key_Integral_Sol = 2). 

% Elements_to_be_Ploted = [10140,10165];
% EleGauss_to_be_Ploted = [10140,10165];

%###########################################################################################################
%##########################            End of user defined part        #####################################
%###########################################################################################################

PhiPsi_Post_1_Go_3D

% exit
