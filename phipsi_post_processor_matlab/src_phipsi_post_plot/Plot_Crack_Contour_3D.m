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

function Plot_Crack_Contour_3D(isub,Crack_X,Crack_Y,Crack_Z,Post_Enriched_Nodes,POS)
%Plot 3D crack contour.
%2020-03-12

global Node_Coor Elem_Node Key_POST_HF
global Num_Node Num_Elem
global Min_X_Coor Max_X_Coor Min_Y_Coor Max_Y_Coor Min_Z_Coor Max_Z_Coor
global Key_PLOT aveg_area_ele
global Size_Font Elem_Fontcolor Elem_Fontsize Node_Fontcolor Node_Fontsize
global num_Crack num_of_Material
global Color_Crack Width_Crack Full_Pathname
global Color_Backgro_Mesh_1 Color_Backgro_Mesh_2 Color_Backgro_Mesh_3 Color_Backgro_Mesh_4
global Color_Backgro_Mesh_5 Color_Backgro_Mesh_6 Color_Backgro_Mesh_7
global Color_Backgro_Mesh_8 Color_Backgro_Mesh_9 Color_Backgro_Mesh_10
global Elem_Material Num_Step_to_Plot DISP Num_Foc_z
global Num_Foc_x Num_Foc_y Foc_x Foc_y Num_Foc_z Foc_z FORCE_Matrix
global Key_Data_Format
global Crack_node_X Crack_node_Y Crack_node_Z
global Crack_Ele_1 Crack_Ele_2 Crack_Ele_3
global Model_Outline Model_OutArea
global Num_Bou_x Num_Bou_y Num_Bou_z Bou_x Bou_y Bou_z
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
global Full_Pathname
global Tip_Enriched_Ele_BaseLine Tip_Enriched_Ele_BaseLine_Vector_x 
global Tip_Enriched_Ele_BaseLine_Vector_y Tip_Enriched_Ele_BaseLine_Vector_z
global Crack3D_Node_Aperture 
global Key_Flipped_Gray Color_Contourlevel
global Title_Font Key_Figure_Control_Widget
global Crack3D_Fluid_Ele_Nodes Crack3D_CalP_Aperture Crack3D_Fluid_Ele_Num
global num_Wellbore num_Points_WB_1 num_Points_WB_2 num_Points_WB_3 num_Points_WB_4 num_Points_WB_5
global Wellbore_1 Wellbore_2 Wellbore_3 Wellbore_4 Wellbore_5 Frac_Stage_Points
global Key_Axis_NE
global Key_Plot_Elements Elements_to_be_Ploted
global Key_Plot_EleGauss EleGauss_to_be_Ploted
global Crack_to_Plot
global Max_kxx_of_each_Crack Min_kxx_of_each_Crack Crack3D_CalP_kxx
global Max_kyy_of_each_Crack Min_kyy_of_each_Crack Crack3D_CalP_kyy
global Max_kzz_of_each_Crack Min_kzz_of_each_Crack Crack3D_CalP_kzz
global Max_kxy_of_each_Crack Min_kxy_of_each_Crack Crack3D_CalP_kxy
global Max_kyz_of_each_Crack Min_kyz_of_each_Crack Crack3D_CalP_kyz
global Max_kxz_of_each_Crack Min_kxz_of_each_Crack Crack3D_CalP_kxz
global Max_Aperture_of_each_Crack Min_Aperture_of_each_Crack
global Ele_Permeability_3D
global Crack3D_NF_nfcx Crack3D_NF_nfcy Crack3D_NF_nfcz Num_NF_3D
global RESECH_CODE

