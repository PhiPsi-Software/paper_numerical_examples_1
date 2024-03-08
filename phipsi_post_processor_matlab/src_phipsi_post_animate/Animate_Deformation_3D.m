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

function Animate_Deformation_3D(Real_num_iteration)
% This function generates the animation of the mesh deformation.

global Node_Coor Elem_Node Outline
global Num_Elem Version Num_Node
global Key_PLOT Full_Pathname Key_Dynamic Foc_x Foc_y
global Size_Font num_Crack Color_Crack
global Color_outline_Udefor Color_Backgro_Defor_1
global aveg_area_ele Time_Delay delt_time_NewMark Width_Crack
global Output_Freq num_of_Material
global Color_Backgro_Defor_1 Color_Backgro_Defor_2 Color_Backgro_Defor_3 Color_Backgro_Defor_4
global Color_Backgro_Defor_5 Color_Backgro_Defor_6 Color_Backgro_Defor_7
global Color_Backgro_Defor_8 Color_Backgro_Defor_9 Color_Backgro_Defor_10
global Elem_Material Key_Crush Color_Crushed_ele
global Num_Foc_x Num_Foc_y Itera_Num Itera_HF_Time
global Na_Crack_X Na_Crack_Y num_Na_Crack Key_HF_Analysis
global frac_zone_min_x frac_zone_max_x frac_zone_min_y frac_zone_max_y
global num_Hole Hole_Coor Enriched_Node_Type_Hl POS_Hl Elem_Type_Hl
global num_Circ_Inclusion Circ_Inclu_Coor Enriched_Node_Type_Incl POS_Incl Elem_Type_Incl
global Color_Inclusion
global num_Poly_Inclusion Poly_Incl_Coor_x Poly_Incl_Coor_y
global Key_Time_String
global Ele_Cross_Point_RABCD
global Key_Data_Format
global Key_Animation Key_Ani_Ave Arc_Crack_Coor
global Key_POST_HF
global Min_X_Coor Max_X_Coor Min_Y_Coor Max_Y_Coor Min_Z_Coor Max_Z_Coor
global Elem_Fontcolor Elem_Fontsize Node_Fontcolor Node_Fontsize
global Num_Step_to_Plot DISP
global Foc_x Foc_y Num_Foc_z Foc_z FORCE_Matrix
global Key_Data_Format
global Crack_node_X Crack_node_Y Crack_node_Z
global Crack_Ele_1 Crack_Ele_2 Crack_Ele_3
global Model_Outline
global Num_Bou_x Num_Bou_y Num_Bou_z Bou_x Bou_y Bou_z
global Crack_node_local_X Crack_node_local_Y Crack_node_local_Z
global Crack_Node_in_Ele
global Crack3D_Vector_S1_X Crack3D_Vector_S1_Y Crack3D_Vector_S1_Z
global Title_Font Key_Figure_Control_Widget
global num_Wellbore num_Points_WB_1 num_Points_WB_2 num_Points_WB_3 num_Points_WB_4 num_Points_WB_5
global Wellbore_1 Wellbore_2 Wellbore_3 Wellbore_4 Wellbore_5 Frac_Stage_Points
global Key_Axis_NE
global Crack3D_NF_nfcx Crack3D_NF_nfcy Crack3D_NF_nfcz Num_NF_3D

disp('    Generating deformation animations......')

%********************************************************
%生成随机颜色:用于不同裂缝面的颜色. IMPROV-2022071401.
%********************************************************
myMap = rand(5000,3);  %随机颜色		

%*************************************************
% Get the max and min value of displacements
%*************************************************
disp(['    > Calculating the coordinates range of the deformed mesh......'])
Min_X_Coor_New = zeros(Real_num_iteration,1);
Max_X_Coor_New = zeros(Real_num_iteration,1);
Min_Y_Coor_New = zeros(Real_num_iteration,1);
Max_Y_Coor_New = zeros(Real_num_iteration,1);
Min_Z_Coor_New = zeros(Real_num_iteration,1);
Max_Z_Coor_New = zeros(Real_num_iteration,1);
for i=1:Real_num_iteration
    if mod(i,Output_Freq)==0
		if Key_Data_Format==1
			DISP   = load([Full_Pathname,'.disn_',num2str(Itera_Num(i))]);
		elseif Key_Data_Format==2  %Binary
			c_file = fopen([Full_Pathname,'.disn_',num2str(Itera_Num(i))],'rb');
			[cc_DISP,cc_count]   = fread(c_file,inf,'double');
			fclose(c_file);
			%转换成Matlab中的数据格式
			Tem_DISP = (reshape(cc_DISP,3,cc_count/3))';
			DISP(1:cc_count/3,1) = 1:cc_count/3;
			DISP(1:cc_count/3,2:4) = Tem_DISP(1:cc_count/3,1:3);
			% for ccc_i=1:cc_count/3
				% DISP(ccc_i,1) = ccc_i;
				% DISP(ccc_i,2) = cc_DISP(ccc_i*3-2);
				% DISP(ccc_i,3) = cc_DISP(ccc_i*3-1);
				% DISP(ccc_i,4) = cc_DISP(ccc_i*3);
			% end
		end


		scale = Key_PLOT(2,6);
		% Get the new coordinates of all nodes
		New_Node_Coor(:,1) = Node_Coor(:,1) + scale*DISP(1:Num_Node,2);
		New_Node_Coor(:,2) = Node_Coor(:,2) + scale*DISP(1:Num_Node,3);
		New_Node_Coor(:,3) = Node_Coor(:,3) + scale*DISP(1:Num_Node,4);
		clear DISP
		% Get the maximum and minimum value of the new coordinates of all nodes
		Min_X_Coor_New(i) = min(min(New_Node_Coor(:,1)));
		Max_X_Coor_New(i) = max(max(New_Node_Coor(:,1)));
		Min_Y_Coor_New(i) = min(min(New_Node_Coor(:,2)));
		Max_Y_Coor_New(i) = max(max(New_Node_Coor(:,2)));
		Min_Z_Coor_New(i) = min(min(New_Node_Coor(:,3)));
		Max_Z_Coor_New(i) = max(max(New_Node_Coor(:,3)));
	end
end

Last_Min_X = min(Min_X_Coor_New);
Last_Max_X = max(Max_X_Coor_New);
Last_Min_Y = min(Min_Y_Coor_New);
Last_Max_Y = max(Max_Y_Coor_New);
Last_Min_Z = min(Min_Z_Coor_New);
Last_Max_Z = max(Max_Z_Coor_New);

c_X_Length = Last_Max_X-Last_Min_X;
c_Y_Length = Last_Max_Y-Last_Min_Y;
c_Z_Length = Last_Max_Z-Last_Min_Z;

%************************************
% Read Boundary file if necessary
%************************************
if Key_PLOT(2,7) == 2 || Key_PLOT(2,7) == 3
	Boundary_X_Matrix = load([Full_Pathname,'.boux']);
	Boundary_Y_Matrix = load([Full_Pathname,'.bouy']);
	Boundary_Z_Matrix = load([Full_Pathname,'.bouz']);
end
% Read outl file.
if Key_Data_Format==1 
	Model_Outline = load([Full_Pathname,'.outl']);
elseif Key_Data_Format==2  %Binary
	c_file = fopen([Full_Pathname,'.outl'],'rb');
	[cc_Model_Outline,cc_count]   = fread(c_file,inf,'int');
	fclose(c_file);
	Model_Outline = (reshape(cc_Model_Outline,2,cc_count/2))';
end

%********************************************
% Get the total force matrix(fx ,fy ,fsum).
%********************************************
FORCE_Matrix = zeros(Num_Node,3);
for i=1:Num_Foc_x
    c_node = Foc_x(i,1);
	FORCE_Matrix(c_node,1) = Foc_x(i,2);
