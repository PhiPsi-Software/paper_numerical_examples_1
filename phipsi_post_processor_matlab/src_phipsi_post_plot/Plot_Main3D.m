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

function Plot_Main3D(POST_Substep)
% This function plots mesh and deformed mesh for 3D problems.

global Key_PLOT Full_Pathname Num_Node Num_Foc_x Num_Foc_y Foc_x Foc_y Num_Foc_z Foc_z
global num_Crack Key_Dynamic Real_Iteras Real_Sub Key_Contour_Metd
global Output_Freq num_Output_Sub Key_Crush DISP  FORCE_Matrix
global Key_Data_Format
global Crack_node_X Crack_node_Y Crack_node_Z
global Crack_Ele_1 Crack_Ele_2 Crack_Ele_3
global Model_Outline Model_OutArea
global Crack_node_local_X Crack_node_local_Y Crack_node_local_Z
global Crack_Node_in_Ele
global Crack3D_Vector_S1_X Crack3D_Vector_S1_Y Crack3D_Vector_S1_Z
global Crack3D_CalP_X Crack3D_CalP_Y Crack3D_CalP_Z
global Crack3D_Vertex_Vector_X_X 
global Crack3D_Vertex_Vector_X_Y  
global Crack3D_Vertex_Vector_X_Z 
global Crack3D_Vertex_Vector_Y_X  
global Crack3D_Vertex_Vector_Y_Y  
global Crack3D_Vertex_Vector_Y_Z  
global Crack3D_Vertex_Vector_Z_X  
global Crack3D_Vertex_Vector_Z_Y  
global Crack3D_Vertex_Vector_Z_Z 	
global Crack3D_Meshed_Outline
global Crack3D_Fluid_Ele_Num
global Crack3D_Fluid_Ele_Nodes
global Crack3D_CalP_Aperture
global Cracks_FluNode_Vector_3D_X Cracks_FluNode_Vector_3D_Y Cracks_FluNode_Vector_3D_Z
global Max_Aperture_of_each_Crack Crack3D_FluEl_Aperture
global Min_Aperture_of_each_Crack Stress_Matrix
global Tip_Enriched_Ele_BaseLine Tip_Enriched_Ele_BaseLine_Vector_x 
global Tip_Enriched_Ele_BaseLine_Vector_y Tip_Enriched_Ele_BaseLine_Vector_z
global FluidEle_GaussNor_3D_X FluidEle_GaussNor_3D_Y FluidEle_GaussNor_3D_Z
global FluidEle_LCS_VectorX_X FluidEle_LCS_VectorX_Y FluidEle_LCS_VectorX_Z
global FluidEle_LCS_VectorY_X FluidEle_LCS_VectorY_Y FluidEle_LCS_VectorY_Z
global FluidEle_LCS_VectorZ_X FluidEle_LCS_VectorZ_Y FluidEle_LCS_VectorZ_Z
global FluidEle_Contact_Force_X FluidEle_Contact_Force_Y FluidEle_Contact_Force_Z
global Crack3D_Node_Aperture
global Tip_Enriched_Node_Ref_Element
global Cracks_CalP_UpDis_3D_X Cracks_CalP_UpDis_3D_Y Cracks_CalP_UpDis_3D_Z
global Cracks_CalP_LowDis_3D_X Cracks_CalP_LowDis_3D_Y Cracks_CalP_LowDis_3D_Z
global Title_Font Key_Figure_Control_Widget
global Only_Plot_Mesh Node_Coor Elem_Node Num_Elem
global G_X_NODES G_Y_NODES G_Z_NODES G_NN G_X_Min G_X_Max G_Y_Min G_Y_Max G_Z_Min G_Z_Max
global Model_Surface_Nodes Strain_Matrix Strain_Matrix_in_Cylinder_CS
global DISP_Cylinder_CS Stress_Matrix_Cylinder_CS
global num_Wellbore num_Points_WB_1 num_Points_WB_2 num_Points_WB_3 num_Points_WB_4 num_Points_WB_5
global Wellbore_1 Wellbore_2 Wellbore_3 Wellbore_4 Wellbore_5 Frac_Stage_Points
global DISP_with_XFEM
global wbpt_Matrix avol_Matrix
global Key_Axis_NE
global Ave_Elem_L
global Max_kxx_of_each_Crack Min_kxx_of_each_Crack Crack3D_CalP_kxx
global Max_kyy_of_each_Crack Min_kyy_of_each_Crack Crack3D_CalP_kyy
global Max_kzz_of_each_Crack Min_kzz_of_each_Crack Crack3D_CalP_kzz
global Max_kxy_of_each_Crack Min_kxy_of_each_Crack Crack3D_CalP_kxy
global Max_kyz_of_each_Crack Min_kyz_of_each_Crack Crack3D_CalP_kyz
global Max_kxz_of_each_Crack Min_kxz_of_each_Crack Crack3D_CalP_kxz
global Ele_Permeability_3D
global Crack3D_NF_nfcx Crack3D_NF_nfcy Crack3D_NF_nfcz Num_NF_3D
global Crack3D_Contact_Status

scale = Key_PLOT(2,6);

% Check Key_Figure_Control_Widget (2021-8-02)
if Key_Figure_Control_Widget==1
	disp('    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~') 
	disp('    ATTENTION :: Figure Control Widget is active!') 
	disp('    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~') 
end	

% Get the number of the substep for post process.
if isa(POST_Substep,'double') == 0
    if length(POST_Substep) == 4
		if  lower(POST_Substep)  ==  'last'
			if Key_Dynamic ==1
			    if Output_Freq  ==0
				    POST_Substep = Real_Iteras;
				else
				    POST_Substep = num_Output_Sub;
				end
			elseif Key_Dynamic ==0
			    if Output_Freq==0
				    POST_Substep = Real_Sub;
				else
			    	POST_Substep = num_Output_Sub;
				end
			end
		else
		    disp('    Error :: Unrecognized parameters of *POST_Substep.') 
		    Error_Message
		end
	elseif length(POST_Substep) == 5
		if  lower(POST_Substep) == 'first'
			POST_Substep = 1;
		else 
			disp('    Error :: Unrecognized parameters of *POST_Substep.') 
		    Error_Message
		end
	else
	    disp('    Error :: Unrecognized parameters of *POST_Substep.') 
		Error_Message
	end
end


%若存在，则读取局部加密后的网格节点坐标及单元编号, 2021-06-30.
if exist([Full_Pathname,'.nodr_',num2str(POST_Substep)], 'file') ==2
    disp('    > Reading refined mesh....') 
    Node_Coor   = load([Full_Pathname,'.nodr_',num2str(POST_Substep)]);
	Elem_Info   = load([Full_Pathname,'.eler_',num2str(POST_Substep)]);
	Elem_Node = Elem_Info(:,1:8);
	Elem_Material = Elem_Info(:,9);       % Material number of elements
	num_of_Material = max(Elem_Material); % Number of materials
	% Get the numbers of nodes, elements, boundaries and forces.
	Num_Node = size(Node_Coor,1);
	Num_Elem = size(Elem_Node,1);
	% Initial Element_Info Matrix.
	Elemet_Info = zeros(Num_Elem,10);
	for i=1:Num_Elem
		Elemet_Info(i,1) = i;
	end
	% Initial Node_Info Matrix.
	Node_Info   = zeros(Num_Node,10);
	for i=1:Num_Node
		Node_Info(i,1) = i;
	end
	% Initial "Yes_Checked" Matrix, flag for initiation check.
	Yes_Checked = zeros(Num_Elem,1);	
	% Get the max and min value of node coordinates.
	Max_X_Coor = max(max(Node_Coor(:,1)));
	Min_X_Coor = min(min(Node_Coor(:,1)));
	Max_Y_Coor = max(max(Node_Coor(:,2)));
	Min_Y_Coor = min(min(Node_Coor(:,2)));
	Max_Z_Coor = max(max(Node_Coor(:,3)));
	Min_Z_Coor = min(min(Node_Coor(:,3)));	
	
	% Get the maximum & minimum & average volume.
	% Num_Elem
	% for i=1:Num_Elem
		% N1  = Elem_Node(i,1);                                                  % Node 1 for current element
		% N2  = Elem_Node(i,2);                                                  % Node 2 for current element
		% N3  = Elem_Node(i,3);                                                  % Node 3 for current element
		% N4  = Elem_Node(i,4);                                                  % Node 4 for current element
		% N5  = Elem_Node(i,5);                                                  % Node 1 for current element
		% N6  = Elem_Node(i,6);                                                  % Node 2 for current element
		% N7  = Elem_Node(i,7);                                                  % Node 3 for current element
		% N8  = Elem_Node(i,8);                                                  % Node 4 for current element	
		% NN = [N1 N2 N3 N4 N5 N6 N7 N8];                                        % 8 nodes of the current element  
		% X_NODES = Node_Coor(NN,1);                                             % Coordinates of the four nodes of the current element
		% Y_NODES = Node_Coor(NN,2);
		% Z_NODES = Node_Coor(NN,3);
		%--------------------------------
		%Get the volume of each element.
		%--------------------------------
		% shp = alphaShape(X_NODES,Y_NODES,Z_NODES); %Matlab内置函数,根据坐标生成几何体
		% volume_ele(i) = volume(shp);               %Matlab内置函数,计算生成的几何体的体积
	% end

	% max_volume_ele = max(volume_ele);
	% min_volume_ele = min(volume_ele);
	% aveg_volume_ele = mean(volume_ele);	
	
	%单元平均体积. 2022-11-14. NEWFTU-2022111401.
    aveg_volume_ele = Ave_Elem_L^3;
	
	% Get G_NN,G_X_NODES,G_Y_NODES,G_X_Min,G_X_Max,G_Y_Min,G_Y_Max,G means Global.
	G_NN      = zeros(8,Num_Elem);
	G_X_NODES = zeros(8,Num_Elem);
	G_Y_NODES = zeros(8,Num_Elem);
	G_Z_NODES = zeros(8,Num_Elem);
	G_X_Min   = zeros(1,Num_Elem);
	G_X_Max   = zeros(1,Num_Elem);
	G_Y_Min   = zeros(1,Num_Elem);
	G_Y_Max   = zeros(1,Num_Elem);
	G_Z_Min   = zeros(1,Num_Elem);
	G_Z_Max   = zeros(1,Num_Elem);

	G_NN = [Elem_Node(:,1)';Elem_Node(:,2)';Elem_Node(:,3)';Elem_Node(:,4)';
			Elem_Node(:,5)';Elem_Node(:,6)';Elem_Node(:,7)';Elem_Node(:,8)';];

	G_X_NODES = [Node_Coor(G_NN(1,:),1)';Node_Coor(G_NN(2,:),1)';Node_Coor(G_NN(3,:),1)';Node_Coor(G_NN(4,:),1)';
				 Node_Coor(G_NN(5,:),1)';Node_Coor(G_NN(6,:),1)';Node_Coor(G_NN(7,:),1)';Node_Coor(G_NN(8,:),1)'];
	G_Y_NODES = [Node_Coor(G_NN(1,:),2)';Node_Coor(G_NN(2,:),2)';Node_Coor(G_NN(3,:),2)';Node_Coor(G_NN(4,:),2)';
				 Node_Coor(G_NN(5,:),2)';Node_Coor(G_NN(6,:),2)';Node_Coor(G_NN(7,:),2)';Node_Coor(G_NN(8,:),2)'];
	G_Z_NODES = [Node_Coor(G_NN(1,:),3)';Node_Coor(G_NN(2,:),3)';Node_Coor(G_NN(3,:),3)';Node_Coor(G_NN(4,:),3)';
				 Node_Coor(G_NN(5,:),3)';Node_Coor(G_NN(6,:),3)';Node_Coor(G_NN(7,:),3)';Node_Coor(G_NN(8,:),3)'];
	G_X_Min   = min(G_X_NODES,[],1);
	G_X_Max   = max(G_X_NODES,[],1);
	G_Y_Min   = min(G_Y_NODES,[],1);
	G_Y_Max   = max(G_Y_NODES,[],1);
	G_Z_Min   = min(G_Z_NODES,[],1);
	G_Z_Max   = max(G_Z_NODES,[],1);