% global Tri_BCD
disp(['      ----- Plotting crack contour......'])
xi_1 =[];yi_1 =[];zi_1 =[];
xi_2 =[];yi_2 =[];zi_2 =[];
xi_3 =[];yi_3 =[];zi_3 =[];
xi_4 =[];yi_4 =[];zi_4 =[];
xi_5 =[];yi_5 =[];zi_5 =[];
xi_6 =[];yi_6 =[];zi_6 =[];
xi_7 =[];yi_7 =[];zi_7 =[];
xi_8 =[];yi_8 =[];zi_8 =[];
xi_9 =[];yi_9 =[];zi_9 =[];
xi_10 =[];yi_10 =[];zi_10 =[];

scale = Key_PLOT(2,6);

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

c_X_Length = Max_X_Coor_New-Min_X_Coor_New;
c_Y_Length = Max_Y_Coor_New-Min_Y_Coor_New;
c_Z_Length = Max_Z_Coor_New-Min_Z_Coor_New;
	     
% New figure.
Tools_New_Figure
hold on;
axis off; axis equal;
delta = sqrt(aveg_area_ele);
axis([Min_X_Coor_New-delta Max_X_Coor_New+delta ...
      Min_Y_Coor_New-delta Max_Y_Coor_New+delta ...
	  Min_Z_Coor_New-delta Max_Z_Coor_New+delta]);
% Set Viewpoint	  
PhiPsi_Viewing_Angle_Settings

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

if Key_PLOT(5,9)==2  | Key_PLOT(5,9)==4  | Key_PLOT(5,9)==5%增强单元的网格
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
			% if sum(sum(Post_Enriched_Nodes(NN,1:size(Post_Enriched_Nodes,2))))==16   %仅绘制纯Heaviside增强单元
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




%-----------------------------
%Plot crack aperture contour.
%-----------------------------
if Key_PLOT(5,1)==1 
    title('Crack aperture contour','FontName',Title_Font,'FontSize',Size_Font)
	if Key_PLOT(5,2)==1 %results of fluid elements and nodes
		if isempty(Crack3D_CalP_Aperture)==0  && isempty(Crack3D_CalP_X)==0
			for i_Crack = 1:num_Crack(isub)  
                % i_Crack			
				nfluid_Ele = Crack3D_Fluid_Ele_Num{i_Crack};
				n_fl_nodes_per_elem = 3;   %Every fluid element has 3 fluid nodes.
				% Initialization of the required matrices
				X = zeros(n_fl_nodes_per_elem,nfluid_Ele);
				Y = zeros(n_fl_nodes_per_elem,nfluid_Ele);
				Z = zeros(n_fl_nodes_per_elem,nfluid_Ele);
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
				profile = [];
			end
		end
    elseif Key_PLOT(5,2)==2    %results of discrete crack surface
		if isempty(Crack_X)==0
			for i = 1:num_Crack(isub)    
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

