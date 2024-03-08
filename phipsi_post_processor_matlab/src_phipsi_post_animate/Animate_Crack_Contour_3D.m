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

function Animate_Crack_Contour_3D(Real_num_iteration)
% This function generates the animation of the crack contour.
% Firstly written on 2021-09-03.

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
global Key_Flipped_Gray Color_Contourlevel
global num_Wellbore num_Points_WB_1 num_Points_WB_2 num_Points_WB_3 num_Points_WB_4 num_Points_WB_5
global Wellbore_1 Wellbore_2 Wellbore_3 Wellbore_4 Wellbore_5 Frac_Stage_Points
global Key_Axis_NE
global Crack3D_NF_nfcx Crack3D_NF_nfcy Crack3D_NF_nfcz Num_NF_3D

disp('    Generating crack contour animations......')


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

% Read outl file.
if Key_Data_Format==1 
	Model_Outline = load([Full_Pathname,'.outl']);
elseif Key_Data_Format==2  %Binary
	c_file = fopen([Full_Pathname,'.outl'],'rb');
	[cc_Model_Outline,cc_count]   = fread(c_file,inf,'int');
	fclose(c_file);
	Model_Outline = (reshape(cc_Model_Outline,2,cc_count/2))';
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

%*******************************************************			
% 获得全部扩展步各个裂缝的最大最小开度值. 2022-06-05.
% BUGFIX-2022060501.
%*******************************************************	
if Key_Ani_Ave(1,4)==1 | Key_Ani_Ave(1,4)==0
    disp(['    > Calculating range of crack apertures......']) 
    Max_Aperture =  -1.0D9;
	Min_Aperture =   1.0D9;
    i_output=0;
	for i=1:Real_num_iteration
	    if mod(i,Output_Freq)==0
		    i_output=i_output+1;
			% DISP = load([Full_Pathname,'.disn_',num2str(Itera_Num(i))]);
			
			% 计算点的开度云图.
            if Key_PLOT(5,2)==1
				file_Crack3D_CalP_Aperture = fopen([Full_Pathname,'.cape_',num2str(Itera_Num(i))]);
				Crack3D_CalP_Aperture = cell(num_Crack(Itera_Num(i)));
				for i_Crack=1:num_Crack(Itera_Num(i)) 
					Crack3D_CalP_Aperture{i_Crack} = str2num(fgetl(file_Crack3D_CalP_Aperture));
				end
				fclose(file_Crack3D_CalP_Aperture);
				%获取每个裂缝最大开度值
				for i_Crack=1:num_Crack(Itera_Num(i)) 
					Max_Aperture_of_each_Crack(i_Crack) = max(Crack3D_CalP_Aperture{i_Crack});
					Min_Aperture_of_each_Crack(i_Crack) = min(Crack3D_CalP_Aperture{i_Crack});						
				end	
				%当前步全部裂缝的最大开度
				c_Max_Aperture = 	max(Max_Aperture_of_each_Crack(1:num_Crack));
				c_Min_Aperture = 	min(Min_Aperture_of_each_Crack(1:num_Crack));
				
				c_Step_Max_Aperture(i_output) = 	max(Max_Aperture_of_each_Crack(1:num_Crack));
				c_Step_Min_Aperture(i_output) = 	min(Min_Aperture_of_each_Crack(1:num_Crack));
				% 更新最大和最小开度
				if c_Max_Aperture > Max_Aperture
					Max_Aperture = c_Max_Aperture; 
				end
				if c_Min_Aperture < Min_Aperture
					Min_Aperture = c_Min_Aperture; 
				end	
			end
			
			% 裂缝面离散点的开度云图. 2023-05-16. IMPROV-2023051601.
            if Key_PLOT(5,2)==2
			    %读取裂缝面离散节点开度文件
				file_Crack3D_Node_Aperture = fopen([Full_Pathname,'.cmap_',num2str(Itera_Num(i))]);
				Crack3D_Node_Aperture = cell(num_Crack(Itera_Num(i)));
				for i_Crack=1:num_Crack(Itera_Num(i)) 
					Crack3D_Node_Aperture{i_Crack} = str2num(fgetl(file_Crack3D_Node_Aperture));
				end
				fclose(file_Crack3D_Node_Aperture);
				%获取每个裂缝最大开度值
				for i_Crack=1:num_Crack(Itera_Num(i)) 
					Max_Aperture_of_each_Crack(i_Crack) = max(Crack3D_Node_Aperture{i_Crack});
					Min_Aperture_of_each_Crack(i_Crack) = min(Crack3D_Node_Aperture{i_Crack});						
				end	
				%当前步全部裂缝的最大开度
				c_Max_Aperture = 	max(Max_Aperture_of_each_Crack(1:num_Crack));
				c_Min_Aperture = 	min(Min_Aperture_of_each_Crack(1:num_Crack));
				
				c_Step_Max_Aperture(i_output) = 	max(Max_Aperture_of_each_Crack(1:num_Crack));
				c_Step_Min_Aperture(i_output) = 	min(Min_Aperture_of_each_Crack(1:num_Crack));
				% 更新最大和最小开度
				if c_Max_Aperture > Max_Aperture
					Max_Aperture = c_Max_Aperture; 
				end
				if c_Min_Aperture < Min_Aperture
					Min_Aperture = c_Min_Aperture; 
				end	
			end
		end
	end
	disp(['      Max aperture of all crack of all steps: ',num2str(Max_Aperture*1000.0),' mm']) 
	disp(['      Min aperture of all crack of all steps: ',num2str(Min_Aperture*1000.0),' mm']) 
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
		disp(['    > Plotting and saving figure of frame ',num2str(i_p),'......']) 
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
			%读取ennd文件
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
				
			%读取裂缝面计算点开度文件
			if exist([Full_Pathname,'.cape_',num2str(Itera_Num(i_p))], 'file') ==2
				file_Crack3D_CalP_Aperture = fopen([Full_Pathname,'.cape_',num2str(Itera_Num(i_p))]);
				Crack3D_CalP_Aperture = cell(num_Crack(Itera_Num(i_p)));
				for i_Crack=1:num_Crack(Itera_Num(i_p)) 
					Crack3D_CalP_Aperture{i_Crack} = str2num(fgetl(file_Crack3D_CalP_Aperture));
				end
				fclose(file_Crack3D_CalP_Aperture);
				%获取每个裂缝最大开度值
				for i_Crack=1:num_Crack(Itera_Num(i_p)) 
					Max_Aperture_of_each_Crack(i_Crack) = max(Crack3D_CalP_Aperture{i_Crack});
					Min_Aperture_of_each_Crack(i_Crack) = min(Crack3D_CalP_Aperture{i_Crack});
					% Max_Aperture_of_each_Crack(i) = max(abs(Crack3D_CalP_Aperture{i}));
					% Min_Aperture_of_each_Crack(i) = min(abs(Crack3D_CalP_Aperture{i}));						
				end
			else
				Crack3D_CalP_Aperture=[];
			end	

			%读取裂缝面计算点坐标文件
			if exist([Full_Pathname,'.ccpx_',num2str(Itera_Num(i_p))], 'file') ==2
				file_Crack3D_CalP_X = fopen([Full_Pathname,'.ccpx_',num2str(Itera_Num(i_p))]);
				file_Crack3D_CalP_Y = fopen([Full_Pathname,'.ccpy_',num2str(Itera_Num(i_p))]);
				file_Crack3D_CalP_Z = fopen([Full_Pathname,'.ccpz_',num2str(Itera_Num(i_p))]);
				Crack3D_CalP_X = cell(num_Crack(Itera_Num(i_p)));
				Crack3D_CalP_Y = cell(num_Crack(Itera_Num(i_p)));
				Crack3D_CalP_Z = cell(num_Crack(Itera_Num(i_p)));
				for i=1:num_Crack(Itera_Num(i_p)) 
					Crack3D_CalP_X{i} = str2num(fgetl(file_Crack3D_CalP_X));
					Crack3D_CalP_Y{i} = str2num(fgetl(file_Crack3D_CalP_Y));
					Crack3D_CalP_Z{i} = str2num(fgetl(file_Crack3D_CalP_Z));
				end
				fclose(file_Crack3D_CalP_X);
				fclose(file_Crack3D_CalP_Y);
				fclose(file_Crack3D_CalP_Z);	
			else
				Crack3D_CalP_X =[];
				Crack3D_CalP_Y =[];
				Crack3D_CalP_Z =[];
			end
			
			%读取裂缝面流体单元数目cpfn文件
			if exist([Full_Pathname,'.cpfn_',num2str(Itera_Num(i_p))], 'file') ==2
				file_cpfn = fopen([Full_Pathname,'.cpfn_',num2str(Itera_Num(i_p))]);
				Crack3D_Fluid_Ele_Num = cell(num_Crack(Itera_Num(i_p)));
				for i=1:num_Crack(Itera_Num(i_p)) 
					Crack3D_Fluid_Ele_Num{i} = str2num(fgetl(file_cpfn));
				end
				fclose(file_cpfn);
			else
				Crack3D_Fluid_Ele_Num =[];
			end			
			
			%读取裂缝面流体单元计算点编号文件cpno
			if Key_Data_Format == 1
				Crack3D_Fluid_Ele_Nodes_All = load([Full_Pathname,'.cpno_',num2str(Itera_Num(i_p))]);
			elseif Key_Data_Format == 2  %binary. 2022-07-19.
				c_file = fopen([Full_Pathname,'.cpno_',num2str(Itera_Num(i_p))],'rb');
				[cc_Crack3D_Fluid_Ele_Nodes_All,cc_count]   = fread(c_file,inf,'int');
				fclose(c_file);
				Crack3D_Fluid_Ele_Nodes_All = (reshape(cc_Crack3D_Fluid_Ele_Nodes_All,3,cc_count/3))';
			end	
		
			
			cc_count  = 0;
			for i=1:num_Crack(Itera_Num(i_p)) 
				Crack3D_Fluid_Ele_Nodes(i,1:Crack3D_Fluid_Ele_Num{i},1:3) = Crack3D_Fluid_Ele_Nodes_All(cc_count+1:cc_count+Crack3D_Fluid_Ele_Num{i},1:3);
				cc_count  = cc_count + Crack3D_Fluid_Ele_Num{i};
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
		title('Crack aperture contour','FontName',Title_Font,'FontSize',Size_Font)
		axis off; 
		axis equal;
		delta = sqrt(aveg_area_ele);
		axis([Min_X_Coor_New-delta Max_X_Coor_New+delta ...
			  Min_Y_Coor_New-delta Max_Y_Coor_New+delta ...
			  Min_Z_Coor_New-delta Max_Z_Coor_New+delta]);
        
		% Set Viewpoint
        PhiPsi_Viewing_Angle_Settings
		
		
		%----------------------
		%   绘制变形后的网格
		%----------------------
		%绘制变形后的网格
		Line_width =0.1;
		if Key_PLOT(5,9)==1 
			c_plot_count = 0;
			Ploted_Ele_lines =[0 0];
			to_be_plot_count = 0;
			to_be_plot_x = [];to_be_plot_y = [];to_be_plot_z = [];  %2021-08-02
			for iElem = 1:Num_Elem
				NN = [Elem_Node(iElem,1) Elem_Node(iElem,2) Elem_Node(iElem,3) Elem_Node(iElem,4) ...
					  Elem_Node(iElem,5) Elem_Node(iElem,6) Elem_Node(iElem,7) Elem_Node(iElem,8)];                             % Nodes for current element
				for i=1:3
					if not(ismember(sort([NN(i),NN(i+1)]),Ploted_Ele_lines,'rows')) 	
						c_plot_count = c_plot_count + 1;
						Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+1)]);
						to_be_plot_count = to_be_plot_count +1;
						to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),1) New_Node_Coor(NN(i+1),1)];
						to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),2) New_Node_Coor(NN(i+1),2)];
						to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),3) New_Node_Coor(NN(i+1),3)];		
					end			
				end
				for i=5:7
					%检查该边线是否已经绘制
					if not(ismember(sort([NN(i),NN(i+1)]),Ploted_Ele_lines,'rows')) 	  
						c_plot_count = c_plot_count + 1;
						Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+1)]);
						to_be_plot_count = to_be_plot_count +1;
						to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),1) New_Node_Coor(NN(i+1),1)];
						to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),2) New_Node_Coor(NN(i+1),2)];
						to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),3) New_Node_Coor(NN(i+1),3)];		
					end					  
				end
				for i=1:4
					%检查该边线是否已经绘制
					if not(ismember(sort([NN(i),NN(i+4)]),Ploted_Ele_lines,'rows')) 		
						c_plot_count = c_plot_count + 1;
						Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+4)]);
						to_be_plot_count = to_be_plot_count +1;
						to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),1) New_Node_Coor(NN(i+4),1)];
						to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),2) New_Node_Coor(NN(i+4),2)];
						to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),3) New_Node_Coor(NN(i+4),3)];						
					end				  
				end	
				%检查该边线是否已经绘制
				if not(ismember(sort([NN(1),NN(4)]),Ploted_Ele_lines,'rows')) 		
					c_plot_count = c_plot_count + 1;
					Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(1),NN(4)]);		
					to_be_plot_count = to_be_plot_count +1;
					to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(NN(1),1) New_Node_Coor(NN(4),1)];
					to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(NN(1),2) New_Node_Coor(NN(4),2)];
					to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(NN(1),3) New_Node_Coor(NN(4),3)];				
				end
				if not(ismember(sort([NN(5),NN(8)]),Ploted_Ele_lines,'rows')) 	
					c_plot_count = c_plot_count + 1;
					Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(5),NN(8)]);	
					to_be_plot_count = to_be_plot_count +1;
					to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(NN(5),1) New_Node_Coor(NN(8),1)];
					to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(NN(5),2) New_Node_Coor(NN(8),2)];
					to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(NN(5),3) New_Node_Coor(NN(8),3)];					
				end
			end 	
			plot3(to_be_plot_x',to_be_plot_y',to_be_plot_z','LineWidth',Line_width,'Color','red')	%灰色				
		end

		if Key_PLOT(5,9)==2  | Key_PLOT(5,9)==4 %增强单元的网格
			c_plot_count = 0;
			Ploted_Ele_lines =[0 0];	
			to_be_plot_count = 0;
			to_be_plot_x = [];to_be_plot_y = [];to_be_plot_z = [];  %2021-08-02		
			for iElem = 1:Num_Elem
				NN = [Elem_Node(iElem,1) Elem_Node(iElem,2) ...
					  Elem_Node(iElem,3) Elem_Node(iElem,4) ...
					  Elem_Node(iElem,5) Elem_Node(iElem,6) ...
					  Elem_Node(iElem,7) Elem_Node(iElem,8)];                             % Nodes for current element
				%如果该单元含有增强节点	
				if isempty(Post_Enriched_Nodes)==0
					if sum(sum(Post_Enriched_Nodes(NN,1:size(Post_Enriched_Nodes,2))))~=0
						for i=1:3
							%检查该边线是否已经绘制(防止重复绘制)
							if not(ismember(sort([NN(i),NN(i+1)]),Ploted_Ele_lines,'rows')) 		
								c_plot_count = c_plot_count + 1;
								Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+1)]);
								c_plot_count = c_plot_count + 1;
								Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+1)]);
								to_be_plot_count = to_be_plot_count +1;
								to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),1) New_Node_Coor(NN(i+1),1)];
								to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),2) New_Node_Coor(NN(i+1),2)];
								to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),3) New_Node_Coor(NN(i+1),3)];								
							end			
						end
						for i=5:7
							%检查该边线是否已经绘制
							if not(ismember(sort([NN(i),NN(i+1)]),Ploted_Ele_lines,'rows')) 		
								c_plot_count = c_plot_count + 1;
								Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+1)]);
								to_be_plot_count = to_be_plot_count +1;
								to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),1) New_Node_Coor(NN(i+1),1)];
								to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),2) New_Node_Coor(NN(i+1),2)];
								to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),3) New_Node_Coor(NN(i+1),3)];									
							end					  
						end
						for i=1:4
							%检查该边线是否已经绘制
							if not(ismember(sort([NN(i),NN(i+4)]),Ploted_Ele_lines,'rows')) 		
								c_plot_count = c_plot_count + 1;
								Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+4)]);
								to_be_plot_count = to_be_plot_count +1;
								to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),1) New_Node_Coor(NN(i+4),1)];
								to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),2) New_Node_Coor(NN(i+4),2)];
								to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(NN(i),3) New_Node_Coor(NN(i+4),3)];	
							end				  
						end	
						%检查该边线是否已经绘制
						if not(ismember(sort([NN(1),NN(4)]),Ploted_Ele_lines,'rows')) 		
							c_plot_count = c_plot_count + 1;
							Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(1),NN(4)]);		
							to_be_plot_count = to_be_plot_count +1;
							to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(NN(1),1) New_Node_Coor(NN(4),1)];
							to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(NN(1),2) New_Node_Coor(NN(4),2)];
							to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(NN(1),3) New_Node_Coor(NN(4),3)];							
						end
						if not(ismember(sort([NN(5),NN(8)]),Ploted_Ele_lines,'rows')) 	
							c_plot_count = c_plot_count + 1;
							Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(5),NN(8)]);			
							to_be_plot_count = to_be_plot_count +1;
							to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(NN(5),1) New_Node_Coor(NN(8),1)];
							to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(NN(5),2) New_Node_Coor(NN(8),2)];
							to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(NN(5),3) New_Node_Coor(NN(8),3)];							
						end					  
					end		
				end
			end 
			plot3(to_be_plot_x',to_be_plot_y',to_be_plot_z','LineWidth',Line_width,'Color',[.5 .5 .5])	%灰色			

			
			for i=1:size(Model_Outline,1)
				plot3([New_Node_Coor(Model_Outline(i,1),1),New_Node_Coor(Model_Outline(i,2),1)],...
					  [New_Node_Coor(Model_Outline(i,1),2),New_Node_Coor(Model_Outline(i,2),2)],...
					  [New_Node_Coor(Model_Outline(i,1),3),New_Node_Coor(Model_Outline(i,2),3)],'LineWidth',Line_width,'Color','black')	    
			end			
		end	

		if Key_PLOT(5,9)==3  | Key_PLOT(5,9)==4  %模型的表面网格	
			for i=1:size(Model_OutArea,1)
				plot3([New_Node_Coor(Model_OutArea(i,1),1),New_Node_Coor(Model_OutArea(i,2),1)],...
					  [New_Node_Coor(Model_OutArea(i,1),2),New_Node_Coor(Model_OutArea(i,2),2)],...
					  [New_Node_Coor(Model_OutArea(i,1),3),New_Node_Coor(Model_OutArea(i,2),3)],'LineWidth',Line_width,'Color',[.6 .5 .4])	 			  
			end	
			for i=1:size(Model_Outline,1)
				plot3([New_Node_Coor(Model_Outline(i,1),1),New_Node_Coor(Model_Outline(i,2),1)],...
					  [New_Node_Coor(Model_Outline(i,1),2),New_Node_Coor(Model_Outline(i,2),2)],...
					  [New_Node_Coor(Model_Outline(i,1),3),New_Node_Coor(Model_Outline(i,2),3)],'LineWidth',Line_width,'Color','black')	    
			end		
		end		
		
		if Key_PLOT(5,9) ==0 %仅绘制模型边框(Outlines)
			for i=1:size(Model_Outline,1)
				plot3([New_Node_Coor(Model_Outline(i,1),1),New_Node_Coor(Model_Outline(i,2),1)],...
					  [New_Node_Coor(Model_Outline(i,1),2),New_Node_Coor(Model_Outline(i,2),2)],...
					  [New_Node_Coor(Model_Outline(i,1),3),New_Node_Coor(Model_Outline(i,2),3)],'LineWidth',Line_width,'Color','black')	    
			end
		end

		% 绘制井筒, Plot wellbore, NEWFTU-2022041901.
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
		
		%绘制井筒分段点. NEWFTU-2022071402.
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
		
		%----------------------
		%     绘制坐标轴
		%----------------------
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

		%-----------------------------
		%Plot crack aperture contour.
		%-----------------------------
		if Key_PLOT(5,1)==1 
			if Key_PLOT(5,2)==1 %results of fluid elements and nodes
				if isempty(Crack3D_CalP_Aperture)==0  && isempty(Crack3D_CalP_X)==0
					for i_Crack = 1:num_Crack(Itera_Num(i_p))    
						nfluid_Ele = Crack3D_Fluid_Ele_Num{i_Crack};
						n_fl_nodes_per_elem = 3;   %Every fluid element has 3 fluid nodes.
						% Initialization of the required matrices
						X = zeros(n_fl_nodes_per_elem,nfluid_Ele);
						Y = zeros(n_fl_nodes_per_elem,nfluid_Ele);
						Z = zeros(n_fl_nodes_per_elem,nfluid_Ele);
						profile = zeros(n_fl_nodes_per_elem,nfluid_Ele); %BUGFIX-2022060501.
						%nfluid_Ele
						for i_fluid_Ele=1:nfluid_Ele
							c_fluid_nodes = Crack3D_Fluid_Ele_Nodes(i_Crack,i_fluid_Ele,1:n_fl_nodes_per_elem);
							X(1:n_fl_nodes_per_elem,i_fluid_Ele) =Crack3D_CalP_X{i_Crack}(c_fluid_nodes);
							Y(1:n_fl_nodes_per_elem,i_fluid_Ele) =Crack3D_CalP_Y{i_Crack}(c_fluid_nodes);
							Z(1:n_fl_nodes_per_elem,i_fluid_Ele) =Crack3D_CalP_Z{i_Crack}(c_fluid_nodes);
							c_X = Crack3D_CalP_X{i_Crack}(c_fluid_nodes);
							c_Y = Crack3D_CalP_Y{i_Crack}(c_fluid_nodes);
							c_Z = Crack3D_CalP_Z{i_Crack}(c_fluid_nodes);
							profile(1:n_fl_nodes_per_elem,i_fluid_Ele) =  Crack3D_CalP_Aperture{i_Crack}(c_fluid_nodes)*1000.0 ; % extract component value of the fluid node 				
						end	
						%绘制裂缝面网格线
						if Key_PLOT(5,3)==1
							patch(X,Y,Z,profile,'edgecolor','black','LineWidth',0.1)   
						%不绘制裂缝面网格线(2021-08-22)
						else
							patch(X,Y,Z,profile,'edgecolor','none','LineWidth',0.1)
						end
						
					end
				end
			elseif Key_PLOT(5,2)==2    %results of discrete crack surface
				if isempty(Crack_X)==0
					for i = 1:num_Crack(Itera_Num(i_p))    
						nel   = size(Crack_Ele_1{i},2);    % number of elements
						nnode = size(Crack_node_X{i},2);   % total number of nodes in system
						nnel  = 3;                         % number of nodes per element
						% Initialization of the required matrices
						X = zeros(nnel,nel);
						Y = zeros(nnel,nel);
						Z = zeros(nnel,nel);
						profile = zeros(nnel,nel) ;
						for iel=1:nel
							nd=[Crack_Ele_1{i}(iel) Crack_Ele_2{i}(iel) Crack_Ele_3{i}(iel)];         % extract connected node for (iel)-th element
							X(1:nnel,iel)=Crack_node_X{i}(nd);    % extract x value of the node
							Y(1:nnel,iel)=Crack_node_Y{i}(nd);    % extract y value of the node
							Z(1:nnel,iel)=Crack_node_Z{i}(nd) ;   % extract z value of the node
							profile(1:nnel,iel) = Crack3D_Node_Aperture{i}(nd)*1000.0 ; % extract component value of the node 		
						end	
						%绘制裂缝面网格线
						if Key_PLOT(5,3)==1
							patch(X,Y,Z,profile,'edgecolor','black','LineWidth',0.1)   
						%不绘制裂缝面网格线(2021-08-22)
						else
							patch(X,Y,Z,profile,'edgecolor','none','LineWidth',0.1)
						end
					end
				end
			end
		end	

		%---------------------------------------
		%Plot crack node and element numnber.
		%---------------------------------------
		% element
		if Key_PLOT(5,5)>=2 
			if Key_PLOT(5,2)==1 %results of fluid elements and nodes
				if isempty(Crack3D_CalP_Aperture)==0  && isempty(Crack3D_CalP_X)==0
					for i_Crack = 1:num_Crack(Itera_Num(i_p))    
						nfluid_Ele = Crack3D_Fluid_Ele_Num{i_Crack};
						for i_fluid_Ele=1:nfluid_Ele
							c_fluid_nodes = Crack3D_Fluid_Ele_Nodes(i_Crack,i_fluid_Ele,1:3);
							c_X = Crack3D_CalP_X{i_Crack}(c_fluid_nodes);
							c_Y = Crack3D_CalP_Y{i_Crack}(c_fluid_nodes);
							c_Z = Crack3D_CalP_Z{i_Crack}(c_fluid_nodes);
							ts = text(sum(c_X(1:3))/3.0,sum(c_Y(1:3))/3.0,sum(c_Z(1:3))/3.0,num2str(i_fluid_Ele),'Color','black','FontSize',12,'FontName','Consolas','FontAngle','italic'); % 流体单元编号						
						end	
					end
				end
			elseif Key_PLOT(5,2)==2    %results of discrete crack surface
				if isempty(Crack_X)==0
					for i = 1:num_Crack(Itera_Num(i_p))    
						nel   = size(Crack_Ele_1{i},2);    % number of elements
						nnode = size(Crack_node_X{i},2);   % total number of nodes in system
						nnel  = 3;                         % number of nodes per element
						for iel=1:nel
							nd=[Crack_Ele_1{i}(iel) Crack_Ele_2{i}(iel) Crack_Ele_3{i}(iel)];         % extract connected node for (iel)-th element
							c_X(1:nnel)=Crack_node_X{i}(nd);    % extract x value of the node
							c_Y(1:nnel)=Crack_node_Y{i}(nd);    % extract y value of the node
							c_Z(1:nnel)=Crack_node_Z{i}(nd) ;   % extract z value of the node
							ts = text(sum(c_X(1:3))/3.0,sum(c_Y(1:3))/3.0,sum(c_Z(1:3))/3.0,num2str(iel),'Color','black','FontSize',12,'FontName','Consolas','FontAngle','italic'); % 裂缝面离散单元编号		
						end	
					end
				end
			end
		end
		% node
		if Key_PLOT(5,5)>=1
			if Key_PLOT(5,2)==1 %results of fluid elements and nodes
				if isempty(Crack3D_CalP_Aperture)==0  && isempty(Crack3D_CalP_X)==0
					for i_Crack = 1:num_Crack(Itera_Num(i_p))    
						nCalP = size(Crack3D_CalP_X{i_Crack},2);
						for j=1:nCalP
							c_CalP_x = Crack3D_CalP_X{i_Crack}(j);
							c_CalP_y = Crack3D_CalP_Y{i_Crack}(j);
							c_CalP_z = Crack3D_CalP_Z{i_Crack}(j);
							plot3(c_CalP_x,c_CalP_y,c_CalP_z,'k.','MarkerSize',10.0)    % MarkerSize 表示点的大小,黑色点;k表示黑色.
							ts = text(c_CalP_x,c_CalP_y,c_CalP_z,num2str(j),'Color','red','FontSize',10,'FontName','Consolas','FontAngle','italic');
						end
					end
				end
			elseif Key_PLOT(5,2)==2    %results of discrete crack surface
				if isempty(Crack_X)==0
					for i_Crack = 1:num_Crack(Itera_Num(i_p))    
						nnode = size(Crack_node_X{i_Crack},2);
						for j=1:nnode
							c_node_x = [Crack_node_X{i_Crack}(j)];
							c_node_y = [Crack_node_Y{i_Crack}(j)];
							c_node_z = [Crack_node_Z{i_Crack}(j)];
							plot3(c_node_x,c_node_y,c_node_z,'c.','MarkerSize',10.0)    % MarkerSize 表示点的大小,黑色点
							ts = text(c_node_x,c_node_y,c_node_z,num2str(j),'Color','red','FontSize',10,'FontName','Consolas','FontAngle','italic');
						end
					end
				end
			end
		end
		%==========================
		% 绘制离散裂缝面边界线.
		%========================== 
	
		%读取离散裂缝面外边界节点
		if exist([Full_Pathname,'.cmso_',num2str(Itera_Num(i_p))], 'file') ==2 
			file_Crack3D_Meshed_Outline= fopen([Full_Pathname,'.cmso_',num2str(Itera_Num(i_p))]);
			Crack3D_Meshed_Outline = cell(num_Crack(Itera_Num(i_p)));
			for i=1:num_Crack(Itera_Num(i_p)) 
				Crack3D_Meshed_Outline{i} = str2num(fgetl(file_Crack3D_Meshed_Outline));
			end
			fclose(file_Crack3D_Meshed_Outline);
			
			for i = 1:num_Crack(Itera_Num(i_p))
				c_node_x =[];c_node_y =[];c_node_z =[];     %BUGFIX-2022041901
				if isempty(Crack3D_Meshed_Outline)==0
					for j=1:size(Crack3D_Meshed_Outline{i},2)
						Crack_Node = Crack3D_Meshed_Outline{i}(j);	
						c_node_x(j) = [Crack_node_X{i}(Crack_Node)];
						c_node_y(j) = [Crack_node_Y{i}(Crack_Node)];
						c_node_z(j) = [Crack_node_Z{i}(Crack_Node)];			
					end
					Crack_Node = Crack3D_Meshed_Outline{i}(1);	
					c_node_x(j+1) =  [Crack_node_X{i}(Crack_Node)];
					c_node_y(j+1) =  [Crack_node_Y{i}(Crack_Node)];
					c_node_z(j+1) =  [Crack_node_Z{i}(Crack_Node)];		
					plot3(c_node_x,c_node_y,c_node_z,'LineWidth',0.2,'Color','black')	
				end
			end
			
		else
			Crack3D_Meshed_Outline=[];
		end		

		%--------------------------------------------------------------	  
		%   绘制3D天然裂缝. NEWFTU-2023010901.
		%--------------------------------------------------------------
		if (Key_PLOT(5,12)==1 | Key_PLOT(5,12)==2)
			% disp(['      ----- Plotting 3D NF......'])
			for i_NF=1:Num_NF_3D 
				%天然裂缝形心.
				c_Center_x = sum(Crack3D_NF_nfcx{i_NF}(1:size(Crack3D_NF_nfcx{i_NF},2)))/size(Crack3D_NF_nfcx{i_NF},2);
				c_Center_y = sum(Crack3D_NF_nfcy{i_NF}(1:size(Crack3D_NF_nfcx{i_NF},2)))/size(Crack3D_NF_nfcx{i_NF},2);
				c_Center_z = sum(Crack3D_NF_nfcz{i_NF}(1:size(Crack3D_NF_nfcx{i_NF},2)))/size(Crack3D_NF_nfcx{i_NF},2);
				%绘制天然裂缝.
				for i_side =  1:size(Crack3D_NF_nfcx{i_NF},2)-1;
					plot3([Crack3D_NF_nfcx{i_NF}(i_side),Crack3D_NF_nfcx{i_NF}(i_side+1)], ...
						  [Crack3D_NF_nfcy{i_NF}(i_side),Crack3D_NF_nfcy{i_NF}(i_side+1)], ...
						  [Crack3D_NF_nfcz{i_NF}(i_side),Crack3D_NF_nfcz{i_NF}(i_side+1)],'LineWidth',0.1,'Color',[128/255, 138/255, 135/255])	%灰色
				end	
				plot3([Crack3D_NF_nfcx{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcx{i_NF}(1)], ...
					  [Crack3D_NF_nfcy{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcy{i_NF}(1)], ...
					  [Crack3D_NF_nfcz{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcz{i_NF}(1)],'LineWidth',0.1,'Color',[128/255, 138/255, 135/255])	%灰色
				%绘制天然裂缝编号.
				if (Key_PLOT(5,12)==2)
					ts = text(c_Center_x,c_Center_y,c_Center_z,string(i_NF),'Color','black','FontSize',8,'FontName','Consolas','FontAngle','italic');		
				end
			end
		end

		%----------------------
		% Set colormap.
		%----------------------
		if Key_Flipped_Gray==0
			colormap(Color_Contourlevel)
		elseif Key_Flipped_Gray==1
			colormap(flipud(gray))
		end				
							
		%----------------------	
		% Set colorbar.
		%----------------------
		cbar = colorbar;
		brighten(0.5); 
		if Key_PLOT(5,1)==1
			set(get(cbar,'title'),'string','mm');
		end
		% get the color limits. 2022-06-05. BUGFIX-2022060501.
		if Key_Ani_Ave(4)==1
			caxis([Min_Aperture*1000.0, Max_Aperture*1000.0]);  % Control of the range of the colour bar.
		else
		    caxis([c_Step_Min_Aperture(i_output)*1000.0, c_Step_Max_Aperture(i_output)*1000.0]);
		end		
		clim = caxis;
		ylim(cbar,[clim(1) clim(2)]);
		numpts = 10 ;    % Number of points to be displayed on colorbar
		kssv = linspace(clim(1),clim(2),numpts);
		set(cbar,'YtickMode','manual','YTick',kssv); % Set the tickmode to manual
		for i = 1:numpts
			imep = num2str(kssv(i),'%+3.2E');
			vasu(i) = {imep} ;
		end
		set(cbar,'YTickLabel',vasu(1:numpts),'FontName',Title_Font,'FontSize',Size_Font);



		%<<<<<<<<<<<<<<<<<<<<<<<<<<<
		% Save the current figure
		%<<<<<<<<<<<<<<<<<<<<<<<<<<<
		deformation(i_output) = getframe(gcf);       
		im=frame2im(deformation(i_output));         
		[II,map]=rgb2ind(im,256);
		kkkk=i_output-0;
		str1='_crack_contour';
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