end

% Read nodal displacement file.
disp('    > Reading nodal displacement file....') 
% DISP= load([Full_Pathname,'.disn_',num2str(POST_Substep)]);
if exist([Full_Pathname,'.disn_',num2str(POST_Substep)], 'file') ==2 
	if Key_Data_Format==1 
		DISP   = load([Full_Pathname,'.disn_',num2str(POST_Substep)]);
	elseif Key_Data_Format==2  %Binary
		c_file = fopen([Full_Pathname,'.disn_',num2str(POST_Substep)],'rb');
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
end

% Read elek file. 2022-11-28. NEWFTU-2022112801. 固体单元渗透率文件读取.
disp('    > Reading element permeability file....') 
if exist([Full_Pathname,'.elek_',num2str(POST_Substep)], 'file') ==2 
	if Key_Data_Format==1 
		Ele_Permeability_3D   = load([Full_Pathname,'.elek_',num2str(POST_Substep)]);
	elseif Key_Data_Format==2  %Binary
		c_file = fopen([Full_Pathname,'.elek_',num2str(POST_Substep)],'rb');
		[cc_Permeability,cc_count]   = fread(c_file,inf,'double');
		fclose(c_file);
		%转换成Matlab中的数据格式
		Tem_Ele_Permeability_3D = (reshape(cc_Permeability,6,cc_count/6))';
		Ele_Permeability_3D(1:cc_count/6,1:6) = Tem_Ele_Permeability_3D(1:cc_count/6,1:6);		
	end
else
    Ele_Permeability_3D = [];
end

% Read nodal displacement file with enriched DOFs. 2022-06-19. NEWFTU-2022061901.
disp('    > Reading nodal displacement file with enriched DOFs....') 
if exist([Full_Pathname,'.disp_',num2str(POST_Substep)], 'file') ==2 
	if Key_Data_Format==1 
		DISP_with_XFEM   = load([Full_Pathname,'.disp_',num2str(POST_Substep)]);
	end
else
    DISP_with_XFEM = [];
end

% Read wellbore file. NEWFTU-2022041901.
disp('    > Reading wellbore file....') 
if exist([Full_Pathname,'.wbif'], 'file') ==2 
	Temp_1   = load([Full_Pathname,'.wbif']);
	num_Wellbore    = Temp_1(1);
	num_Points_WB_1 = Temp_1(2);
    num_Points_WB_2 = Temp_1(3);
	num_Points_WB_3 = Temp_1(4);
    num_Points_WB_4 = Temp_1(5);
	num_Points_WB_5 = Temp_1(6);
	if num_Wellbore>=1 
	    Wellbore_1(1:10,1:3)   = load([Full_Pathname,'.wbco_1']);
	end
	if num_Wellbore>=2 
	    Wellbore_2(1:10,1:3)   = load([Full_Pathname,'.wbco_2']);
	end
	if num_Wellbore>=3 
	    Wellbore_3(1:10,1:3)   = load([Full_Pathname,'.wbco_3']);
	end
	if num_Wellbore>=4 
	    Wellbore_4(1:10,1:3)   = load([Full_Pathname,'.wbco_4']);
	end
	if num_Wellbore>=5 
	    Wellbore_5(1:10,1:3)   = load([Full_Pathname,'.wbco_5']);
	end	
end
if exist([Full_Pathname,'.wbfp'], 'file') ==2 
	Frac_Stage_Points   = load([Full_Pathname,'.wbfp']);
else
    Frac_Stage_Points   = [];
end
% Read nodal displacement file,柱坐标系.
disp('    > Reading nodal displacement (in cylindrical coodinates) file....') 
% DISP= load([Full_Pathname,'.disn_',num2str(POST_Substep)]);
if exist([Full_Pathname,'.dinc_',num2str(POST_Substep)], 'file') ==2 
	if Key_Data_Format==1 
		DISP_Cylinder_CS   = load([Full_Pathname,'.dinc_',num2str(POST_Substep)]);
	elseif Key_Data_Format==2  %Binary
		c_file = fopen([Full_Pathname,'.dinc_',num2str(POST_Substep)],'rb');
		[cc_DISP,cc_count]   = fread(c_file,inf,'double');
		fclose(c_file);
		%转换成Matlab中的数据格式
		for ccc_i=1:cc_count/3
			DISP_Cylinder_CS(ccc_i,1) = ccc_i;
			DISP_Cylinder_CS(ccc_i,2) = cc_DISP(ccc_i*3-2);
			DISP_Cylinder_CS(ccc_i,3) = cc_DISP(ccc_i*3-1);
			DISP_Cylinder_CS(ccc_i,4) = cc_DISP(ccc_i*3);
		end
	end
end

% Read nodal stress file.
disp('    > Reading nodal stress file....') 
%读取节点应力
if Key_Data_Format==1 
	if exist([Full_Pathname,'.strn_',num2str(POST_Substep)], 'file') ==2 
		Stress_Matrix = load([Full_Pathname,'.strn_',num2str(POST_Substep)]);
		%计算Mises应力. 2022-12-22.
		for i_Node=1:size(Stress_Matrix,1)
		    stress_x = Stress_Matrix(i_Node,1);
			stress_y = Stress_Matrix(i_Node,2);
			stress_z = Stress_Matrix(i_Node,3);
			stress_xy = Stress_Matrix(i_Node,4);
			stress_yz = Stress_Matrix(i_Node,5);
			stress_xz = Stress_Matrix(i_Node,6);
		    Stress_Matrix(i_Node,7) = sqrt(((stress_x-stress_y)^2 + (stress_y-stress_z)^2 +(stress_x-stress_z)^2 + 6.0*(stress_xy^2+stress_yz^2+stress_xz^2))/2.0);
			% ppp = Stress_Matrix(i_Node,7)
		end
	else
		Stress_Matrix =[];
	end
	% size(Stress_Matrix,2)
elseif Key_Data_Format==2  %Binary
	if exist([Full_Pathname,'.strn_',num2str(POST_Substep)], 'file') ==2 
		c_file = fopen([Full_Pathname,'.strn_',num2str(POST_Substep)],'rb');
		[cc_Stress_Matrix,cc_count]   = fread(c_file,inf,'double');
		fclose(c_file);
		%转换成Matlab中的数据格式
		% for ccc_i=1:cc_count/7
			% Stress_Matrix(ccc_i,1) = ccc_i;
			% Stress_Matrix(ccc_i,2) = cc_Stress_Matrix(ccc_i*7-6);
			% Stress_Matrix(ccc_i,3) = cc_Stress_Matrix(ccc_i*7-5);
			% Stress_Matrix(ccc_i,4) = cc_Stress_Matrix(ccc_i*7-4);			
			% Stress_Matrix(ccc_i,5) = cc_Stress_Matrix(ccc_i*7-3);
			% Stress_Matrix(ccc_i,6) = cc_Stress_Matrix(ccc_i*7-2);
			% Stress_Matrix(ccc_i,7) = cc_Stress_Matrix(ccc_i*7-1);
			% Stress_Matrix(ccc_i,8) = cc_Stress_Matrix(ccc_i*7);
            % 2022-12-22.
			% Stress_Matrix(ccc_i,1) = cc_Stress_Matrix(ccc_i*7-6);
			% Stress_Matrix(ccc_i,2) = cc_Stress_Matrix(ccc_i*7-5);
			% Stress_Matrix(ccc_i,3) = cc_Stress_Matrix(ccc_i*7-4);			
			% Stress_Matrix(ccc_i,4) = cc_Stress_Matrix(ccc_i*7-3);
			% Stress_Matrix(ccc_i,5) = cc_Stress_Matrix(ccc_i*7-2);
			% Stress_Matrix(ccc_i,6) = cc_Stress_Matrix(ccc_i*7-1);
			% Stress_Matrix(ccc_i,7) = cc_Stress_Matrix(ccc_i*7);			
		% end
		%2023-05-07.	
		Stress_Matrix = (reshape(cc_Stress_Matrix,7,cc_count/7))';			
	else
		Stress_Matrix =[];
	end		