%----------------------------------------------------
%裂缝面渗透率云图. 2022-11-26. NEWFTU-2022112601.
%----------------------------------------------------
if Key_PLOT(5,1)>=21 && Key_PLOT(5,1)<=29
	if Key_PLOT(5,2)==1 %results of fluid elements and nodes 
		if Key_PLOT(5,1)==21
			title('Crack kxx contour','FontName',Title_Font,'FontSize',Size_Font)			
		elseif Key_PLOT(5,1)==22
			title('Crack kyy contour','FontName',Title_Font,'FontSize',Size_Font)		
		elseif Key_PLOT(5,1)==23	
			title('Crack kzz contour','FontName',Title_Font,'FontSize',Size_Font)
		elseif Key_PLOT(5,1)==24
			title('Crack kxy contour','FontName',Title_Font,'FontSize',Size_Font)
		elseif Key_PLOT(5,1)==25	
			title('Crack kyz contour','FontName',Title_Font,'FontSize',Size_Font)
		elseif Key_PLOT(5,1)==26
			title('Crack kxz contour','FontName',Title_Font,'FontSize',Size_Font)
		end	
		if isempty(Crack3D_CalP_kxx)==0  && isempty(Crack3D_CalP_X)==0
			for i_Crack = 1:num_Crack(isub)  
                % i_Crack			
				nfluid_Ele = Crack3D_Fluid_Ele_Num{i_Crack};
				n_fl_nodes_per_elem = 3;   %Every fluid element has 3 fluid nodes.
				% Initialization of the required matrices
				X = zeros(n_fl_nodes_per_elem,nfluid_Ele);
				Y = zeros(n_fl_nodes_per_elem,nfluid_Ele);
				Z = zeros(n_fl_nodes_per_elem,nfluid_Ele);
				%nfluid_Ele
				for i_fluid_Ele=1:nfluid_Ele
					c_fluid_nodes = Crack3D_Fluid_Ele_Nodes(i_Crack,i_fluid_Ele,1:n_fl_nodes_per_elem);
					X(1:n_fl_nodes_per_elem,i_fluid_Ele) =Crack3D_CalP_X{i_Crack}(c_fluid_nodes);
					Y(1:n_fl_nodes_per_elem,i_fluid_Ele) =Crack3D_CalP_Y{i_Crack}(c_fluid_nodes);
					Z(1:n_fl_nodes_per_elem,i_fluid_Ele) =Crack3D_CalP_Z{i_Crack}(c_fluid_nodes);
					c_X = Crack3D_CalP_X{i_Crack}(c_fluid_nodes);
					c_Y = Crack3D_CalP_Y{i_Crack}(c_fluid_nodes);
					c_Z = Crack3D_CalP_Z{i_Crack}(c_fluid_nodes);
					% i_fluid_Ele
					if Key_PLOT(5,1)==21
						profile(1:n_fl_nodes_per_elem,i_fluid_Ele)= Crack3D_CalP_kxx{i_Crack}(c_fluid_nodes); % extract component value of the fluid node 				
					elseif Key_PLOT(5,1)==22
						profile(1:n_fl_nodes_per_elem,i_fluid_Ele)= Crack3D_CalP_kyy{i_Crack}(c_fluid_nodes); % extract component value of the fluid node 		
					elseif Key_PLOT(5,1)==23
						profile(1:n_fl_nodes_per_elem,i_fluid_Ele)= Crack3D_CalP_kzz{i_Crack}(c_fluid_nodes); % extract component value of the fluid node 	
					elseif Key_PLOT(5,1)==24
						profile(1:n_fl_nodes_per_elem,i_fluid_Ele)= Crack3D_CalP_kxy{i_Crack}(c_fluid_nodes); % extract component value of the fluid node 	
					elseif Key_PLOT(5,1)==25
						profile(1:n_fl_nodes_per_elem,i_fluid_Ele)= Crack3D_CalP_kyz{i_Crack}(c_fluid_nodes); % extract component value of the fluid node 	
					elseif Key_PLOT(5,1)==26
						profile(1:n_fl_nodes_per_elem,i_fluid_Ele)= Crack3D_CalP_kxz{i_Crack}(c_fluid_nodes); % extract component value of the fluid node 	
					end							
				end	
				if(Key_PLOT(5,4)==1)
					profile = profile*1.01325e15;%以mDarcy为单位
				end	
                %绘制裂缝面网格线				
				if Key_PLOT(5,3)==1
					patch(X,Y,Z,profile,'edgecolor','black','LineWidth',0.1)   
				%不绘制裂缝面网格线(2021-08-22)
				else
					patch(X,Y,Z,profile,'edgecolor','none','LineWidth',0.1)
				end
				profile = [];
			end
		end
    elseif Key_PLOT(5,2)==2    %results of discrete crack surface
        disp(['      裂缝面渗透率云图不支持离散裂缝面绘制！'])
	end
end	