end
for i=1:Num_Foc_y
    c_node = Foc_y(i,1);
	FORCE_Matrix(c_node,2) = Foc_y(i,2);
end
for i=1:Num_Foc_z
    c_node = Foc_z(i,1);
	FORCE_Matrix(c_node,3) = Foc_z(i,2);
end
for i=1:Num_Node
    FORCE_Matrix(i,3) = sqrt(FORCE_Matrix(i,1)^2+FORCE_Matrix(i,2)^2+FORCE_Matrix(i,3)^2);
end

%读取*wbfp文件. 2022-07-14.
if exist([Full_Pathname,'.wbfp'], 'file') ==2 
	Frac_Stage_Points   = load([Full_Pathname,'.wbfp']);
else
    Frac_Stage_Points   = [];
end

% 读取3D天然裂缝坐标. 2023-01-19. 仅支持矩形和多边形天然裂缝. NEWFTU-2023010901.
if exist([Full_Pathname,'.nfcx'], 'file') ==2
    disp('    > Reading *.nfcx, *.nfcy, *.nfcz files....') 
	file_nfcx = fopen([Full_Pathname,'.nfcx']);
    %获得文件行数，即为天然裂缝数目.
	Num_NF_3D = 0;
	c_count = 0;
	while ~feof(file_nfcx)
		Num_NF_3D = Num_NF_3D+1;
		fgetl(file_nfcx);
	end
	fclose(file_nfcx);
	
	%读取文件数据.
	file_nfcx = fopen([Full_Pathname,'.nfcx']);
	file_nfcy = fopen([Full_Pathname,'.nfcy']);
	file_nfcz = fopen([Full_Pathname,'.nfcz']);
	
	Crack3D_NF_nfcx = cell(Num_NF_3D);
	Crack3D_NF_nfcy = cell(Num_NF_3D);
	Crack3D_NF_nfcz = cell(Num_NF_3D);
	
	for i=1:Num_NF_3D 
		Crack3D_NF_nfcx{i} = str2num(fgetl(file_nfcx));
		Crack3D_NF_nfcy{i} = str2num(fgetl(file_nfcy));
		Crack3D_NF_nfcz{i} = str2num(fgetl(file_nfcz));
	end
	fclose(file_nfcx);
	fclose(file_nfcy);
	fclose(file_nfcz);
else
	Crack3D_NF_nfcx=[];
	Crack3D_NF_nfcy=[];
	Crack3D_NF_nfcz=[];
end	

%*************************************************
% Loop through each frame to plot and store.
%*************************************************
xi_1 =[];yi_1 =[];
xi_2 =[];yi_2 =[];
xi_3 =[];yi_3 =[];
xi_4 =[];yi_4 =[];
xi_5 =[];yi_5 =[];
xi_6 =[];yi_6 =[];
xi_7 =[];yi_7 =[];
xi_8 =[];yi_8 =[];
xi_9 =[];yi_9 =[];
xi_10 =[];yi_10 =[];