end


% Read nodal stress file,柱坐标系.
disp('    > Reading nodal stress (in cylindrical coodinates) file....') 
%读取节点应力
if Key_Data_Format==1 
	if exist([Full_Pathname,'.stnc_',num2str(POST_Substep)], 'file') ==2 
		Stress_Matrix_Cylinder_CS = load([Full_Pathname,'.stnc_',num2str(POST_Substep)]);
	else
		Stress_Matrix_Cylinder_CS =[];
	end
elseif Key_Data_Format==2  %Binary
	if exist([Full_Pathname,'.stnc_',num2str(POST_Substep)], 'file') ==2 
		c_file = fopen([Full_Pathname,'.stnc_',num2str(POST_Substep)],'rb');
		[cc_Stress_Matrix,cc_count]   = fread(c_file,inf,'double');
		fclose(c_file);
		%转换成Matlab中的数据格式
		for ccc_i=1:cc_count/7
			Stress_Matrix_Cylinder_CS(ccc_i,1) = ccc_i;
			Stress_Matrix_Cylinder_CS(ccc_i,2) = cc_Stress_Matrix(ccc_i*7-6);
			Stress_Matrix_Cylinder_CS(ccc_i,3) = cc_Stress_Matrix(ccc_i*7-5);
			Stress_Matrix_Cylinder_CS(ccc_i,4) = cc_Stress_Matrix(ccc_i*7-4);			
			Stress_Matrix_Cylinder_CS(ccc_i,5) = cc_Stress_Matrix(ccc_i*7-3);
			Stress_Matrix_Cylinder_CS(ccc_i,6) = cc_Stress_Matrix(ccc_i*7-2);
			Stress_Matrix_Cylinder_CS(ccc_i,7) = cc_Stress_Matrix(ccc_i*7-1);
			Stress_Matrix_Cylinder_CS(ccc_i,8) = cc_Stress_Matrix(ccc_i*7);
		end
	else
		Stress_Matrix_Cylinder_CS =[];
	end		
end

% Read nodal strain file.
disp('    > Reading nodal strain file....') 
%读取节点应变
if Key_Data_Format==1 
	if exist([Full_Pathname,'.sran_',num2str(POST_Substep)], 'file') ==2 
		Strain_Matrix = load([Full_Pathname,'.sran_',num2str(POST_Substep)]);
	else
		Strain_Matrix =[];
	end
elseif Key_Data_Format==2  %Binary
	if exist([Full_Pathname,'.sran_',num2str(POST_Substep)], 'file') ==2 
		c_file = fopen([Full_Pathname,'.sran_',num2str(POST_Substep)],'rb');
		[cc_Strain_Matrix,cc_count]   = fread(c_file,inf,'double');
		fclose(c_file);
		%转换成Matlab中的数据格式
		for ccc_i=1:cc_count/7
			Strain_Matrix(ccc_i,1) = ccc_i;
			Strain_Matrix(ccc_i,2) = cc_Strain_Matrix(ccc_i*7-6);
			Strain_Matrix(ccc_i,3) = cc_Strain_Matrix(ccc_i*7-5);
			Strain_Matrix(ccc_i,4) = cc_Strain_Matrix(ccc_i*7-4);			
			Strain_Matrix(ccc_i,5) = cc_Strain_Matrix(ccc_i*7-3);
			Strain_Matrix(ccc_i,6) = cc_Strain_Matrix(ccc_i*7-2);
			Strain_Matrix(ccc_i,7) = cc_Strain_Matrix(ccc_i*7-1);
			Strain_Matrix(ccc_i,8) = cc_Strain_Matrix(ccc_i*7);
		end
	else
		Strain_Matrix =[];
	end		
end

% Read nodal strain (in Cylinderal CS) file.
disp('    > Reading nodal strain (in Cylinderal CS) file....') 
%读取节点应变
if Key_Data_Format==1 
	if exist([Full_Pathname,'.srac_',num2str(POST_Substep)], 'file') ==2 
		Strain_Matrix_in_Cylinder_CS = load([Full_Pathname,'.srac_',num2str(POST_Substep)]);
	else
		Strain_Matrix_in_Cylinder_CS =[];
	end
elseif Key_Data_Format==2  %Binary
	if exist([Full_Pathname,'.srac_',num2str(POST_Substep)], 'file') ==2 
		c_file = fopen([Full_Pathname,'.srac_',num2str(POST_Substep)],'rb');
		[cc_Strain_Matrix,cc_count]   = fread(c_file,inf,'double');
		fclose(c_file);
		%转换成Matlab中的数据格式
		for ccc_i=1:cc_count/7
			Strain_Matrix_in_Cylinder_CS(ccc_i,1) = ccc_i;
			Strain_Matrix_in_Cylinder_CS(ccc_i,2) = cc_Strain_Matrix(ccc_i*7-6);
			Strain_Matrix_in_Cylinder_CS(ccc_i,3) = cc_Strain_Matrix(ccc_i*7-5);
			Strain_Matrix_in_Cylinder_CS(ccc_i,4) = cc_Strain_Matrix(ccc_i*7-4);			
			Strain_Matrix_in_Cylinder_CS(ccc_i,5) = cc_Strain_Matrix(ccc_i*7-3);
			Strain_Matrix_in_Cylinder_CS(ccc_i,6) = cc_Strain_Matrix(ccc_i*7-2);
			Strain_Matrix_in_Cylinder_CS(ccc_i,7) = cc_Strain_Matrix(ccc_i*7-1);
			Strain_Matrix_in_Cylinder_CS(ccc_i,8) = cc_Strain_Matrix(ccc_i*7);
		end
	else
		Strain_Matrix_in_Cylinder_CS =[];
	end		
end

% Read force file.
disp('    > Reading force file....') 
Force_X_Matrix = load([Full_Pathname,'.focx']);
Force_Y_Matrix = load([Full_Pathname,'.focy']);
Force_Z_Matrix = load([Full_Pathname,'.focz']);

% Read Boundary file.
disp('    > Reading Boundary file....') 
Boundary_X_Matrix = load([Full_Pathname,'.boux']);
Boundary_Y_Matrix = load([Full_Pathname,'.bouy']);
Boundary_Z_Matrix = load([Full_Pathname,'.bouz']);

% Read outl file.
disp('    > Reading outl (model outlines) file....') 
Model_Outline =[];
if exist([Full_Pathname,'.outl'], 'file') ==2 
	if Key_Data_Format==1 
		Model_Outline = load([Full_Pathname,'.outl']);
	elseif Key_Data_Format==2  %Binary
		c_file = fopen([Full_Pathname,'.outl'],'rb');
		[cc_Model_Outline,cc_count]   = fread(c_file,inf,'int');
		fclose(c_file);
		Model_Outline = (reshape(cc_Model_Outline,2,cc_count/2))';
	end
end

% Read outa file.
disp('    > Reading outa (model outareas) file....') 
Model_OutArea = [];
if exist([Full_Pathname,'.outa'], 'file') ==2 
	if Key_Data_Format==1 
		Model_OutArea = load([Full_Pathname,'.outa']);
	elseif Key_Data_Format==2  %Binary
		c_file = fopen([Full_Pathname,'.outa'],'rb');
		[cc_Model_OutArea,cc_count]   = fread(c_file,inf,'int');
		fclose(c_file);
		Model_OutArea = (reshape(cc_Model_OutArea,2,cc_count/2))';
	end
end

% Read outn file.
disp('    > Reading outn (model surface nodes) file....') 
Model_Surface_Nodes = [];
if exist([Full_Pathname,'.outn'], 'file') ==2 
	if Key_Data_Format==1 
		Model_Surface_Nodes = load([Full_Pathname,'.outn']);
	elseif Key_Data_Format==2  %Binary
		c_file = fopen([Full_Pathname,'.outn'],'rb');
		[Model_Surface_Nodes,cc_count]   = fread(c_file,inf,'int');
		fclose(c_file);
	end
end