%---------------------------------------
% 绘制离散裂缝面边界线.
%---------------------------------------
%读取离散裂缝面外边界节点
if Key_PLOT(5,3)==0
	if exist([Full_Pathname,'.cmso_',num2str(isub)], 'file') ==2 
		file_Crack3D_Meshed_Outline= fopen([Full_Pathname,'.cmso_',num2str(isub)]);
		Crack3D_Meshed_Outline = cell(num_Crack(isub));
		for i=1:num_Crack(isub) 
			Crack3D_Meshed_Outline{i} = str2num(fgetl(file_Crack3D_Meshed_Outline));
		end
		fclose(file_Crack3D_Meshed_Outline);
		
		for i = 1:num_Crack(isub)
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
end
		
%---------------------------------------
%Plot crack node and element numnber.
%---------------------------------------
% element
if Key_PLOT(5,5)>=2 
	if Key_PLOT(5,2)==1 %results of fluid elements and nodes
		if isempty(Crack3D_CalP_Aperture)==0  && isempty(Crack3D_CalP_X)==0
			for i_Crack = 1:num_Crack(isub)    
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
			for i = 1:num_Crack(isub)    
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
			for i_Crack = 1:num_Crack(isub)    
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
		    for i_Crack = 1:num_Crack(isub)    
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

%-----------------------------------------------
% 绘制井筒, Plot wellbore, NEWFTU-2022041901.
%-----------------------------------------------
if (RESECH_CODE == 2023022301)   %2024-02-23.
	Wellbore_1(1:2,1) = [0.25,0.25];
	Wellbore_1(1:2,2) = [0.25,0.25];
	Wellbore_1(1:2,3) = [0.499,0.25];
end
		
if num_Wellbore >=1 
    disp(['      ----- Plotting wellbore......'])
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
%绘制井筒分段点. NEWFTU-2022060701.
if isempty(Frac_Stage_Points) ==0
    % length_min = min(c_X_Length,min(c_Y_Length,c_Z_Length))/5.0; 
	%绘制透明圆球
	for i_Ball = 1:size(Frac_Stage_Points,1)
	    % size(Frac_Stage_Points,1)
		% r_ball = length_min/10;
		x_cor = Frac_Stage_Points(i_Ball,1);
		y_cor = Frac_Stage_Points(i_Ball,2);
		z_cor = Frac_Stage_Points(i_Ball,3);
		% [x_ball,y_ball,z_ball]=sphere(30);
		% surf(r_ball*x_ball +x_cor,r_ball*y_ball +y_cor,r_ball*z_ball +z_cor,'FaceColor',[218/255,112/255,214/255],'LineStyle','none','FaceAlpha',0.5); %淡紫色
		if RESECH_CODE ~= 2023022301 %2024-02-23.
		    plot3(x_cor,y_cor,z_cor,'.','Color',[218/255,112/255,214/255],'MarkerSize',30) %Junction增强节点
		end
	end
end

%--------------------------------------------  
%  绘制给定的单元及其节点号. 2022-07-31.
%--------------------------------------------
if Key_Plot_Elements ==1 %绘制给定的单元及其节点号
	mean_XN=[];mean_YN=[];mean_ZN=[];
	for iElem = 1:size(Elements_to_be_Ploted,2)
		c_Elem = Elements_to_be_Ploted(iElem);       %NEWFTU-2022050401.
		if  c_Elem <=Num_Elem
			NN = [Elem_Node(c_Elem,1) Elem_Node(c_Elem,2) ...
				  Elem_Node(c_Elem,3) Elem_Node(c_Elem,4) ...
				  Elem_Node(c_Elem,5) Elem_Node(c_Elem,6) ...
				  Elem_Node(c_Elem,7) Elem_Node(c_Elem,8)];                             % Nodes for current element
            XN = New_Node_Coor(NN,1);
            YN = New_Node_Coor(NN,2);
		    ZN = New_Node_Coor(NN,3);				  
			%节点编号
			for i=1:8	  
				ts = text(XN(i),YN(i),ZN(i),num2str(NN(i)),'Color','blue','FontSize',10,'FontName','Consolas','FontAngle','italic');
			end
			for i=1:3
				plot3([XN(i),XN(i+1)],[YN(i),YN(i+1)],[ZN(i),ZN(i+1)],'LineWidth',1.0,'Color','m')	
			end
			for i=5:7
				plot3([XN(i),XN(i+1)],[YN(i),YN(i+1)],[ZN(i),ZN(i+1)],'LineWidth',1.0,'Color','m')	
			end
			for i=1:4
				plot3([XN(i),XN(i+4)],[YN(i),YN(i+4)],[ZN(i),ZN(i+4)],'LineWidth',1.0,'Color','m')	
			end	
			plot3([XN(1),XN(4)],[YN(1),YN(4)],[ZN(1),ZN(4)],'LineWidth',1.0,'Color','m')		
			plot3([XN(5),XN(8)],[YN(5),YN(8)],[ZN(5),ZN(8)],'LineWidth',1.0,'Color','m')
        else
		    disp(['            Elememt ',num2str(c_Elem),' is illegal to be ploted!'])
            continue		
		end
		mean_XN(iElem) = mean(XN);
		mean_YN(iElem) = mean(YN);
		mean_ZN(iElem) = mean(ZN);			
	end
	% tem_string = 1:1:Num_Elem;	
    text(mean_XN,mean_YN,mean_ZN,string(Elements_to_be_Ploted(1:size(Elements_to_be_Ploted,2))),'FontName',Title_Font,'FontSize',10,'color','black')			