i_output=0;
for i_p=1:Real_num_iteration
	if mod(i_p,Output_Freq)==0
	    i_output = i_output + 1;
		disp(['    > Plotting and saving the deformation figure of frame ',num2str(i_p),'......'])
		if Key_Data_Format==1
			DISP   = load([Full_Pathname,'.disn_',num2str(Itera_Num(i_p))]);
		elseif Key_Data_Format==2  %Binary
			c_file = fopen([Full_Pathname,'.disn_',num2str(Itera_Num(i_p))],'rb');
			[cc_DISP,cc_count]   = fread(c_file,inf,'double');
			fclose(c_file);
			%转换成Matlab中的数据格式
			Tem_DISP = (reshape(cc_DISP,3,cc_count/3))';
			DISP(1:cc_count/3,1) = 1:cc_count/3;
			DISP(1:cc_count/3,2:4) = Tem_DISP(1:cc_count/3,1:3);
			% for ccc_i=1:cc_count/3
				% DISP(ccc_i,1) = ccc_i;
				% DISP(ccc_i,2) = cc_DISP(ccc_i*3-2);
				% DISP(ccc_i,3) = cc_DISP(ccc_i*3-1);
				% DISP(ccc_i,4) = cc_DISP(ccc_i*3);
			% end
		end
		
		%读取离散裂缝面外边界节点
		if exist([Full_Pathname,'.cmso_',num2str(Itera_Num(i_p))], 'file') ==2 
			file_Crack3D_Meshed_Outline= fopen([Full_Pathname,'.cmso_',num2str(Itera_Num(i_p))]);
			Crack3D_Meshed_Outline = cell(num_Crack(i_p));
			for i=1:num_Crack(i_p) 
				Crack3D_Meshed_Outline{i} = str2num(fgetl(file_Crack3D_Meshed_Outline));
			end
			fclose(file_Crack3D_Meshed_Outline);
		else
			Crack3D_Meshed_Outline=[];
		end
		
		%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		% Read coordinates and all other information of cracks if cracks exist.
		%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		% if num_Crack(Real_num_iteration) ~=0
		if num_Crack(i_p) ~= 0
			disp('    > Reading coordinates of cracks....')
			file_Crack_X = fopen([Full_Pathname,'.crax_',num2str(Itera_Num(i_p))]);
			file_Crack_Y = fopen([Full_Pathname,'.cray_',num2str(Itera_Num(i_p))]);
			file_Crack_Z = fopen([Full_Pathname,'.craz_',num2str(Itera_Num(i_p))]);
			Crack_X = cell(num_Crack(Itera_Num(i_p)));
			Crack_Y = cell(num_Crack(Itera_Num(i_p)));
			Crack_Z = cell(num_Crack(Itera_Num(i_p)));
			for i=1:num_Crack(Itera_Num(i_p))
				Crack_X{i} = str2num(fgetl(file_Crack_X));
				Crack_Y{i} = str2num(fgetl(file_Crack_Y));
				Crack_Z{i} = str2num(fgetl(file_Crack_Z));
			end
			fclose(file_Crack_X);
			fclose(file_Crack_Y);
			fclose(file_Crack_Z);

			% disp('    > Reading ennd file....')
			if Key_Data_Format==1 
				Enriched_Node_Type = load([Full_Pathname,'.ennd_',num2str(Itera_Num(i_p))]);
			elseif Key_Data_Format==2  %Binary
				c_file = fopen([Full_Pathname,'.ennd_',num2str(Itera_Num(i_p))],'rb');
				% [cc_Enriched_Node_Type,cc_count]   = fread(c_file,inf,'int8'); %适配Fortran Kind=1. IMPROV-2022091801.
				[cc_Enriched_Node_Type,cc_count]   = fread(c_file,inf,'int'); 
				fclose(c_file);
				
				% cc_count
				% num_Crack(Itera_Num(i_p))
				% Num_Node
				% num_Crack(i_p)
				
				%转换成Matlab中的数据格式
				Enriched_Node_Type = (reshape(cc_Enriched_Node_Type,num_Crack(Itera_Num(i_p)),Num_Node))';
			end				
			% disp('    > Reading posi file....')
			if Key_Data_Format==1 
				POS = load([Full_Pathname,'.posi_',num2str(Itera_Num(i_p))]);
			elseif Key_Data_Format==2  %Binary
				c_file = fopen([Full_Pathname,'.posi_',num2str(Itera_Num(i_p))],'rb');
				[cc_POS,cc_count]   = fread(c_file,inf,'int');
				fclose(c_file);
				%转换成Matlab中的数据格式
				POS = (reshape(cc_POS,num_Crack(Itera_Num(i_p)),Num_Node))';
			end			
			% disp('    > Reading elty file....');
			if Key_Data_Format==1 
			    Elem_Type = load([Full_Pathname,'.elty_',num2str(Itera_Num(i_p))]);
			elseif Key_Data_Format==2  %Binary
				c_file = fopen([Full_Pathname,'.elty_',num2str(Itera_Num(i_p))],'rb');
				% [cc_Elem_Type,cc_count]   = fread(c_file,inf,'int8'); %适配Fortran Kind=1. IMPROV-2022091801.
				[cc_Elem_Type,cc_count]   = fread(c_file,inf,'int'); 
				fclose(c_file);
				%转换成Matlab中的数据格式
				Elem_Type = (reshape(cc_Elem_Type,num_Crack(Itera_Num(i_p)),Num_Elem))';
			end	
			%读取裂缝面节点坐标
			file_Crack_node_X = fopen([Full_Pathname,'.cnox_',num2str(Itera_Num(i_p))]);
			file_Crack_node_Y = fopen([Full_Pathname,'.cnoy_',num2str(Itera_Num(i_p))]);
			file_Crack_node_Z = fopen([Full_Pathname,'.cnoz_',num2str(Itera_Num(i_p))]);
			Crack_node_X = cell(num_Crack(Itera_Num(i_p)));
			Crack_node_Y = cell(num_Crack(Itera_Num(i_p)));
			Crack_node_Z = cell(num_Crack(Itera_Num(i_p)));
			for i=1:num_Crack(Itera_Num(i_p))
				Crack_node_X{i} = str2num(fgetl(file_Crack_node_X));
				Crack_node_Y{i} = str2num(fgetl(file_Crack_node_Y));
				Crack_node_Z{i} = str2num(fgetl(file_Crack_node_Z));
			end
			fclose(file_Crack_node_X);
			fclose(file_Crack_node_Y);
			fclose(file_Crack_node_Z);
			if Key_Data_Format==1 
				Post_Enriched_Nodes = load([Full_Pathname,'.ennd_',num2str(Itera_Num(i_p))]);
			elseif Key_Data_Format==2  %Binary
				c_file = fopen([Full_Pathname,'.ennd_',num2str(Itera_Num(i_p))],'rb');
				% [cc_Post_Enriched_Nodes,cc_count]   = fread(c_file,inf,'int8'); %适配Fortran Kind=1. IMPROV-2022091801.
				[cc_Post_Enriched_Nodes,cc_count]   = fread(c_file,inf,'int'); 
				fclose(c_file);
				%转换成Matlab中的数据格式
				Post_Enriched_Nodes = (reshape(cc_Post_Enriched_Nodes,num_Crack(Itera_Num(i_p)),Num_Node))';
			end	
			%读取裂缝面节点所在单元局部坐标
			if exist([Full_Pathname,'.cnlx_',num2str(Itera_Num(i_p))], 'file') ==2
				file_Crack_node_local_X = fopen([Full_Pathname,'.cnlx_',num2str(Itera_Num(i_p))]);
				file_Crack_node_local_Y = fopen([Full_Pathname,'.cnly_',num2str(Itera_Num(i_p))]);
				file_Crack_node_local_Z = fopen([Full_Pathname,'.cnlz_',num2str(Itera_Num(i_p))]);
				Crack_node_local_X = cell(num_Crack(Itera_Num(i_p)));
				Crack_node_local_Y = cell(num_Crack(Itera_Num(i_p)));
				Crack_node_local_Z = cell(num_Crack(Itera_Num(i_p)));
				for i=1:num_Crack(Itera_Num(i_p))
					Crack_node_local_X{i} = str2num(fgetl(file_Crack_node_local_X));
					Crack_node_local_Y{i} = str2num(fgetl(file_Crack_node_local_Y));
					Crack_node_local_Z{i} = str2num(fgetl(file_Crack_node_local_Z));
				end
				fclose(file_Crack_node_local_X);
				fclose(file_Crack_node_local_Y);
				fclose(file_Crack_node_local_Z);
            else
                Crack_node_local_X = [];Crack_node_local_Y = [];Crack_node_local_Z = [];					
			end		
			
			%读取裂缝面离散单元
			if exist([Full_Pathname,'.cms1_',num2str(Itera_Num(i_p))], 'file') ==2
				file_Crack_Ele_1 = fopen([Full_Pathname,'.cms1_',num2str(Itera_Num(i_p))]);
				file_Crack_Ele_2 = fopen([Full_Pathname,'.cms2_',num2str(Itera_Num(i_p))]);
				file_Crack_Ele_3 = fopen([Full_Pathname,'.cms3_',num2str(Itera_Num(i_p))]);
				Crack_Ele_1 = cell(num_Crack(Itera_Num(i_p)));
				Crack_Ele_2 = cell(num_Crack(Itera_Num(i_p)));
				Crack_Ele_3 = cell(num_Crack(Itera_Num(i_p)));
				for i=1:num_Crack(Itera_Num(i_p))
					Crack_Ele_1{i} = str2num(fgetl(file_Crack_Ele_1));
					Crack_Ele_2{i} = str2num(fgetl(file_Crack_Ele_2));
					Crack_Ele_3{i} = str2num(fgetl(file_Crack_Ele_3));
				end
				fclose(file_Crack_Ele_1);
				fclose(file_Crack_Ele_2);
				fclose(file_Crack_Ele_3);
            else
			    Crack_Ele_1 = [];Crack_Ele_2 = [];Crack_Ele_3 = [];
			end
			
			%读取裂缝面离散单元节点所在的单元号（模型单元号）
			if exist([Full_Pathname,'.cmse_',num2str(Itera_Num(i_p))], 'file') ==2			
				file_Crack_Node_in_Ele = fopen([Full_Pathname,'.cmse_',num2str(Itera_Num(i_p))]);
				Crack_Node_in_Ele = cell(num_Crack(Itera_Num(i_p)));
				for i=1:num_Crack(Itera_Num(i_p))
					Crack_Node_in_Ele{i} = str2num(fgetl(file_Crack_Node_in_Ele));
				end
				fclose(file_Crack_Node_in_Ele);
            else
			    Crack_Node_in_Ele = [];
			end		
		else
			Crack_X = [];   Crack_Y = [];  Crack_Z = [];
			Enriched_Node_Type = [];
			Elem_Type = [];x_cr_tip_nodes=[];y_cr_tip_nodes=[];
			POS = []; Coors_Element_Crack= [];Coors_Vertex= [];
			Coors_Junction= []; Coors_Tip= []; Elem_Type= [];
			Crack_Tip_Type= [];Node_Jun_elem=[];Node_Cross_elem=[];
			Crack_node_X=[];Crack_node_Y=[];Crack_node_Z=[];
			Crack_Ele_1 =[];Crack_Ele_2 =[];Crack_Ele_3 =[];
			Crack_node_local_X=[];Crack_node_local_Y=[];Crack_node_local_Z=[];
			Crack_Node_in_Ele =[];
            Post_Enriched_Nodes	=[];
		end


		% Get the new coordinates of all nodes.
		New_Node_Coor(1:Num_Node,1) = Node_Coor(1:Num_Node,1) + scale*DISP(1:Num_Node,2);
		New_Node_Coor(1:Num_Node,2) = Node_Coor(1:Num_Node,2) + scale*DISP(1:Num_Node,3);
		New_Node_Coor(1:Num_Node,3) = Node_Coor(1:Num_Node,3) + scale*DISP(1:Num_Node,4);


		% Get the maximum and minimum value of the new coordinates of all nodes.
		Min_X_Coor_New = min(min(New_Node_Coor(1:Num_Node,1)));
		Max_X_Coor_New = max(max(New_Node_Coor(1:Num_Node,1)));
		Min_Y_Coor_New = min(min(New_Node_Coor(1:Num_Node,2)));
		Max_Y_Coor_New = max(max(New_Node_Coor(1:Num_Node,2)));
		Min_Z_Coor_New = min(min(New_Node_Coor(1:Num_Node,3)));
		Max_Z_Coor_New = max(max(New_Node_Coor(1:Num_Node,3)));



		% New figure.
		Tools_New_Figure
		hold on;
		title('Deformation','FontName',Title_Font,'FontSize',Size_Font)
		axis off;
		axis equal;
		delta = sqrt(aveg_area_ele);
		axis([Min_X_Coor_New-delta Max_X_Coor_New+delta ...
			  Min_Y_Coor_New-delta Max_Y_Coor_New+delta ...
			  Min_Z_Coor_New-delta Max_Z_Coor_New+delta]);
		% Set Viewpoint
		PhiPsi_Viewing_Angle_Settings

		%绘制单元面
		Color_3D_ele_face = [189/255,252/255,201/255];
		FaceAlpha_3D_ele_face = 0.8;
		if Key_PLOT(2,3) == 1
		  for iElem = 1:Num_Elem
			NN = [Elem_Node(iElem,1) Elem_Node(iElem,2) ...
				  Elem_Node(iElem,3) Elem_Node(iElem,4) ...
				  Elem_Node(iElem,5) Elem_Node(iElem,6) ...
				  Elem_Node(iElem,7) Elem_Node(iElem,8)];                             % Nodes for current element
				  %绘制第1个面
				  c_x = [New_Node_Coor(NN(1),1),New_Node_Coor(NN(2),1),New_Node_Coor(NN(3),1),New_Node_Coor(NN(4),1)];
				  c_y = [New_Node_Coor(NN(1),2),New_Node_Coor(NN(2),2),New_Node_Coor(NN(3),2),New_Node_Coor(NN(4),2)];
				  c_z = [New_Node_Coor(NN(1),3),New_Node_Coor(NN(2),3),New_Node_Coor(NN(3),3),New_Node_Coor(NN(4),3)];
				  % fill3(c_x,c_y,c_z,Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face,'FaceLighting','gouraud')
				  fill3(c_x,c_y,c_z,Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
				  %绘制第2个面
				  c_x = [New_Node_Coor(NN(5),1),New_Node_Coor(NN(6),1),New_Node_Coor(NN(7),1),New_Node_Coor(NN(8),1)];
				  c_y = [New_Node_Coor(NN(5),2),New_Node_Coor(NN(6),2),New_Node_Coor(NN(7),2),New_Node_Coor(NN(8),2)];
				  c_z = [New_Node_Coor(NN(5),3),New_Node_Coor(NN(6),3),New_Node_Coor(NN(7),3),New_Node_Coor(NN(8),3)];
				  % fill3(c_x,c_y,c_z,Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face,'FaceLighting','gouraud')
				  fill3(c_x,c_y,c_z,Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
				  %绘制第3个面
				  c_x = [New_Node_Coor(NN(1),1),New_Node_Coor(NN(2),1),New_Node_Coor(NN(6),1),New_Node_Coor(NN(5),1)];
				  c_y = [New_Node_Coor(NN(1),2),New_Node_Coor(NN(2),2),New_Node_Coor(NN(6),2),New_Node_Coor(NN(5),2)];
				  c_z = [New_Node_Coor(NN(1),3),New_Node_Coor(NN(2),3),New_Node_Coor(NN(6),3),New_Node_Coor(NN(5),3)];
				  % fill3(c_x,c_y,c_z,Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face,'FaceLighting','gouraud')
				  fill3(c_x,c_y,c_z,Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
				  %绘制第4个面
				  c_x = [New_Node_Coor(NN(2),1),New_Node_Coor(NN(3),1),New_Node_Coor(NN(7),1),New_Node_Coor(NN(6),1)];
				  c_y = [New_Node_Coor(NN(2),2),New_Node_Coor(NN(3),2),New_Node_Coor(NN(7),2),New_Node_Coor(NN(6),2)];
				  c_z = [New_Node_Coor(NN(2),3),New_Node_Coor(NN(3),3),New_Node_Coor(NN(7),3),New_Node_Coor(NN(6),3)];
				  % fill3(c_x,c_y,c_z,Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face,'FaceLighting','gouraud')
				  fill3(c_x,c_y,c_z,Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
				  %绘制第5个面
				  c_x = [New_Node_Coor(NN(7),1),New_Node_Coor(NN(8),1),New_Node_Coor(NN(4),1),New_Node_Coor(NN(3),1)];
				  c_y = [New_Node_Coor(NN(7),2),New_Node_Coor(NN(8),2),New_Node_Coor(NN(4),2),New_Node_Coor(NN(3),2)];
				  c_z = [New_Node_Coor(NN(7),3),New_Node_Coor(NN(8),3),New_Node_Coor(NN(4),3),New_Node_Coor(NN(3),3)];
				  % fill3(c_x,c_y,c_z,Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face,'FaceLighting','gouraud')
				  fill3(c_x,c_y,c_z,Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
				  %绘制第6个面
				  c_x = [New_Node_Coor(NN(5),1),New_Node_Coor(NN(1),1),New_Node_Coor(NN(4),1),New_Node_Coor(NN(8),1)];
				  c_y = [New_Node_Coor(NN(5),2),New_Node_Coor(NN(1),2),New_Node_Coor(NN(4),2),New_Node_Coor(NN(8),2)];
				  c_z = [New_Node_Coor(NN(5),3),New_Node_Coor(NN(1),3),New_Node_Coor(NN(4),3),New_Node_Coor(NN(8),3)];
				  % fill3(c_x,c_y,c_z,Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face,'FaceLighting','gouraud')
				  fill3(c_x,c_y,c_z,Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
		  end
		end


		%绘制变形后的网格
		Line_width =0.1;
		if Key_PLOT(2,1)==1
			if Key_PLOT(2,9)==1
				for iElem = 1:Num_Elem
					NN = [Elem_Node(iElem,1) Elem_Node(iElem,2) ...
						  Elem_Node(iElem,3) Elem_Node(iElem,4) ...
						  Elem_Node(iElem,5) Elem_Node(iElem,6) ...
						  Elem_Node(iElem,7) Elem_Node(iElem,8)];                             % Nodes for current element
					for i=1:3
						plot3([New_Node_Coor(NN(i),1),New_Node_Coor(NN(i+1),1)],...
							  [New_Node_Coor(NN(i),2),New_Node_Coor(NN(i+1),2)],...
							  [New_Node_Coor(NN(i),3),New_Node_Coor(NN(i+1),3)],'LineWidth',Line_width,'Color',[.5 .5 .5])
					end
					for i=5:7
						plot3([New_Node_Coor(NN(i),1),New_Node_Coor(NN(i+1),1)],...
							  [New_Node_Coor(NN(i),2),New_Node_Coor(NN(i+1),2)],...
							  [New_Node_Coor(NN(i),3),New_Node_Coor(NN(i+1),3)],'LineWidth',Line_width,'Color',[.5 .5 .5])
					end
					for i=1:4
						plot3([New_Node_Coor(NN(i),1),New_Node_Coor(NN(i+4),1)],...
							  [New_Node_Coor(NN(i),2),New_Node_Coor(NN(i+4),2)],...
							  [New_Node_Coor(NN(i),3),New_Node_Coor(NN(i+4),3)],'LineWidth',Line_width,'Color',[.5 .5 .5])
					end
					plot3([New_Node_Coor(NN(1),1),New_Node_Coor(NN(4),1)],...
						  [New_Node_Coor(NN(1),2),New_Node_Coor(NN(4),2)],...
						  [New_Node_Coor(NN(1),3),New_Node_Coor(NN(4),3)],'LineWidth',Line_width,'Color',[.5 .5 .5])
					plot3([New_Node_Coor(NN(5),1),New_Node_Coor(NN(8),1)],...
						  [New_Node_Coor(NN(5),2),New_Node_Coor(NN(8),2)],...
						  [New_Node_Coor(NN(5),3),New_Node_Coor(NN(8),3)],'LineWidth',Line_width,'Color',[.5 .5 .5])
				end
			elseif Key_PLOT(2,9) ==0 %仅绘制模型边框(Outlines)
				for i=1:size(Model_Outline,1)
						plot3([New_Node_Coor(Model_Outline(i,1),1),New_Node_Coor(Model_Outline(i,2),1)],...
							  [New_Node_Coor(Model_Outline(i,1),2),New_Node_Coor(Model_Outline(i,2),2)],...
							  [New_Node_Coor(Model_Outline(i,1),3),New_Node_Coor(Model_Outline(i,2),3)],'LineWidth',Line_width,'Color','black')
				end
			end
		end


		%绘制变形前的网格
		Line_width =0.1;
		if Key_PLOT(2,8)==1
			if Key_PLOT(2,9)==1
				for iElem = 1:Num_Elem
					NN = [Elem_Node(iElem,1) Elem_Node(iElem,2) ...
						  Elem_Node(iElem,3) Elem_Node(iElem,4) ...
						  Elem_Node(iElem,5) Elem_Node(iElem,6) ...
						  Elem_Node(iElem,7) Elem_Node(iElem,8)];                             % Nodes for current element
					for i=1:3
						plot3([Node_Coor(NN(i),1),Node_Coor(NN(i+1),1)],...
							  [Node_Coor(NN(i),2),Node_Coor(NN(i+1),2)],...
							  [Node_Coor(NN(i),3),Node_Coor(NN(i+1),3)],'LineWidth',Line_width,'Color','red')
					end
					for i=5:7
						plot3([Node_Coor(NN(i),1),Node_Coor(NN(i+1),1)],...
							  [Node_Coor(NN(i),2),Node_Coor(NN(i+1),2)],...
							  [Node_Coor(NN(i),3),Node_Coor(NN(i+1),3)],'LineWidth',Line_width,'Color','red')
					end
					for i=1:4
						plot3([Node_Coor(NN(i),1),Node_Coor(NN(i+4),1)],...
							  [Node_Coor(NN(i),2),Node_Coor(NN(i+4),2)],...
							  [Node_Coor(NN(i),3),Node_Coor(NN(i+4),3)],'LineWidth',Line_width,'Color','red')
					end
					plot3([Node_Coor(NN(1),1),Node_Coor(NN(4),1)],...
						  [Node_Coor(NN(1),2),Node_Coor(NN(4),2)],...
						  [Node_Coor(NN(1),3),Node_Coor(NN(4),3)],'LineWidth',Line_width,'Color','red')
					plot3([Node_Coor(NN(5),1),Node_Coor(NN(8),1)],...
						  [Node_Coor(NN(5),2),Node_Coor(NN(8),2)],...
						  [Node_Coor(NN(5),3),Node_Coor(NN(8),3)],'LineWidth',Line_width,'Color','red')
				end
			elseif Key_PLOT(2,9) ==0 %仅绘制模型边框(Outlines)
				for i=1:size(Model_Outline,1)
						plot3([Node_Coor(Model_Outline(i,1),1),Node_Coor(Model_Outline(i,2),1)],...
							  [Node_Coor(Model_Outline(i,1),2),Node_Coor(Model_Outline(i,2),2)],...
							  [Node_Coor(Model_Outline(i,1),3),Node_Coor(Model_Outline(i,2),3)],'--','LineWidth',Line_width,'Color',[.5 .5 .5])	%灰色
				end
			end
		end
		
		% 绘制井筒, Plot wellbore, NEWFTU-2022071401.
		if num_Wellbore >=1 
			% disp(['      ----- Plotting wellbore......'])
			plot3(Wellbore_1(1:num_Points_WB_1,1),Wellbore_1(1:num_Points_WB_1,2),Wellbore_1(1:num_Points_WB_1,3),'LineWidth',2,'Color','blue')	
		end
		if num_Wellbore >=2 
			plot3(Wellbore_2(1:num_Points_WB_2,1),Wellbore_2(1:num_Points_WB_2,2),Wellbore_2(1:num_Points_WB_2,3),'LineWidth',2,'Color','blue')	
		end
		if num_Wellbore >=3 
			plot3(Wellbore_3(1:num_Points_WB_2,1),Wellbore_3(1:num_Points_WB_2,2),Wellbore_3(1:num_Points_WB_2,3),'LineWidth',2,'Color','blue')	
		end
		if num_Wellbore >=4 
			plot3(Wellbore_4(1:num_Points_WB_2,1),Wellbore_4(1:num_Points_WB_2,2),Wellbore_4(1:num_Points_WB_2,3),'LineWidth',2,'Color','blue')	
		end
		if num_Wellbore >=5 
			plot3(Wellbore_5(1:num_Points_WB_2,1),Wellbore_5(1:num_Points_WB_2,2),Wellbore_5(1:num_Points_WB_2,3),'LineWidth',2,'Color','blue')	
		end	
		
		%绘制井筒分段点. NEWFTU-2022071401.
		if isempty(Frac_Stage_Points) ==0
			length_min = min(c_X_Length,min(c_Y_Length,c_Z_Length))/5.0; 
			%绘制透明圆球
			for i_Ball = 1:size(Frac_Stage_Points,1)
				r_ball = length_min/10;
				x_cor = Frac_Stage_Points(i_Ball,1);
				y_cor = Frac_Stage_Points(i_Ball,2);
				z_cor = Frac_Stage_Points(i_Ball,3);
				[x_ball,y_ball,z_ball]=sphere(30);
				surf(r_ball*x_ball +x_cor,r_ball*y_ball +y_cor,r_ball*z_ball +z_cor,'FaceColor',[218/255,112/255,214/255],'LineStyle','none','FaceAlpha',0.5); %淡紫色
			end
		end
		
		%绘制坐标轴
		Arrow_length = (c_X_Length+c_Y_Length+c_Z_Length)/15;
		h = Tools_mArrow3([0 0 0],[Arrow_length 0 0],'color','red','stemWidth',Arrow_length/25.0,'tipWidth',Arrow_length/10.0,'facealpha',1.0);
		if Key_Axis_NE==1
			ts = text((c_X_Length+c_Y_Length+c_Z_Length)/14, 0, 0,"X(E)",'Color','red','FontSize',15,'FontName','Consolas','FontAngle','italic');
		else
			ts = text((c_X_Length+c_Y_Length+c_Z_Length)/14, 0, 0,"X",'Color','red','FontSize',15,'FontName','Consolas','FontAngle','italic');
		end
		h = Tools_mArrow3([0 0 0],[0 Arrow_length 0],'color','green','stemWidth',Arrow_length/25.0,'tipWidth',Arrow_length/10.0,'facealpha',1.0);
		if Key_Axis_NE==1 
			ts = text(0,(c_X_Length+c_Y_Length+c_Z_Length)/14,0,"Y(N)",'Color','green','FontSize',15,'FontName','Consolas','FontAngle','italic');
		else
			ts = text(0,(c_X_Length+c_Y_Length+c_Z_Length)/14,0,"Y",'Color','green','FontSize',15,'FontName','Consolas','FontAngle','italic');	
		end
		h = Tools_mArrow3([0 0 0],[0 0 Arrow_length],'color','blue','stemWidth',Arrow_length/25.0,'tipWidth',Arrow_length/10.0,'facealpha',1.0);
		ts = text(0,0,(c_X_Length+c_Y_Length+c_Z_Length)/14,"Z",'Color','blue','FontSize',15,'FontName','Consolas','FontAngle','italic');		

		%绘制载荷
		if Key_PLOT(2,7) == 1 || Key_PLOT(2,7) == 3
			disp(['      ----- Plotting forces of nodes......'])
			Max_x_Force = max(abs(FORCE_Matrix(:,1)));
			Max_y_Force = max(abs(FORCE_Matrix(:,2)));
			Max_z_Force = max(abs(FORCE_Matrix(:,3)));
			Max_Force   = max(Max_x_Force,max(Max_y_Force,Max_z_Force));

			% length of force arrow
			% REMOVE:length_arrow = sqrt(max_area_ele);
			length_arrow = (c_X_Length+c_Y_Length+c_Z_Length)/30.0;

			% Loop through each node.
			for i = 1:Num_Node
				if FORCE_Matrix(i,3) ~=0           % If the nodes has force load, then:
					c_force_x   = FORCE_Matrix(i,1);
					c_force_y   = FORCE_Matrix(i,2);
					c_force_z   = FORCE_Matrix(i,3);
					delta_L_x = c_force_x*length_arrow/Max_Force;
					delta_L_y = c_force_y*length_arrow/Max_Force;
					delta_L_z = c_force_z*length_arrow/Max_Force;

					StartPoint = [New_Node_Coor(i,1)-delta_L_x   New_Node_Coor(i,2)-delta_L_y     New_Node_Coor(i,3)-delta_L_z];
					EndPoint   = [New_Node_Coor(i,1)             New_Node_Coor(i,2)               New_Node_Coor(i,3)          ];
					%plot3([StartPoint(1),EndPoint(1)],[StartPoint(2),EndPoint(2)], [StartPoint(3),EndPoint(3)],'LineWidth',2.0,'Color',[153/255,51/255,250/255]);
					%plot3([StartPoint(1),EndPoint(1)],[StartPoint(2),EndPoint(2)], [StartPoint(3),EndPoint(3)],'LineWidth',1.5,'Color','red');
					h = Tools_mArrow3(StartPoint,EndPoint,'color','red','facealpha',1.0);
				end
			end
		end

		%绘制边界条件
		if Key_PLOT(2,7) == 2 || Key_PLOT(2,7) == 3
			disp(['      ----- Plotting boundary conditions......'])
			length_arrow = (c_X_Length+c_Y_Length+c_Z_Length)/80.0;
			for i = 1:size(Bou_x,1)
				delta_L_x = length_arrow/2;
				StartPoint = [New_Node_Coor(Bou_x(i),1)-delta_L_x   New_Node_Coor(Bou_x(i),2)     New_Node_Coor(Bou_x(i),3)];
				EndPoint   = [New_Node_Coor(Bou_x(i),1)+0   New_Node_Coor(Bou_x(i),2)     New_Node_Coor(Bou_x(i),3)];
				plot3([StartPoint(1),EndPoint(1)],[StartPoint(2),EndPoint(2)], [StartPoint(3),EndPoint(3)],'LineWidth',1.0,'Color','black');
			end
			for i = 1:size(Bou_y,1)
				delta_L_y = length_arrow/2;
				StartPoint = [New_Node_Coor(Bou_y(i),1)   New_Node_Coor(Bou_y(i),2)-delta_L_y     New_Node_Coor(Bou_y(i),3)];
				EndPoint   = [New_Node_Coor(Bou_y(i),1)   New_Node_Coor(Bou_y(i),2)+0     New_Node_Coor(Bou_y(i),3)];
				plot3([StartPoint(1),EndPoint(1)],[StartPoint(2),EndPoint(2)], [StartPoint(3),EndPoint(3)],'LineWidth',1.0,'Color','black');
			end
			for i = 1:size(Bou_z,1)
				delta_L_z = length_arrow/2;
				StartPoint = [New_Node_Coor(Bou_z(i),1)   New_Node_Coor(Bou_z(i),2)     New_Node_Coor(Bou_z(i),3)-delta_L_z];
				EndPoint   = [New_Node_Coor(Bou_z(i),1)   New_Node_Coor(Bou_z(i),2)     New_Node_Coor(Bou_z(i),3)+0];
				plot3([StartPoint(1),EndPoint(1)],[StartPoint(2),EndPoint(2)], [StartPoint(3),EndPoint(3)],'LineWidth',1.0,'Color','black');
			end
		end
		% Plot nodes
		if isempty(Post_Enriched_Nodes) ~= 1
			length_min = min(c_X_Length,min(c_Y_Length,c_Z_Length))/5.0;
			r = length_min/20;
			if Key_PLOT(2,2)==1
				disp(['      ----- Plotting nodes......'])
				for i =1 :size(Post_Enriched_Nodes,2)
					for j =1:Num_Node
						x_node = New_Node_Coor(j,1);
						y_node = New_Node_Coor(j,2);
						z_node = New_Node_Coor(j,3);
						% --------------------
						% option 1: 圆球
						% --------------------
						% [sphere_x,sphere_y,sphere_z] = sphere;
						% s1 = surf(sphere_x*r + x_node, sphere_y*r + y_node, sphere_z*r + z_node);
						% set(s1,'FaceColor',[3/255,168/255,158/255], ...
								  % 'FaceAlpha',1,'FaceLighting','gouraud','EdgeColor','none')  %FaceAlpha表示透明度
						% daspect([1 1 1]);
						% --------------------
						% option 2: 点
						% --------------------
						plot3(x_node,y_node,z_node,'k.','MarkerSize',13.0)    % MarkerSize 表示点的大小,黑色点
					end
				end
			end
		end


		% Plot enriched nodes
		if isempty(Post_Enriched_Nodes) ~= 1
			length_min = min(c_X_Length,min(c_Y_Length,c_Z_Length))/5.0;
			r = length_min/10;
			if Key_PLOT(2,14)==1
				disp(['      ----- Plotting enriched nodes......'])
				for i =1 :size(Post_Enriched_Nodes,2)
					for j =1:Num_Node
						x_node = New_Node_Coor(j,1);
						y_node = New_Node_Coor(j,2);
						z_node = New_Node_Coor(j,3);
						if Post_Enriched_Nodes(j,i)==1     % Tip nodes
							% --------------------
							% option 1: 圆球
							% --------------------
							% [sphere_x,sphere_y,sphere_z] = sphere;
							% surf(sphere_x*r + x_node, sphere_y*r + y_node, sphere_z*r + z_node);
							% --------------------
							% option 2: 点
							% --------------------
							plot3(x_node,y_node,z_node,'r.','MarkerSize',20.0)
						elseif Post_Enriched_Nodes(j,i)==2 % Heaviside nodes
							% --------------------
							% option 1: 圆球
							% --------------------
							% [sphere_x,sphere_y,sphere_z] = sphere;
							% s1 = surf(sphere_x*r + x_node, sphere_y*r + y_node, sphere_z*r + z_node);
							% set(s1,'FaceColor',[0 0 1], ...
								  % 'FaceAlpha',1,'FaceLighting','gouraud','EdgeColor','none')  %FaceAlpha表示透明度
							% daspect([1 1 1]);
							% --------------------
							% option 2: 点
							% --------------------
							plot3(x_node,y_node,z_node,'b.','MarkerSize',20.0)    % MarkerSize 表示点的大小，b.表示绿色的点
						elseif Post_Enriched_Nodes(j,i)==3 % Junction nodes
							% --------------------
							% option 1: 圆球
							% --------------------
							% [sphere_x,sphere_y,sphere_z] = sphere;
							% surf(sphere_x*r + x_node, sphere_y*r + y_node, sphere_z*r + z_node);
							% --------------------
							% option 2: 点
							% --------------------
							plot3(x_node,y_node,z_node,'g.','MarkerSize',20.0)    % MarkerSize 表示点的大小
						end
					end
				end
			end
		end

		%绘制裂缝面(模型之外的离散裂缝面节点不变形)
		if Key_PLOT(2,5) >= 1 && isempty(Crack_Node_in_Ele)==0
			disp(['      ----- Plotting crack surface...'])
			if isempty(Crack_X)==0
				for ii = 1:num_Crack(Itera_Num(i_p))
					nPt = size(Crack_X{ii},2);
					%--------------
					% option 1
					%--------------
					%目前一个裂缝只能由4个点构成
					% c_x = [Crack_X{i}(1:4)];
					% c_y = [Crack_Y{i}(1:4)];
					% c_z = [Crack_Z{i}(1:4)];
					% fill3(c_x,c_y,c_z,'r','FaceAlpha',0.8,'FaceLighting','gouraud')
					%--------------
					% option 2
					%--------------
					%绘制裂缝面离散点
					nnode = size(Crack_node_X{ii},2);
					for j=1:nnode
						c_node_x = [Crack_node_X{ii}(j)];
						c_node_y = [Crack_node_Y{ii}(j)];
						c_node_z = [Crack_node_Z{ii}(j)];
						% 获得离散裂缝面节点所在模型单元号
						c_Ele = Crack_Node_in_Ele{ii}(j);
						if c_Ele==0   %离散裂缝的节点在模型外
							plot3(c_node_x,c_node_y,c_node_z,'c.','MarkerSize',16.0);    % MarkerSize 表示点的大小,青色点
							% ts = text(c_node_x,c_node_y,c_node_z,num2str(j),'Color','black','FontSize',12,'FontName','Consolas','FontAngle','italic');
							Crack_node_X_new{ii}(j) = c_node_x;
							Crack_node_Y_new{ii}(j) = c_node_y;
							Crack_node_Z_new{ii}(j) = c_node_z;
						else          %离散裂缝的节点在模型内
							% Get the local coordinates of the points of the crack.
							Kesi = Crack_node_local_X{ii}(j);
							Yita = Crack_node_local_Y{ii}(j);
							Zeta  = Crack_node_local_Z{ii}(j);
							NN = [Elem_Node(c_Ele,1) Elem_Node(c_Ele,2) ...
								  Elem_Node(c_Ele,3) Elem_Node(c_Ele,4) ...
								  Elem_Node(c_Ele,5) Elem_Node(c_Ele,6) ...
								  Elem_Node(c_Ele,7) Elem_Node(c_Ele,8)];
							% Calculates N, dNdkesi, J and the determinant of Jacobian matrix.
							[N]  = Cal_N_3D(Kesi,Yita,Zeta);
							dis_x(j) =     DISP(NN(1),2)*N(1) + DISP(NN(2),2)*N(2) + DISP(NN(3),2)*N(3) + DISP(NN(4),2)*N(4) ...
										 + DISP(NN(5),2)*N(5) + DISP(NN(6),2)*N(6) + DISP(NN(7),2)*N(7) + DISP(NN(8),2)*N(8);
							dis_y(j) =     DISP(NN(1),3)*N(1) + DISP(NN(2),3)*N(2) + DISP(NN(3),3)*N(3) + DISP(NN(4),3)*N(4) ...
										 + DISP(NN(5),3)*N(5) + DISP(NN(6),3)*N(6) + DISP(NN(7),3)*N(7) + DISP(NN(8),3)*N(8);
							dis_z(j) =     DISP(NN(1),4)*N(1) + DISP(NN(2),4)*N(2) + DISP(NN(3),4)*N(3) + DISP(NN(4),4)*N(4) ...
										 + DISP(NN(5),4)*N(5) + DISP(NN(6),4)*N(6) + DISP(NN(7),4)*N(7) + DISP(NN(8),4)*N(8);
							last_c_node_x = c_node_x +	dis_x(j)*scale;
							last_c_node_y = c_node_y +	dis_y(j)*scale;
							last_c_node_z = c_node_z +	dis_z(j)*scale;
							Crack_node_X_new{ii}(j) = last_c_node_x;
							Crack_node_Y_new{ii}(j) = last_c_node_y;
							Crack_node_Z_new{ii}(j) = last_c_node_z;
							%绘制离散裂缝点
                            if Key_PLOT(2,5) == 2
							    plot3(last_c_node_x,last_c_node_y,last_c_node_z,'c.','MarkerSize',16.0);    % MarkerSize 表示点的大小,青色点
							end
							%显示离散裂缝点编号(测试用)
							% ts = text(c_node_x,c_node_y,c_node_z,num2str(j),'Color','black','FontSize',12,'FontName','Consolas','FontAngle','italic');

							%绘制离散裂缝面边界节点的主应力方向(测试用)
							if Key_PLOT(2,11) == 1
							 % length_arrow = (c_X_Length+c_Y_Length+c_Z_Length)/60.0;
							 % StartPoint = [last_c_node_x last_c_node_y last_c_node_z];
							 % EndPoint   = [last_c_node_x+length_arrow*Crack3D_Vector_S1_X{i}(j)  ...
							               % last_c_node_y+length_arrow*Crack3D_Vector_S1_Y{i}(j)  ...
										   % last_c_node_z+length_arrow*Crack3D_Vector_S1_Z{i}(j)];
						     % h = Tools_mArrow3(StartPoint,EndPoint,'color','m','facealpha',1.0);
                             % EndPoint   = [last_c_node_x-length_arrow*Crack3D_Vector_S1_X{i}(j)  ...
							               % last_c_node_y-length_arrow*Crack3D_Vector_S1_Y{i}(j)  ...
										   % last_c_node_z-length_arrow*Crack3D_Vector_S1_Z{i}(j)];
										   % h = Tools_mArrow3(StartPoint,EndPoint,'color','m','facealpha',1.0);
                            end
						end
					end
					%绘制单元面
					nele = size(Crack_Ele_1{ii},2);
					for j=1:nele
						c_x = [Crack_node_X_new{ii}(Crack_Ele_1{ii}(j)),Crack_node_X_new{ii}(Crack_Ele_2{ii}(j)),Crack_node_X_new{ii}(Crack_Ele_3{ii}(j))];
						c_y = [Crack_node_Y_new{ii}(Crack_Ele_1{ii}(j)),Crack_node_Y_new{ii}(Crack_Ele_2{ii}(j)),Crack_node_Y_new{ii}(Crack_Ele_3{ii}(j))];
						c_z = [Crack_node_Z_new{ii}(Crack_Ele_1{ii}(j)),Crack_node_Z_new{ii}(Crack_Ele_2{ii}(j)),Crack_node_Z_new{ii}(Crack_Ele_3{ii}(j))];
						% Crack_Fill = fill3(c_x,c_y,c_z,'r','FaceAlpha',0.3,'FaceLighting','gouraud');
						
						Crack_Fill = fill3(c_x,c_y,c_z,myMap(ii,1:3),'FaceAlpha',0.3,'FaceLighting','gouraud');  %2022-07-14. IMPROV-2022071401.
						% 仅绘制裂缝边界线. 2022-07-14.
						if Key_PLOT(2,5) == 3
						    set(Crack_Fill,{'LineStyle'},{'none'}) %设置颜色和线宽
						end
						
						%有网格线.
						% patch(c_x',c_y',c_z',myMap(ii,1:3),'FaceAlpha',0.5,'FaceLighting','gouraud','LineWidth',0.2)							
					end
					
					%==========================
					% 绘制离散裂缝面边界线.
					%========================== 
					c_node_x =[];c_node_y =[];c_node_z =[];     %BUGFIX-2022041901
					if isempty(Crack3D_Meshed_Outline)==0
						for j=1:size(Crack3D_Meshed_Outline{ii},2)
							Crack_Node = Crack3D_Meshed_Outline{ii}(j);	
							c_node_x(j) = [Crack_node_X_new{ii}(Crack_Node)];
							c_node_y(j) = [Crack_node_Y_new{ii}(Crack_Node)];
							c_node_z(j) = [Crack_node_Z_new{ii}(Crack_Node)];			
						end
						Crack_Node = Crack3D_Meshed_Outline{ii}(1);	
						c_node_x(j+1) =  [Crack_node_X_new{ii}(Crack_Node)];
						c_node_y(j+1) =  [Crack_node_Y_new{ii}(Crack_Node)];
						c_node_z(j+1) =  [Crack_node_Z_new{ii}(Crack_Node)];		
						plot3(c_node_x,c_node_y,c_node_z,'LineWidth',0.1,'Color','black')	
					end
				end
			end
		end
		
		%============================================================  	  
		%   绘制3D天然裂缝. NEWFTU-2023010901.
		%============================================================ 
		disp(['      ----- Plotting 3D NF......'])
		for i_NF=1:Num_NF_3D 
			%天然裂缝形心.
			c_Center_x = sum(Crack3D_NF_nfcx{i_NF}(1:size(Crack3D_NF_nfcx{i_NF},2)))/size(Crack3D_NF_nfcx{i_NF},2);
			c_Center_y = sum(Crack3D_NF_nfcy{i_NF}(1:size(Crack3D_NF_nfcx{i_NF},2)))/size(Crack3D_NF_nfcx{i_NF},2);
			c_Center_z = sum(Crack3D_NF_nfcz{i_NF}(1:size(Crack3D_NF_nfcx{i_NF},2)))/size(Crack3D_NF_nfcx{i_NF},2);
			%绘制天然裂缝.
			for i_side =  1:size(Crack3D_NF_nfcx{i_NF},2)-1;
				plot3([Crack3D_NF_nfcx{i_NF}(i_side),Crack3D_NF_nfcx{i_NF}(i_side+1)], ...
					  [Crack3D_NF_nfcy{i_NF}(i_side),Crack3D_NF_nfcy{i_NF}(i_side+1)], ...
					  [Crack3D_NF_nfcz{i_NF}(i_side),Crack3D_NF_nfcz{i_NF}(i_side+1)],'LineWidth',0.5,'Color','black')	
			end	
			plot3([Crack3D_NF_nfcx{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcx{i_NF}(1)], ...
				  [Crack3D_NF_nfcy{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcy{i_NF}(1)], ...
				  [Crack3D_NF_nfcz{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcz{i_NF}(1)],'LineWidth',0.5,'Color','black')	
			%绘制天然裂缝编号（测试用）.
			% ts = text(c_Center_x,c_Center_y,c_Center_z,string(i_NF),'Color','black','FontSize',8,'FontName','Consolas','FontAngle','italic');		
		end
		
		%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		% Plot text on the left or the bottom of the figure.
		%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		% plot_string_MatMES = ['PhiPsi  ',Version];
		% plot_string_Frame  = ['Frame ',num2str(i_p),' / ',num2str(Real_num_iteration)];
		% plot_string_Time   = ['Time: ',num2str(i_p*delt_time_NewMark*1000),' ms'];
		% if  exist([Full_Pathname,'.hftm'], 'file') ==2
			% if Key_Time_String==1
				% plot_string_Time   = ['Time: ',num2str(Itera_HF_Time(i_output),'%0.4f'),' s'];
			% elseif Key_Time_String==2
				% plot_string_Time   = ['Time: ',num2str(Itera_HF_Time(i_output)/60.0,'%0.4f'),' mins'];
			% elseif Key_Time_String==3
				% plot_string_Time   = ['Time: ',num2str(Itera_HF_Time(i_output)/60.0/60.0,'%0.4f'),' hours'];
			% elseif Key_Time_String==4
				% plot_string_Time   = ['Time: ',num2str(Itera_HF_Time(i_output)/60.0/60.0/24,'%0.4f'),' days'];
			% elseif Key_Time_String==5
				% plot_string_Time   = ['Time: ',num2str(Itera_HF_Time(i_output)/60.0/60.0/24/30.41666,'%0.4f'),' months'];
			% elseif Key_Time_String==6
				% plot_string_Time   = ['Time: ',num2str(Itera_HF_Time(i_output)/60.0/60.0/24/30.41666/12.0,'%0.4f'),' years'];
			% end
		% end
		% plot_string_Scale  = ['Scale factor: ',num2str(scale)];
		% range_W = abs(Last_Max_X-Last_Min_X);
		% range_H = abs(Last_Max_Y-Last_Min_Y);
		% if range_H >= 0.75*range_W      % Left
			% loc_x = -range_H/2+ Last_Min_X;
			% loc_y =  Last_Max_Y-range_H*0.05;
			% text(loc_x,loc_y,plot_string_MatMES,'color','black');
			% loc_y =  Last_Max_Y-range_H*0.15;
			% text(loc_x,loc_y,plot_string_Scale,'color','black');
			% loc_y =  Last_Max_Y-range_H*0.25;
			% text(loc_x,loc_y,plot_string_Frame,'color','black');
			% if Key_Dynamic == 1
				% loc_y =  Last_Max_Y-range_H*0.35;
				% text(loc_x,loc_y,plot_string_Time, 'color','black');
			% end
			% if  exist([Full_Pathname,'.hftm'], 'file') ==2
				% loc_y =  Last_Max_Y-range_H*0.35;
				% text(loc_x,loc_y,plot_string_Time, 'color','black');
			% end
		% else                            % Bottom
			% loc_y =  Last_Min_Y-range_H*0.05;
			% loc_x =  Last_Min_X;
			% text(loc_x,loc_y,plot_string_MatMES,'color','black');
			% loc_x =  Last_Min_X + range_W*0.25;
			% text(loc_x,loc_y,plot_string_Scale,'color','black');
			% loc_x =  Last_Min_X + range_W*0.45;
			% text(loc_x,loc_y,plot_string_Frame,'color','black');
			% if Key_Dynamic == 1
				% loc_x =  Last_Min_X + range_W*0.60;
				% text(loc_x,loc_y,plot_string_Time, 'color','black');
			% end
			% if  exist([Full_Pathname,'.hftm'], 'file') ==2
				% loc_x =  Last_Min_X + range_W*0.60;
				% text(loc_x,loc_y,plot_string_Time, 'color','black');
			% end
		% end
		%<<<<<<<<<<<<<<<<<<<<<<<<<<<
		% Save the current figure
		%<<<<<<<<<<<<<<<<<<<<<<<<<<<
		deformation(i_output) = getframe(gcf);
		im=frame2im(deformation(i_output));
		[II,map]=rgb2ind(im,256);
		kkkk=i_output-0;
		str1='_deformation';
		str2=Full_Pathname;
		FileName =[str2,str1,'.gif'];
		if kkkk==1;
			imwrite(II,map,FileName,'gif','Loopcount',inf,'DelayTime',Time_Delay);
		else
			imwrite(II,map,FileName,'gif','WriteMode','append','DelayTime',Time_Delay);
		end

		close
    end
end