% Read coordinates and other info of cracks if cracks exist.
if num_Crack(POST_Substep) ~= 0
	disp('    > Reading coordinates of cracks....') 
	file_Crack_X = fopen([Full_Pathname,'.crax_',num2str(POST_Substep)]);
	file_Crack_Y = fopen([Full_Pathname,'.cray_',num2str(POST_Substep)]);
	file_Crack_Z = fopen([Full_Pathname,'.craz_',num2str(POST_Substep)]);
	Crack_X = cell(num_Crack(POST_Substep));
	Crack_Y = cell(num_Crack(POST_Substep));
	Crack_Z = cell(num_Crack(POST_Substep));
	for i=1:num_Crack(POST_Substep) 
		Crack_X{i} = str2num(fgetl(file_Crack_X));
        Crack_Y{i} = str2num(fgetl(file_Crack_Y));
		Crack_Z{i} = str2num(fgetl(file_Crack_Z));
	end
	fclose(file_Crack_X);
	fclose(file_Crack_Y);
	fclose(file_Crack_Z);
	
	% disp('    > Reading ennd file....') 
	if Key_Data_Format==1 
	    Enriched_Node_Type = load([Full_Pathname,'.ennd_',num2str(POST_Substep)]);
	elseif Key_Data_Format==2  %Binary
	    c_file = fopen([Full_Pathname,'.ennd_',num2str(POST_Substep)],'rb');
		[cc_Enriched_Node_Type,cc_count]   = fread(c_file,inf,'int');
		% [cc_Enriched_Node_Type,cc_count]   = fread(c_file,inf,'int8');  %适配Fortran Kind=1. IMPROV-2022091801.
		fclose(c_file);
		%转换成Matlab中的数据格式
		Enriched_Node_Type = (reshape(cc_Enriched_Node_Type,num_Crack(POST_Substep),Num_Node))';
	end		
	% disp('    > Reading posi file....') 
	if Key_Data_Format==1 
	    POS = load([Full_Pathname,'.posi_',num2str(POST_Substep)]);
	elseif Key_Data_Format==2  %Binary
	    c_file = fopen([Full_Pathname,'.posi_',num2str(POST_Substep)],'rb');
		[cc_POS,cc_count]   = fread(c_file,inf,'int');
		fclose(c_file);
		%转换成Matlab中的数据格式
		POS = (reshape(cc_POS,num_Crack(POST_Substep),Num_Node))';
	end

	
	% disp('    > Reading elty file....');
	if Key_Data_Format==1 
		Elem_Type = load([Full_Pathname,'.elty_',num2str(POST_Substep)]);
	elseif Key_Data_Format==2  %Binary
		c_file = fopen([Full_Pathname,'.elty_',num2str(POST_Substep)],'rb');
		[cc_Elem_Type,cc_count]   = fread(c_file,inf,'int');
		% [cc_Elem_Type,cc_count]   = fread(c_file,inf,'int8'); %适配Fortran Kind=1. IMPROV-2022091801.
		fclose(c_file);
		%转换成Matlab中的数据格式
		Elem_Type = (reshape(cc_Elem_Type,num_Crack(POST_Substep),Num_Elem))';
	end		
	%读取裂缝面节点坐标
	file_Crack_node_X = fopen([Full_Pathname,'.cnox_',num2str(POST_Substep)]);
	file_Crack_node_Y = fopen([Full_Pathname,'.cnoy_',num2str(POST_Substep)]);
	file_Crack_node_Z = fopen([Full_Pathname,'.cnoz_',num2str(POST_Substep)]);
	Crack_node_X = cell(num_Crack(POST_Substep));
	Crack_node_Y = cell(num_Crack(POST_Substep));
	Crack_node_Z = cell(num_Crack(POST_Substep));
	for i=1:num_Crack(POST_Substep) 
		Crack_node_X{i} = str2num(fgetl(file_Crack_node_X));
        Crack_node_Y{i} = str2num(fgetl(file_Crack_node_Y));
		Crack_node_Z{i} = str2num(fgetl(file_Crack_node_Z));
	end
	fclose(file_Crack_node_X);
	fclose(file_Crack_node_Y);
	fclose(file_Crack_node_Z);
	
	%读取裂缝面节点所在单元局部坐标
	if exist([Full_Pathname,'.cnlx_',num2str(POST_Substep)], 'file') ==2 
		file_Crack_node_local_X = fopen([Full_Pathname,'.cnlx_',num2str(POST_Substep)]);
		file_Crack_node_local_Y = fopen([Full_Pathname,'.cnly_',num2str(POST_Substep)]);
		file_Crack_node_local_Z = fopen([Full_Pathname,'.cnlz_',num2str(POST_Substep)]);
		Crack_node_local_X = cell(num_Crack(POST_Substep));
		Crack_node_local_Y = cell(num_Crack(POST_Substep));
		Crack_node_local_Z = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack_node_local_X{i} = str2num(fgetl(file_Crack_node_local_X));
			Crack_node_local_Y{i} = str2num(fgetl(file_Crack_node_local_Y));
			Crack_node_local_Z{i} = str2num(fgetl(file_Crack_node_local_Z));
		end
		fclose(file_Crack_node_local_X);
		fclose(file_Crack_node_local_Y);
		fclose(file_Crack_node_local_Z);	
	else
	    Crack_node_local_X=[];
		Crack_node_local_Y=[];
		Crack_node_local_Z=[];
	end
	%读取裂尖增强单元的基准线.
	if exist([Full_Pathname,'.blab_',num2str(POST_Substep)], 'file') ==2 
	    if Key_Data_Format == 1
		    Tip_Enriched_Ele_BaseLine = load([Full_Pathname,'.blab_',num2str(POST_Substep)]);
		elseif Key_Data_Format == 2  %binary. 2022-07-19.
			c_file = fopen([Full_Pathname,'.blab_',num2str(POST_Substep)],'rb');
			[cc_Tip_Enriched_Ele_BaseLine,cc_count]   = fread(c_file,inf,'double');
			fclose(c_file);
			%转换成Matlab中的数据格式
			Tip_Enriched_Ele_BaseLine = (reshape(cc_Tip_Enriched_Ele_BaseLine,6,Num_Elem))';
		end
	else
		Tip_Enriched_Ele_BaseLine =[];
	end
	%读取裂尖节点对应的增强单元号(参考单元号)及裂缝号,2021-02-10.
	if exist([Full_Pathname,'.tere_',num2str(POST_Substep)], 'file') ==2 
	    if Key_Data_Format == 1
            Tip_Enriched_Node_Ref_Element = load([Full_Pathname,'.tere_',num2str(POST_Substep)]);
		elseif Key_Data_Format == 2  %binary. 2022-07-19.
			c_file = fopen([Full_Pathname,'.tere_',num2str(POST_Substep)],'rb');
			[cc_Tip_Enriched_Node_Ref_Element,cc_count]   = fread(c_file,inf,'int');
			fclose(c_file);
			Tip_Enriched_Node_Ref_Element = (reshape(cc_Tip_Enriched_Node_Ref_Element,2,cc_count/2))';
		end			
	else
		Tip_Enriched_Node_Ref_Element =[];
	end	
    %读取裂尖增强单元的基准线局部坐标系的x轴.
	if exist([Full_Pathname,'.blvx_',num2str(POST_Substep)], 'file') ==2 
	    if Key_Data_Format == 1
            Tip_Enriched_Ele_BaseLine_Vector_x = load([Full_Pathname,'.blvx_',num2str(POST_Substep)]);
		elseif Key_Data_Format == 2  %binary. 2022-07-19.
			c_file = fopen([Full_Pathname,'.blvx_',num2str(POST_Substep)],'rb');
			[cc_Tip_Enriched_Ele_BaseLine_Vector_x,cc_count]   = fread(c_file,inf,'double');
			fclose(c_file);
			%转换成Matlab中的数据格式.
			Tip_Enriched_Ele_BaseLine_Vector_x = (reshape(cc_Tip_Enriched_Ele_BaseLine_Vector_x,3,Num_Elem))';
		end		
	else
		Tip_Enriched_Ele_BaseLine_Vector_x =[];
	end	
    %读取裂尖增强单元的基准线局部坐标系的y轴.
	if exist([Full_Pathname,'.blvy_',num2str(POST_Substep)], 'file') ==2 
	    if Key_Data_Format == 1
            Tip_Enriched_Ele_BaseLine_Vector_y = load([Full_Pathname,'.blvy_',num2str(POST_Substep)]);
		elseif Key_Data_Format == 2  %binary. 2022-07-19.
			c_file = fopen([Full_Pathname,'.blvy_',num2str(POST_Substep)],'rb');
			[cc_Tip_Enriched_Ele_BaseLine_Vector_y,cc_count]   = fread(c_file,inf,'double');
			fclose(c_file);
			%转换成Matlab中的数据格式.
			Tip_Enriched_Ele_BaseLine_Vector_y = (reshape(cc_Tip_Enriched_Ele_BaseLine_Vector_y,3,Num_Elem))';
		end	
	else
		Tip_Enriched_Ele_BaseLine_Vector_y =[];
	end	
    %读取裂尖增强单元的基准线局部坐标系的z轴.	
	if exist([Full_Pathname,'.blvz_',num2str(POST_Substep)], 'file') ==2 
	    if Key_Data_Format == 1
            Tip_Enriched_Ele_BaseLine_Vector_z = load([Full_Pathname,'.blvz_',num2str(POST_Substep)]);
		elseif Key_Data_Format == 2  %binary. 2022-07-19.
			c_file = fopen([Full_Pathname,'.blvz_',num2str(POST_Substep)],'rb');
			[cc_Tip_Enriched_Ele_BaseLine_Vector_z,cc_count]   = fread(c_file,inf,'double');
			fclose(c_file);
			%转换成Matlab中的数据格式.
			Tip_Enriched_Ele_BaseLine_Vector_z = (reshape(cc_Tip_Enriched_Ele_BaseLine_Vector_z,3,Num_Elem))';
		end	
	else
		Tip_Enriched_Ele_BaseLine_Vector_z =[];
	end		
	%读取裂缝面离散单元.
	file_Crack_Ele_1 = fopen([Full_Pathname,'.cms1_',num2str(POST_Substep)]);
	file_Crack_Ele_2 = fopen([Full_Pathname,'.cms2_',num2str(POST_Substep)]);
	file_Crack_Ele_3 = fopen([Full_Pathname,'.cms3_',num2str(POST_Substep)]);
	Crack_Ele_1 = cell(num_Crack(POST_Substep));
	Crack_Ele_2 = cell(num_Crack(POST_Substep));
	Crack_Ele_3 = cell(num_Crack(POST_Substep));
	for i=1:num_Crack(POST_Substep) 
		Crack_Ele_1{i} = str2num(fgetl(file_Crack_Ele_1));
        Crack_Ele_2{i} = str2num(fgetl(file_Crack_Ele_2));
		Crack_Ele_3{i} = str2num(fgetl(file_Crack_Ele_3));
	end
	fclose(file_Crack_Ele_1);
	fclose(file_Crack_Ele_2);
	fclose(file_Crack_Ele_3);	
	
	%读取裂缝面离散单元节点所在的单元号（模型单元号）.
	if exist([Full_Pathname,'.cmse_',num2str(POST_Substep)], 'file') ==2 
		file_Crack_Node_in_Ele = fopen([Full_Pathname,'.cmse_',num2str(POST_Substep)]);
		Crack_Node_in_Ele = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack_Node_in_Ele{i} = str2num(fgetl(file_Crack_Node_in_Ele));
		end
		fclose(file_Crack_Node_in_Ele);	
	else
	    Crack_Node_in_Ele=[];
	end
	
	%读取离散裂缝面外边界节点.
	if exist([Full_Pathname,'.cmso_',num2str(POST_Substep)], 'file') ==2 
		file_Crack3D_Meshed_Outline= fopen([Full_Pathname,'.cmso_',num2str(POST_Substep)]);
		Crack3D_Meshed_Outline = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_Meshed_Outline{i} = str2num(fgetl(file_Crack3D_Meshed_Outline));
		end
		fclose(file_Crack3D_Meshed_Outline);
	else
	    Crack3D_Meshed_Outline=[];
	end
	
	%读取裂缝面前缘点最小主应力方向
	if exist([Full_Pathname,'.cndx_',num2str(POST_Substep)], 'file') ==2 
		file_Crack3D_Vector_S1_X = fopen([Full_Pathname,'.cndx_',num2str(POST_Substep)]);
		file_Crack3D_Vector_S1_Y = fopen([Full_Pathname,'.cndy_',num2str(POST_Substep)]);
		file_Crack3D_Vector_S1_Z = fopen([Full_Pathname,'.cndz_',num2str(POST_Substep)]);
		Crack3D_Vector_S1_X = cell(num_Crack(POST_Substep));
		Crack3D_Vector_S1_Y = cell(num_Crack(POST_Substep));
		Crack3D_Vector_S1_Z = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_Vector_S1_X{i} = str2num(fgetl(file_Crack3D_Vector_S1_X));
			Crack3D_Vector_S1_Y{i} = str2num(fgetl(file_Crack3D_Vector_S1_Y));
			Crack3D_Vector_S1_Z{i} = str2num(fgetl(file_Crack3D_Vector_S1_Z));
		end
		fclose(file_Crack3D_Vector_S1_X);
		fclose(file_Crack3D_Vector_S1_Y);
		fclose(file_Crack3D_Vector_S1_Z);
	end
	
	%读取裂缝面边界节点的局部坐标系.
	if exist([Full_Pathname,'.cvxx_',num2str(POST_Substep)], 'file') ==2 
		file_Crack3D_Vertex_Vector_X_X = fopen([Full_Pathname,'.cvxx_',num2str(POST_Substep)]);
		file_Crack3D_Vertex_Vector_X_Y = fopen([Full_Pathname,'.cvxy_',num2str(POST_Substep)]);
		file_Crack3D_Vertex_Vector_X_Z = fopen([Full_Pathname,'.cvxz_',num2str(POST_Substep)]);
		file_Crack3D_Vertex_Vector_Y_X = fopen([Full_Pathname,'.cvyx_',num2str(POST_Substep)]);
		file_Crack3D_Vertex_Vector_Y_Y = fopen([Full_Pathname,'.cvyy_',num2str(POST_Substep)]);
		file_Crack3D_Vertex_Vector_Y_Z = fopen([Full_Pathname,'.cvyz_',num2str(POST_Substep)]);
		file_Crack3D_Vertex_Vector_Z_X = fopen([Full_Pathname,'.cvzx_',num2str(POST_Substep)]);
		file_Crack3D_Vertex_Vector_Z_Y = fopen([Full_Pathname,'.cvzy_',num2str(POST_Substep)]);
		file_Crack3D_Vertex_Vector_Z_Z = fopen([Full_Pathname,'.cvzz_',num2str(POST_Substep)]);	
		Crack3D_Vertex_Vector_X_X = cell(num_Crack(POST_Substep));
		Crack3D_Vertex_Vector_X_Y = cell(num_Crack(POST_Substep));
		Crack3D_Vertex_Vector_X_Z = cell(num_Crack(POST_Substep));
		Crack3D_Vertex_Vector_Y_X = cell(num_Crack(POST_Substep));
		Crack3D_Vertex_Vector_Y_Y = cell(num_Crack(POST_Substep));
		Crack3D_Vertex_Vector_Y_Z = cell(num_Crack(POST_Substep));
		Crack3D_Vertex_Vector_Z_X = cell(num_Crack(POST_Substep));
		Crack3D_Vertex_Vector_Z_Y = cell(num_Crack(POST_Substep));
		Crack3D_Vertex_Vector_Z_Z = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_Vertex_Vector_X_X{i} = str2num(fgetl(file_Crack3D_Vertex_Vector_X_X));
			Crack3D_Vertex_Vector_X_Y{i} = str2num(fgetl(file_Crack3D_Vertex_Vector_X_Y));
			Crack3D_Vertex_Vector_X_Z{i} = str2num(fgetl(file_Crack3D_Vertex_Vector_X_Z));
			Crack3D_Vertex_Vector_Y_X{i} = str2num(fgetl(file_Crack3D_Vertex_Vector_Y_X));
			Crack3D_Vertex_Vector_Y_Y{i} = str2num(fgetl(file_Crack3D_Vertex_Vector_Y_Y));
			Crack3D_Vertex_Vector_Y_Z{i} = str2num(fgetl(file_Crack3D_Vertex_Vector_Y_Z));
			Crack3D_Vertex_Vector_Z_X{i} = str2num(fgetl(file_Crack3D_Vertex_Vector_Z_X));
			Crack3D_Vertex_Vector_Z_Y{i} = str2num(fgetl(file_Crack3D_Vertex_Vector_Z_Y));
			Crack3D_Vertex_Vector_Z_Z{i} = str2num(fgetl(file_Crack3D_Vertex_Vector_Z_Z));		
		end
		fclose(file_Crack3D_Vertex_Vector_X_X);  
		fclose(file_Crack3D_Vertex_Vector_X_Y);
		fclose(file_Crack3D_Vertex_Vector_X_Z);  
		fclose(file_Crack3D_Vertex_Vector_Y_X);  
		fclose(file_Crack3D_Vertex_Vector_Y_Y); 
		fclose(file_Crack3D_Vertex_Vector_Y_Z); 
		fclose(file_Crack3D_Vertex_Vector_Z_X); 
		fclose(file_Crack3D_Vertex_Vector_Z_Y);  
		fclose(file_Crack3D_Vertex_Vector_Z_Z);  
	else
		Crack3D_Vertex_Vector_X_X = [];
		Crack3D_Vertex_Vector_X_Y = [];
		Crack3D_Vertex_Vector_X_Z = [];
		Crack3D_Vertex_Vector_Y_X = [];
		Crack3D_Vertex_Vector_Y_Y = [];
		Crack3D_Vertex_Vector_Y_Z = [];
		Crack3D_Vertex_Vector_Z_X = [];
		Crack3D_Vertex_Vector_Z_Y = [];
		Crack3D_Vertex_Vector_Z_Z = [];
	end
	
	%读取裂缝面流体单元数目cpfn文件.
	Crack3D_Fluid_Ele_Num = [];
	if exist([Full_Pathname,'.cpfn_',num2str(POST_Substep)], 'file') ==2 
		file_cpfn = fopen([Full_Pathname,'.cpfn_',num2str(POST_Substep)]);
		Crack3D_Fluid_Ele_Num = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_Fluid_Ele_Num{i} = str2num(fgetl(file_cpfn));
		end
		fclose(file_cpfn);
	end
	
	%读取裂缝面流体单元计算点编号文件cpno.
	% file_cpno = fopen([Full_Pathname,'.cpno_',num2str(POST_Substep)]);
	% Crack3D_Fluid_Ele_Nodes_All = str2num(fgetl(file_cpno));
	Crack3D_Fluid_Ele_Nodes_All = [];
	if exist([Full_Pathname,'.cpno_',num2str(POST_Substep)], 'file') ==2 
		if Key_Data_Format == 1
			Crack3D_Fluid_Ele_Nodes_All = load([Full_Pathname,'.cpno_',num2str(POST_Substep)]);
		elseif Key_Data_Format == 2  %binary. 2022-07-19.
			c_file = fopen([Full_Pathname,'.cpno_',num2str(POST_Substep)],'rb');
			[cc_Crack3D_Fluid_Ele_Nodes_All,cc_count]   = fread(c_file,inf,'int');
			fclose(c_file);
			Crack3D_Fluid_Ele_Nodes_All = (reshape(cc_Crack3D_Fluid_Ele_Nodes_All,3,cc_count/3))';
		end	
		cc_count  = 0;
		for i=1:num_Crack(POST_Substep) 
			Crack3D_Fluid_Ele_Nodes(i,1:Crack3D_Fluid_Ele_Num{i},1:3) = Crack3D_Fluid_Ele_Nodes_All(cc_count+1:cc_count+Crack3D_Fluid_Ele_Num{i},1:3);
			cc_count  = cc_count + Crack3D_Fluid_Ele_Num{i};
		end
	end
	
	%读取裂缝面计算点坐标文件.
	if exist([Full_Pathname,'.ccpx_',num2str(POST_Substep)], 'file') ==2
		file_Crack3D_CalP_X = fopen([Full_Pathname,'.ccpx_',num2str(POST_Substep)]);
		file_Crack3D_CalP_Y = fopen([Full_Pathname,'.ccpy_',num2str(POST_Substep)]);
		file_Crack3D_CalP_Z = fopen([Full_Pathname,'.ccpz_',num2str(POST_Substep)]);
		Crack3D_CalP_X = cell(num_Crack(POST_Substep));
		Crack3D_CalP_Y = cell(num_Crack(POST_Substep));
		Crack3D_CalP_Z = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
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
	
	%读取裂缝面计算点法向向量文件.
	if exist([Full_Pathname,'.fnnx_',num2str(POST_Substep)], 'file') ==2
		file_Cracks_FluNode_Vector_3D_X = fopen([Full_Pathname,'.fnnx_',num2str(POST_Substep)]);
		file_Cracks_FluNode_Vector_3D_Y = fopen([Full_Pathname,'.fnny_',num2str(POST_Substep)]);
		file_Cracks_FluNode_Vector_3D_Z = fopen([Full_Pathname,'.fnnz_',num2str(POST_Substep)]);
		Cracks_FluNode_Vector_3D_X = cell(num_Crack(POST_Substep));
		Cracks_FluNode_Vector_3D_Y = cell(num_Crack(POST_Substep));
		Cracks_FluNode_Vector_3D_Z = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Cracks_FluNode_Vector_3D_X{i} = str2num(fgetl(file_Cracks_FluNode_Vector_3D_X));
			Cracks_FluNode_Vector_3D_Y{i} = str2num(fgetl(file_Cracks_FluNode_Vector_3D_Y));
			Cracks_FluNode_Vector_3D_Z{i} = str2num(fgetl(file_Cracks_FluNode_Vector_3D_Z));
		end
		fclose(file_Cracks_FluNode_Vector_3D_X);
		fclose(file_Cracks_FluNode_Vector_3D_Y);
		fclose(file_Cracks_FluNode_Vector_3D_Z);	
	else
	    Cracks_FluNode_Vector_3D_X=[];
		Cracks_FluNode_Vector_3D_Y=[];
		Cracks_FluNode_Vector_3D_Z=[];
	end

	%读取裂缝面计算点上偏置点的位移向量，2021-02-11.
	if exist([Full_Pathname,'.fnux_',num2str(POST_Substep)], 'file') ==2
		file_Cracks_CalP_UpDis_3D_X = fopen([Full_Pathname,'.fnux_',num2str(POST_Substep)]);
		file_Cracks_CalP_UpDis_3D_Y = fopen([Full_Pathname,'.fnuy_',num2str(POST_Substep)]);
		file_Cracks_CalP_UpDis_3D_Z = fopen([Full_Pathname,'.fnuz_',num2str(POST_Substep)]);
		Cracks_CalP_UpDis_3D_X = cell(num_Crack(POST_Substep));
		Cracks_CalP_UpDis_3D_Y = cell(num_Crack(POST_Substep));
		Cracks_CalP_UpDis_3D_Z = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Cracks_CalP_UpDis_3D_X{i} = str2num(fgetl(file_Cracks_CalP_UpDis_3D_X));
			Cracks_CalP_UpDis_3D_Y{i} = str2num(fgetl(file_Cracks_CalP_UpDis_3D_Y));
			Cracks_CalP_UpDis_3D_Z{i} = str2num(fgetl(file_Cracks_CalP_UpDis_3D_Z));
		end
		fclose(file_Cracks_CalP_UpDis_3D_X);
		fclose(file_Cracks_CalP_UpDis_3D_Y);
		fclose(file_Cracks_CalP_UpDis_3D_Z);	
	else
	    Cracks_CalP_UpDis_3D_X=[];
		Cracks_CalP_UpDis_3D_Y=[];
		Cracks_CalP_UpDis_3D_Z=[];
	end

	%读取裂缝面计算点下偏置点的位移向量，2021-02-11.
	if exist([Full_Pathname,'.fnlx_',num2str(POST_Substep)], 'file') ==2
		file_Cracks_CalP_LowDis_3D_X = fopen([Full_Pathname,'.fnlx_',num2str(POST_Substep)]);
		file_Cracks_CalP_LowDis_3D_Y = fopen([Full_Pathname,'.fnly_',num2str(POST_Substep)]);
		file_Cracks_CalP_LowDis_3D_Z = fopen([Full_Pathname,'.fnlz_',num2str(POST_Substep)]);
		Cracks_CalP_LowDis_3D_X = cell(num_Crack(POST_Substep));
		Cracks_CalP_LowDis_3D_Y = cell(num_Crack(POST_Substep));
		Cracks_CalP_LowDis_3D_Z = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Cracks_CalP_LowDis_3D_X{i} = str2num(fgetl(file_Cracks_CalP_LowDis_3D_X));
			Cracks_CalP_LowDis_3D_Y{i} = str2num(fgetl(file_Cracks_CalP_LowDis_3D_Y));
			Cracks_CalP_LowDis_3D_Z{i} = str2num(fgetl(file_Cracks_CalP_LowDis_3D_Z));
		end
		fclose(file_Cracks_CalP_LowDis_3D_X);
		fclose(file_Cracks_CalP_LowDis_3D_Y);
		fclose(file_Cracks_CalP_LowDis_3D_Z);	
	else
	    Cracks_CalP_LowDis_3D_X=[];
		Cracks_CalP_LowDis_3D_Y=[];
		Cracks_CalP_LowDis_3D_Z=[];
	end

	%读取流体单元平均法向量文件(其实是Gauss点位置的)，2020-01-22.
	if exist([Full_Pathname,'.fenx_',num2str(POST_Substep)], 'file') ==2
		file_FluidEle_GaussNor_3D_X = fopen([Full_Pathname,'.fenx_',num2str(POST_Substep)]);
		file_FluidEle_GaussNor_3D_Y = fopen([Full_Pathname,'.feny_',num2str(POST_Substep)]);
		file_FluidEle_GaussNor_3D_Z = fopen([Full_Pathname,'.fenz_',num2str(POST_Substep)]);
		FluidEle_GaussNor_3D_X = cell(num_Crack(POST_Substep));
		FluidEle_GaussNor_3D_Y = cell(num_Crack(POST_Substep));
		FluidEle_GaussNor_3D_Z = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			FluidEle_GaussNor_3D_X{i} = str2num(fgetl(file_FluidEle_GaussNor_3D_X));
			FluidEle_GaussNor_3D_Y{i} = str2num(fgetl(file_FluidEle_GaussNor_3D_Y));
			FluidEle_GaussNor_3D_Z{i} = str2num(fgetl(file_FluidEle_GaussNor_3D_Z));
		end
		fclose(file_FluidEle_GaussNor_3D_X);
		fclose(file_FluidEle_GaussNor_3D_Y);
		fclose(file_FluidEle_GaussNor_3D_Z);	
	else
	    FluidEle_GaussNor_3D_X=[];
		FluidEle_GaussNor_3D_Y=[];
		FluidEle_GaussNor_3D_Z=[];
	end
	
	%读取流体单元Gauss点的局部坐标系,2020-01-22.
	if exist([Full_Pathname,'.fexx_',num2str(POST_Substep)], 'file') ==2
		file_FluidEle_LCS_VectorX_X = fopen([Full_Pathname,'.fexx_',num2str(POST_Substep)]);
		file_FluidEle_LCS_VectorX_Y = fopen([Full_Pathname,'.fexy_',num2str(POST_Substep)]);
		file_FluidEle_LCS_VectorX_Z = fopen([Full_Pathname,'.fexz_',num2str(POST_Substep)]);
		file_FluidEle_LCS_VectorY_X = fopen([Full_Pathname,'.feyx_',num2str(POST_Substep)]);
		file_FluidEle_LCS_VectorY_Y = fopen([Full_Pathname,'.feyy_',num2str(POST_Substep)]);
		file_FluidEle_LCS_VectorY_Z = fopen([Full_Pathname,'.feyz_',num2str(POST_Substep)]);
		file_FluidEle_LCS_VectorZ_X = fopen([Full_Pathname,'.fezx_',num2str(POST_Substep)]);
		file_FluidEle_LCS_VectorZ_Y = fopen([Full_Pathname,'.fezy_',num2str(POST_Substep)]);
		file_FluidEle_LCS_VectorZ_Z = fopen([Full_Pathname,'.fezz_',num2str(POST_Substep)]);		
		FluidEle_LCS_VectorX_X = cell(num_Crack(POST_Substep));
		FluidEle_LCS_VectorX_Y = cell(num_Crack(POST_Substep));
		FluidEle_LCS_VectorX_Z = cell(num_Crack(POST_Substep));
		FluidEle_LCS_VectorY_X = cell(num_Crack(POST_Substep));
		FluidEle_LCS_VectorY_Y = cell(num_Crack(POST_Substep));
		FluidEle_LCS_VectorY_Z = cell(num_Crack(POST_Substep));	
		FluidEle_LCS_VectorZ_X = cell(num_Crack(POST_Substep));
		FluidEle_LCS_VectorZ_Y = cell(num_Crack(POST_Substep));
		FluidEle_LCS_VectorZ_Z = cell(num_Crack(POST_Substep));		
		for i=1:num_Crack(POST_Substep) 
			FluidEle_LCS_VectorX_X{i} = str2num(fgetl(file_FluidEle_LCS_VectorX_X));
			FluidEle_LCS_VectorX_Y{i} = str2num(fgetl(file_FluidEle_LCS_VectorX_Y));
			FluidEle_LCS_VectorX_Z{i} = str2num(fgetl(file_FluidEle_LCS_VectorX_Z));
			FluidEle_LCS_VectorY_X{i} = str2num(fgetl(file_FluidEle_LCS_VectorY_X));
			FluidEle_LCS_VectorY_Y{i} = str2num(fgetl(file_FluidEle_LCS_VectorY_Y));
			FluidEle_LCS_VectorY_Z{i} = str2num(fgetl(file_FluidEle_LCS_VectorY_Z));
			FluidEle_LCS_VectorZ_X{i} = str2num(fgetl(file_FluidEle_LCS_VectorZ_X));
			FluidEle_LCS_VectorZ_Y{i} = str2num(fgetl(file_FluidEle_LCS_VectorZ_Y));
			FluidEle_LCS_VectorZ_Z{i} = str2num(fgetl(file_FluidEle_LCS_VectorZ_Z));			
		end
		fclose(file_FluidEle_LCS_VectorX_X);
		fclose(file_FluidEle_LCS_VectorX_Y);
		fclose(file_FluidEle_LCS_VectorX_Z);	
		fclose(file_FluidEle_LCS_VectorY_X);
		fclose(file_FluidEle_LCS_VectorY_Y);
		fclose(file_FluidEle_LCS_VectorY_Z);	
		fclose(file_FluidEle_LCS_VectorZ_X);
		fclose(file_FluidEle_LCS_VectorZ_Y);
		fclose(file_FluidEle_LCS_VectorZ_Z);			
	else
	    FluidEle_LCS_VectorX_X=[];
		FluidEle_LCS_VectorX_Y=[];
		FluidEle_LCS_VectorX_Z=[];
	    FluidEle_LCS_VectorY_X=[];
		FluidEle_LCS_VectorY_Y=[];
		FluidEle_LCS_VectorY_Z=[];
	    FluidEle_LCS_VectorZ_X=[];
		FluidEle_LCS_VectorZ_Y=[];
		FluidEle_LCS_VectorZ_Z=[];		
	end
	%读取流体单元Gauss点的接触力,2020-01-22.
	if exist([Full_Pathname,'.cfrx_',num2str(POST_Substep)], 'file') ==2
		file_FluidEle_Contact_Force_X = fopen([Full_Pathname,'.cfrx_',num2str(POST_Substep)]);
		file_FluidEle_Contact_Force_Y = fopen([Full_Pathname,'.cfry_',num2str(POST_Substep)]);
		file_FluidEle_Contact_Force_Z = fopen([Full_Pathname,'.cfrz_',num2str(POST_Substep)]);		
		FluidEle_Contact_Force_X = cell(num_Crack(POST_Substep));
		FluidEle_Contact_Force_Y = cell(num_Crack(POST_Substep));
		FluidEle_Contact_Force_Z = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			FluidEle_Contact_Force_X{i} = str2num(fgetl(file_FluidEle_Contact_Force_X));
			FluidEle_Contact_Force_Y{i} = str2num(fgetl(file_FluidEle_Contact_Force_Y));
			FluidEle_Contact_Force_Z{i} = str2num(fgetl(file_FluidEle_Contact_Force_Z));		
		end
		fclose(file_FluidEle_Contact_Force_X);
		fclose(file_FluidEle_Contact_Force_Y);
		fclose(file_FluidEle_Contact_Force_Z);			
	else
	    FluidEle_Contact_Force_X=[];
		FluidEle_Contact_Force_Y=[];
		FluidEle_Contact_Force_Z=[];		
	end	
	%读取裂缝面计算点开度文件.
	if exist([Full_Pathname,'.cape_',num2str(POST_Substep)], 'file') ==2
		file_Crack3D_CalP_Aperture = fopen([Full_Pathname,'.cape_',num2str(POST_Substep)]);
		Crack3D_CalP_Aperture = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_CalP_Aperture{i} = str2num(fgetl(file_Crack3D_CalP_Aperture));
		end
		fclose(file_Crack3D_CalP_Aperture);
		%获取每个裂缝最大开度值
		for i=1:num_Crack(POST_Substep) 
		    Max_Aperture_of_each_Crack(i) = max(Crack3D_CalP_Aperture{i});
			Min_Aperture_of_each_Crack(i) = min(Crack3D_CalP_Aperture{i});					
		end
    else
    	Crack3D_CalP_Aperture=[];
	end
	%读取裂缝面计算点接触状态文件. 2023-09-23. NEWFTU-2023092301.
	if exist([Full_Pathname,'.csce_',num2str(POST_Substep)], 'file') ==2
		file_Crack3D_Contact_Status = fopen([Full_Pathname,'.csce_',num2str(POST_Substep)]);
		Crack3D_Contact_Status = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_Contact_Status{i} = str2num(fgetl(file_Crack3D_Contact_Status));
		end
		fclose(file_Crack3D_Contact_Status);
    else
    	Crack3D_Contact_Status=[];
	end
	% -------------------------------------------------
	%读取裂缝面计算点xx渗透率文件. 2022-11-26.
	if exist([Full_Pathname,'.ckxx_',num2str(POST_Substep)], 'file') ==2
		file_Crack3D_CalP_kxx = fopen([Full_Pathname,'.ckxx_',num2str(POST_Substep)]);
		Crack3D_CalP_kxx = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_CalP_kxx{i} = str2num(fgetl(file_Crack3D_CalP_kxx));
		end
		fclose(file_Crack3D_CalP_kxx);
		for i=1:num_Crack(POST_Substep) 
		    Max_kxx_of_each_Crack(i) = max(Crack3D_CalP_kxx{i});
			Min_kxx_of_each_Crack(i) = min(Crack3D_CalP_kxx{i});					
		end
    else
    	Crack3D_CalP_kxx=[];
	end

	%读取裂缝面计算点yy渗透率文件. 2022-11-26.
	if exist([Full_Pathname,'.ckyy_',num2str(POST_Substep)], 'file') ==2
		file_Crack3D_CalP_kyy = fopen([Full_Pathname,'.ckyy_',num2str(POST_Substep)]);
		Crack3D_CalP_kyy = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_CalP_kyy{i} = str2num(fgetl(file_Crack3D_CalP_kyy));
		end
		fclose(file_Crack3D_CalP_kyy);	
		for i=1:num_Crack(POST_Substep) 
		    Max_kyy_of_each_Crack(i) = max(Crack3D_CalP_kyy{i});
			Min_kyy_of_each_Crack(i) = min(Crack3D_CalP_kyy{i});					
		end
    else
    	Crack3D_CalP_kyy=[];
	end

	%读取裂缝面计算点zz渗透率文件. 2022-11-26.
	if exist([Full_Pathname,'.ckzz_',num2str(POST_Substep)], 'file') ==2
		file_Crack3D_CalP_kzz = fopen([Full_Pathname,'.ckzz_',num2str(POST_Substep)]);
		Crack3D_CalP_kzz = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_CalP_kzz{i} = str2num(fgetl(file_Crack3D_CalP_kzz));
		end
		fclose(file_Crack3D_CalP_kzz);
		for i=1:num_Crack(POST_Substep) 
		    Max_kzz_of_each_Crack(i) = max(Crack3D_CalP_kzz{i});
			Min_kzz_of_each_Crack(i) = min(Crack3D_CalP_kzz{i});					
		end
    else
    	Crack3D_CalP_kzz=[];
	end

	%读取裂缝面计算点xy渗透率文件. 2022-11-26.
	if exist([Full_Pathname,'.ckxy_',num2str(POST_Substep)], 'file') ==2
		file_Crack3D_CalP_kxy = fopen([Full_Pathname,'.ckxy_',num2str(POST_Substep)]);
		Crack3D_CalP_kxy = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_CalP_kxy{i} = str2num(fgetl(file_Crack3D_CalP_kxy));
		end
		fclose(file_Crack3D_CalP_kxy);
		for i=1:num_Crack(POST_Substep) 
		    Max_kxy_of_each_Crack(i) = max(Crack3D_CalP_kxy{i});
			Min_kxy_of_each_Crack(i) = min(Crack3D_CalP_kxy{i});					
		end
    else
    	Crack3D_CalP_kxy=[];
	end	

	%读取裂缝面计算点yz渗透率文件. 2022-11-26.
	if exist([Full_Pathname,'.ckyz_',num2str(POST_Substep)], 'file') ==2
		file_Crack3D_CalP_kyz = fopen([Full_Pathname,'.ckyz_',num2str(POST_Substep)]);
		Crack3D_CalP_kyz = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_CalP_kyz{i} = str2num(fgetl(file_Crack3D_CalP_kyz));
		end
		fclose(file_Crack3D_CalP_kyz);
		for i=1:num_Crack(POST_Substep) 
		    Max_kyz_of_each_Crack(i) = max(Crack3D_CalP_kyz{i});
			Min_kyz_of_each_Crack(i) = min(Crack3D_CalP_kyz{i});					
		end
    else
    	Crack3D_CalP_kyz=[];
	end

	%读取裂缝面计算点xz渗透率文件. 2022-11-26.
	if exist([Full_Pathname,'.ckxz_',num2str(POST_Substep)], 'file') ==2
		file_Crack3D_CalP_kxz = fopen([Full_Pathname,'.ckxz_',num2str(POST_Substep)]);
		Crack3D_CalP_kxz = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_CalP_kxz{i} = str2num(fgetl(file_Crack3D_CalP_kxz));
		end
		fclose(file_Crack3D_CalP_kxz);
		Max_kxz_of_each_Crack = 0.0;
		Min_kxz_of_each_Crack = 0.0;
		for i=1:num_Crack(POST_Substep) 
		    Max_kxz_of_each_Crack(i) = max(Crack3D_CalP_kxz{i});
			Min_kxz_of_each_Crack(i) = min(Crack3D_CalP_kxz{i});					
		end
    else
    	Crack3D_CalP_kxz=[];
	end
	% -------------------------------------------------
	%读取裂缝面计算点开度文件.
	if exist([Full_Pathname,'.capf_',num2str(POST_Substep)], 'file') ==2
		file_Crack3D_FluEl_Aperture = fopen([Full_Pathname,'.capf_',num2str(POST_Substep)]);
		Crack3D_FluEl_Aperture = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_FluEl_Aperture{i} = str2num(fgetl(file_Crack3D_FluEl_Aperture));
		end
		fclose(file_Crack3D_FluEl_Aperture);
    else
    	Crack3D_FluEl_Aperture=[];
	end
	
	%读取裂缝面离散节点开度文件.
	if exist([Full_Pathname,'.cmap_',num2str(POST_Substep)], 'file') ==2
		file_Crack3D_Node_Aperture = fopen([Full_Pathname,'.cmap_',num2str(POST_Substep)]);
		Crack3D_Node_Aperture = cell(num_Crack(POST_Substep));
		for i=1:num_Crack(POST_Substep) 
			Crack3D_Node_Aperture{i} = str2num(fgetl(file_Crack3D_Node_Aperture));
		end
		fclose(file_Crack3D_Node_Aperture);
    else
    	Crack3D_Node_Aperture=[];
	end	