end

%--------------------------------------------------------------    
%   绘制某单元的Gauss点坐标. 2022-07-16. NEWFTU-2022071601.
%   仅适用于固定积分算法. Key_Integral_Sol  = 2 
%--------------------------------------------------------------  
if Key_Plot_EleGauss ==1
    if Key_PLOT(1,15) > Num_Elem
	    disp('      Caution :: Key_PLOT(1,15) > Num_Elem, error in Plot_Mesh3D.m!')
		% Error_Message
	end
	%检查*.elgn文件是否存在.
	if exist([Full_Pathname,'.elgn_',num2str(isub)], 'file') ==2 
	    if Key_Data_Format==1
		    Elements_Gauss_Num = load([Full_Pathname,'.elgn_',num2str(isub)]);
		elseif Key_Data_Format==2 %binary
			c_file = fopen([Full_Pathname,'.elgn_',num2str(isub)],'rb');
		   [Elements_Gauss_Num,cc_count]   = fread(c_file,inf,'int');
		    fclose(c_file);		    
		end
		for iElem = 1:size(EleGauss_to_be_Ploted,2)
			c_Elem = EleGauss_to_be_Ploted(iElem); 
			disp(['      ----- Plotting Gauss points of element ',num2str(c_Elem),'......'])
			%获得待绘制单元的Gauss积分点数目.
			num_Gauss_Points = Elements_Gauss_Num(c_Elem);
			%获得Gauss积分点的局部坐标.
			[c_kesi,c_yita,c_zeta,c_weight] = Cal_Gauss_Points_3D_8nodes(num_Gauss_Points);
			%获得当前单元的节点和坐标.
			NN = [Elem_Node(c_Elem,1) Elem_Node(c_Elem,2) Elem_Node(c_Elem,3) Elem_Node(c_Elem,4) ...
				  Elem_Node(c_Elem,5) Elem_Node(c_Elem,6) Elem_Node(c_Elem,7) Elem_Node(c_Elem,8)];                            
			XN = Node_Coor(NN,1);
			YN = Node_Coor(NN,2);
			ZN = Node_Coor(NN,3);		
			%计算Gauss积分点坐标.
			for i_Gauss = 1:num_Gauss_Points
				% [c_N] = Cal_N_3D(c_kesi(i_Gauss),c_yita(i_Gauss),c_zeta(i_Gauss));
				[x(i_Gauss),y(i_Gauss),z(i_Gauss)] = Cal_Coor_by_KesiYita_3D(c_kesi(i_Gauss),c_yita(i_Gauss),c_zeta(i_Gauss),XN,YN,ZN);
			end
			%绘制Gauss积分点坐标.
			plot3(x,y,z,'k.','MarkerSize',0.2)    % MarkerSize 表示点的大小,黑色点
		end
	else
	    disp('      Caution :: Key_Plot_EleGauss ==1, but no *.elgn file found! error in Plot_Mesh3D.m!')
		% Error_Message
	end