else
    Crack_X = [];   Crack_Y = [];  Crack_Z = [];
	Enriched_Node_Type = [];
	Elem_Type = [];x_cr_tip_nodes=[];y_cr_tip_nodes=[];
	POS = []; Coors_Element_Crack= [];Coors_Vertex= [];
    Coors_Junction= []; Coors_Tip= [];
	Crack_Tip_Type= [];Node_Jun_elem=[];Node_Cross_elem=[];
	Crack_node_X=[];Crack_node_Y=[];Crack_node_Z=[];
	Crack_Ele_1 =[];Crack_Ele_2 =[];Crack_Ele_3 =[];
	Crack_node_local_X=[];Crack_node_local_Y=[];Crack_node_local_Z=[];
	Crack_Node_in_Ele =[];
	Crack3D_Vector_S1_X =[];Crack3D_Vector_S1_Y =[];Crack3D_Vector_S1_Z =[];
	Crack3D_CalP_X =[];Crack3D_CalP_Y=[];Crack3D_CalP_Z=[];
end

% Read enriched nodes of cracks if cracks exist.
if num_Crack(POST_Substep) ~= 0
	disp('    > Reading enriched nodes of cracks....') 
	if Key_Data_Format==1 
	    Post_Enriched_Nodes = load([Full_Pathname,'.ennd_',num2str(POST_Substep)]);
	elseif Key_Data_Format==2  %Binary
	    c_file = fopen([Full_Pathname,'.ennd_',num2str(POST_Substep)],'rb');
		[cc_Post_Enriched_Nodes,cc_count]   = fread(c_file,inf,'int'); 
		% [cc_Post_Enriched_Nodes,cc_count]   = fread(c_file,inf,'int8'); %适配Fortran Kind=1. IMPROV-2022091801.
		fclose(c_file);
		%转换成Matlab中的数据格式
		Post_Enriched_Nodes = (reshape(cc_Post_Enriched_Nodes,num_Crack(POST_Substep),Num_Node))';
	end	
else
	Post_Enriched_Nodes =[];
end

% Read crushed elements if Key_Crush=1.
if Key_Crush ==1
    crue_namefile = [Full_Pathname,'.crue_',num2str(POST_Substep)];
	% Check if "crue" file of the POST_Substep substep exist or not.
    if exist(crue_namefile,'file') ==2
        Crushed_element = load(crue_namefile);
	else
	    Crushed_element =[];
	end
else
    Crushed_element =[];
end

% Read nodal average stress file.
if Key_PLOT(3,1)~=0
    disp('    > Reading nodal average stress file....') 
	%读取节点应力.
	if Key_Data_Format==1 
		if exist([Full_Pathname,'.strn_',num2str(POST_Substep)], 'file') ==2
			Stress_Matrix = load([Full_Pathname,'.strn_',num2str(POST_Substep)]);
			%计算Mises应力. 2022-12-22.
			for i_Node=1:size(Stress_Matrix,1)
				stress_x = Stress_Matrix(i_Node,1);
				stress_y = Stress_Matrix(i_Node,2);
				stress_z = Stress_Matrix(i_Node,3);
				stress_xy = Stress_Matrix(i_Node,4);
				stress_yz = Stress_Matrix(i_Node,5);
				stress_xz = Stress_Matrix(i_Node,6);
				Stress_Matrix(i_Node,7) = sqrt(((stress_x-stress_y)^2 + (stress_y-stress_z)^2 +(stress_x-stress_z)^2 + 6.0*(stress_xy^2+stress_yz^2+stress_xz^2))/2.0);
				% ppp = Stress_Matrix(i_Node,7)
			end
		else
			Stress_Matrix=[];
		end

	elseif Key_Data_Format==2  %Binary
		% c_file = fopen([Full_Pathname,'.strn_',num2str(POST_Substep)],'rb');
		% [cc_Stress_Matrix,cc_count]   = fread(c_file,inf,'double');
		% fclose(c_file);
		%%%%转换成Matlab中的数据格式
		% for ccc_i=1:cc_count/4
			% Stress_Matrix(ccc_i,1) = ccc_i;
			% Stress_Matrix(ccc_i,2) = cc_Stress_Matrix(ccc_i*4-3);
			% Stress_Matrix(ccc_i,3) = cc_Stress_Matrix(ccc_i*4-2);
			% Stress_Matrix(ccc_i,4) = cc_Stress_Matrix(ccc_i*4-1);
			% Stress_Matrix(ccc_i,5) = cc_Stress_Matrix(ccc_i*4);
		% end
	end