end


%--------------------------------------------------------------	  
%   绘制3D天然裂缝. NEWFTU-2023010901.
%--------------------------------------------------------------
if (Key_PLOT(5,12)==1 | Key_PLOT(5,12)==2)
	disp(['      ----- Plotting 3D NF......'])
	for i_NF=1:Num_NF_3D 
	    num_NF_Points = size(Crack3D_NF_nfcx{i_NF},2);
		%天然裂缝形心.
		% c_Center_x = sum(Crack3D_NF_nfcx{i_NF}(1:size(Crack3D_NF_nfcx{i_NF},2)))/size(Crack3D_NF_nfcx{i_NF},2);
		% c_Center_y = sum(Crack3D_NF_nfcy{i_NF}(1:size(Crack3D_NF_nfcx{i_NF},2)))/size(Crack3D_NF_nfcx{i_NF},2);
		% c_Center_z = sum(Crack3D_NF_nfcz{i_NF}(1:size(Crack3D_NF_nfcx{i_NF},2)))/size(Crack3D_NF_nfcx{i_NF},2);
		c_Center_x = sum(Crack3D_NF_nfcx{i_NF}(1:num_NF_Points))/num_NF_Points;
		c_Center_y = sum(Crack3D_NF_nfcy{i_NF}(1:num_NF_Points))/num_NF_Points;
		c_Center_z = sum(Crack3D_NF_nfcz{i_NF}(1:num_NF_Points))/num_NF_Points;		
		%绘制天然裂缝.
		for i_side =  1:num_NF_Points-1;
			plot3([Crack3D_NF_nfcx{i_NF}(i_side),Crack3D_NF_nfcx{i_NF}(i_side+1)], ...
				  [Crack3D_NF_nfcy{i_NF}(i_side),Crack3D_NF_nfcy{i_NF}(i_side+1)], ...
				  [Crack3D_NF_nfcz{i_NF}(i_side),Crack3D_NF_nfcz{i_NF}(i_side+1)],'LineWidth',0.1,'Color',[128/255, 138/255, 135/255])	%灰色
		end	
		plot3([Crack3D_NF_nfcx{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcx{i_NF}(1)], ...
			  [Crack3D_NF_nfcy{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcy{i_NF}(1)], ...
			  [Crack3D_NF_nfcz{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcz{i_NF}(1)],'LineWidth',0.1,'Color',[128/255, 138/255, 135/255])	%灰色
		
        % 填充天然裂缝面，用于SCI论文攥写. 2024-02-23.		
		if (RESECH_CODE == 2023022301)
			if i_NF==1
				c_nf_x(1:4) = [Crack3D_NF_nfcx{i_NF}(1:4)];
				c_nf_y(1:4) = [Crack3D_NF_nfcy{i_NF}(1:4)];
				c_nf_z(1:4) = [Crack3D_NF_nfcz{i_NF}(1:4)];					
				% patch(c_nf_x',c_nf_y',c_nf_z','blue','FaceAlpha',0.1,'FaceLighting','gouraud','LineWidth',0.2)	
				patch(c_nf_x',c_nf_y',c_nf_z',[220/255, 220/255, 220/255],'FaceAlpha',0.5,'FaceLighting','gouraud','LineWidth',0.2)	
				
			end
		end
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
if Key_PLOT(5,1)>=21 && Key_PLOT(5,1)<=29
    set(get(cbar,'title'),'string','m^2'); %NEWFTU-2022112601.
	if(Key_PLOT(5,4)==1)
		set(get(cbar,'title'),'string','mDarcy'); %NEWFTU-2022112601.
	end
end
% get the color limits
% clim = caxis
if Key_PLOT(5,1)==1
    clim(1)=min(Min_Aperture_of_each_Crack)*1000.0;
	clim(2)=max(Max_Aperture_of_each_Crack)*1000.0;
	% Min_Aperture_of_each_Crack*1000.0
	% Max_Aperture_of_each_Crack*1000.0
elseif Key_PLOT(5,1)==21
    clim(1)=min(Min_kxx_of_each_Crack);
	clim(2)=max(Max_kxx_of_each_Crack);
	if(Key_PLOT(5,4)==1)
		clim = clim*1.01325e15;	%以mdarcy为单位
	end		
elseif Key_PLOT(5,1)==22
    clim(1)=min(Min_kyy_of_each_Crack);
	clim(2)=max(Max_kyy_of_each_Crack);
	if(Key_PLOT(5,4)==1)
		clim = clim*1.01325e15;
	end		
elseif Key_PLOT(5,1)==23
    clim(1)=min(Min_kzz_of_each_Crack);
	clim(2)=max(Max_kzz_of_each_Crack); 
	if(Key_PLOT(5,4)==1)
		clim = clim*1.01325e15;
	end		
elseif Key_PLOT(5,1)==24
    clim(1)=min(Min_kxy_of_each_Crack);
	clim(2)=max(Max_kxy_of_each_Crack);
	if(Key_PLOT(5,4)==1)
		clim = clim*1.01325e15;
	end		
elseif Key_PLOT(5,1)==25
    clim(1)=min(Min_kyz_of_each_Crack);
	clim(2)=max(Max_kyz_of_each_Crack);
	if(Key_PLOT(5,4)==1)
		clim = clim*1.01325e15;
	end		
elseif Key_PLOT(5,1)==26
    clim(1)=min(Min_kxz_of_each_Crack);
	clim(2)=max(Max_kxz_of_each_Crack);
	if(Key_PLOT(5,4)==1)
		clim = clim*1.01325e15;
	end		
end
if(clim(1)==clim(2))
    clim(2) = clim(1) +1e-50;
end

ylim(cbar,[clim(1) clim(2)]);
numpts = 10 ;    % Number of points to be displayed on colorbar
kssv = linspace(clim(1),clim(2),numpts);
set(cbar,'YtickMode','manual','YTick',kssv); % Set the tickmode to manual
for i = 1:numpts
	imep = num2str(kssv(i),'%+3.2E');
	vasu(i) = {imep} ;
end
set(cbar,'YTickLabel',vasu(1:numpts),'FontName',Title_Font,'FontSize',Size_Font);


%------------------------------------------------------	
% Active Figure control widget (2021-08-01)
% Ref: https://ww2.mathworks.cn/matlabcentral/fileexchange/38019-figure-control-widget
% Press q to exit.
% Press r (or double-click) to reset to the initial.
%------------------------------------------------------	
if Key_Figure_Control_Widget==1
    fcw(gca);
end

%----------------------
% Save pictures.
%----------------------
if Key_PLOT(5,1)==1
    Save_Picture(c_figure,Full_Pathname,'ccon');
end
%NEWFTU-2022112601.
if Key_PLOT(5,1)==21
    Save_Picture(c_figure,Full_Pathname,'ckxx'); 
elseif Key_PLOT(5,1)==22
    Save_Picture(c_figure,Full_Pathname,'ckyy'); 
elseif Key_PLOT(5,1)==23
    Save_Picture(c_figure,Full_Pathname,'ckzz'); 
elseif Key_PLOT(5,1)==24
    Save_Picture(c_figure,Full_Pathname,'ckxy'); 
elseif Key_PLOT(5,1)==25
    Save_Picture(c_figure,Full_Pathname,'ckyz'); 
elseif Key_PLOT(5,1)==26
    Save_Picture(c_figure,Full_Pathname,'ckxz'); 	
end