end

% 读取*.wbpt文件. 2022-07-03. NEWFTU-2022070301.
if  exist([Full_Pathname,'.wbpt'], 'file') ==2 
	disp('    > Reading *.wbpt file....') 
	namefile= [Full_Pathname,'.wbpt'];
	data=fopen(namefile,'r'); 
	wbpt_Matrix = [];
	lineNum = 0;
	c_count = 0;
	while ~feof(data)
		lineNum = lineNum+1;
		TemData = fgetl(data);    
		if lineNum>=2   %第一行是文件标识行,不予读取
			c_count = c_count+1;                     %总的迭代步数
			c_num   = size(str2num(TemData),2); 	   
			wbpt_Matrix(c_count,1:5)  = str2num(TemData);
		end
	end
	fclose(data); 
% 如果不存在时间步文件.
else
    wbpt_Matrix = [];
end

% 读取*.avol文件. 2022-11-09. NEWFTU-2022110901.
if  exist([Full_Pathname,'.avol'], 'file') ==2 
	disp('    > Reading *.avol file....') 
	namefile= [Full_Pathname,'.avol'];
	data=fopen(namefile,'r'); 
	avol_Matrix = [];
	lineNum = 0;
	c_count = 0;
	while ~feof(data)
		lineNum = lineNum+1;
		TemData = fgetl(data);    
		if lineNum>=2   %第一行是文件标识行,不予读取
			c_count = c_count+1;                     %总的迭代步数
			c_num   = size(str2num(TemData),2); 	   
			avol_Matrix(c_count,1:3)  = str2num(TemData);
		end
	end
	fclose(data); 
% 如果不存在时间步文件.
else
	avol_Matrix = [];
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
	
	
% Get the total force matrix(fx ,fy ,fsum).
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
    FORCE_Matrix(i,4) = sqrt(FORCE_Matrix(i,1)^2+FORCE_Matrix(i,2)^2++FORCE_Matrix(i,3)^2);
end

% Plot mesh.
if Key_PLOT(1,1)==1
    Plot_Mesh3D(POST_Substep,Crack_X,Crack_Y,Crack_Z,Post_Enriched_Nodes,POS)
end

% Plot mesh slice.
if Key_PLOT(1,1)==2 || Key_PLOT(1,1)==3 || Key_PLOT(1,1)==4
    Plot_Mesh3D_Slice(POST_Substep,Crack_X,Crack_Y,Crack_Z,Post_Enriched_Nodes,POS)
end

% Plot deformation.
if Key_PLOT(2,1)==1
    Plot_Deformation3D(POST_Substep,Crack_X,Crack_Y,Crack_Z,Post_Enriched_Nodes,POS)
end

% Plot nodal slice stress.
if Key_PLOT(3,1)==2 || Key_PLOT(3,1)==3 || Key_PLOT(3,1)==4
    Plot_Node_Stress_3D_Slice(POST_Substep,Crack_X,Crack_Y,Crack_Z,Post_Enriched_Nodes,POS)
end

% Plot nodal stress contour or strain contour,2020-03-11.
if Key_PLOT(3,1)==1 || Key_PLOT(3,1)==11
    Plot_Node_Stress_3D(POST_Substep,Crack_X,Crack_Y,Crack_Z,Post_Enriched_Nodes,POS,Elem_Type)
end

% Plot nodal slice dispalcement.
if Key_PLOT(4,1)==2 || Key_PLOT(4,1)==3 || Key_PLOT(4,1)==4
    Plot_Node_Disp_3D_Slice(POST_Substep,Crack_X,Crack_Y,Crack_Z,Post_Enriched_Nodes,POS)
end

% Plot nodal displacement contour,2020-03-11.
if Key_PLOT(4,1)==1
    Plot_Node_Disp_3D(POST_Substep,Crack_X,Crack_Y,Crack_Z,Post_Enriched_Nodes,POS,Elem_Type)
end

% Plot crack contour,2020-03-12.
if Key_PLOT(5,1)~=0  & num_Crack(POST_Substep)>0
    Plot_Crack_Contour_3D(POST_Substep,Crack_X,Crack_Y,Crack_Z,Post_Enriched_Nodes,POS)
end

% Plot crack contour,2022-04-24.
if Key_PLOT(6,1)==1  
    Plot_3D_curves(POST_Substep)
end

% 绘制单元切片(渗透率等). 2022-11-28.
if Key_PLOT(7,1)>=1
    Plot_Element_3D_Slice(POST_Substep)
end

disp('    Plot completed.')
disp(' ')

clear DISP
clear Force_X_Matrix
clear Force_Y_Matrix
clear Boundary_X_Matrix
clear Boundary_Y_Matrix
clear Node_Jun_elem
clear POS
clear Crack_X
clear Crack_Y
clear Coors_Element_Crack
clear Coors_Vertex
clear Coors_Junction
clear Coors_Tip
clear Elem_Type