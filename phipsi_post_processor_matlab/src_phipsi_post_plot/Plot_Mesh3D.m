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

function Plot_Mesh3D(isub,Crack_X,Crack_Y,Crack_Z,Post_Enriched_Nodes,POS)
% This function plots the initial geometry,三维.

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
global Elem_Material Num_Step_to_Plot
global Crack_node_X Crack_node_Y Crack_node_Z
global Crack_Ele_1 Crack_Ele_2 Crack_Ele_3
global Model_Outline
global Crack_node_local_X Crack_node_local_Y Crack_node_local_Z
global Crack_Node_in_Ele
global Crack3D_CalP_X Crack3D_CalP_Y Crack3D_CalP_Z
global Crack3D_Vertex_Vector_X_X Crack3D_Vertex_Vector_X_Y Crack3D_Vertex_Vector_X_Z 
global Crack3D_Vertex_Vector_Y_X Crack3D_Vertex_Vector_Y_Y Crack3D_Vertex_Vector_Y_Z  
global Crack3D_Vertex_Vector_Z_X Crack3D_Vertex_Vector_Z_Y Crack3D_Vertex_Vector_Z_Z 	
global Crack3D_Meshed_Outline Crack3D_Fluid_Ele_Num
global Crack3D_Fluid_Ele_Nodes Crack3D_CalP_Aperture
global Cracks_FluNode_Vector_3D_X Cracks_FluNode_Vector_3D_Y Cracks_FluNode_Vector_3D_Z
global Max_Aperture_of_each_Crack Crack3D_FluEl_Aperture Min_Aperture_of_each_Crack
global Tip_Enriched_Ele_BaseLine Tip_Enriched_Ele_BaseLine_Vector_x 
global Tip_Enriched_Ele_BaseLine_Vector_y Tip_Enriched_Ele_BaseLine_Vector_z
global FluidEle_GaussNor_3D_X FluidEle_GaussNor_3D_Y FluidEle_GaussNor_3D_Z
global FluidEle_LCS_VectorX_X FluidEle_LCS_VectorX_Y FluidEle_LCS_VectorX_Z
global FluidEle_LCS_VectorY_X FluidEle_LCS_VectorY_Y FluidEle_LCS_VectorY_Z
global FluidEle_LCS_VectorZ_X FluidEle_LCS_VectorZ_Y FluidEle_LCS_VectorZ_Z
global FluidEle_Contact_Force_X FluidEle_Contact_Force_Y FluidEle_Contact_Force_Z
global Title_Font Key_Figure_Control_Widget
global G_X_NODES G_Y_NODES G_Z_NODES G_NN G_X_Min G_X_Max G_Y_Min G_Y_Max G_Z_Min G_Z_Max
global num_Wellbore num_Points_WB_1 num_Points_WB_2 num_Points_WB_3 num_Points_WB_4 num_Points_WB_5
global Wellbore_1 Wellbore_2 Wellbore_3 Wellbore_4 Wellbore_5 Frac_Stage_Points
global Elements_to_be_Ploted
global Key_Data_Format 
global Key_Axis_NE Key_Plot_Elements
global Key_Plot_EleGauss EleGauss_to_be_Ploted
global Crack_to_Plot
global Crack3D_NF_nfcx Crack3D_NF_nfcy Crack3D_NF_nfcz Num_NF_3D
global FaceAlpha_3D_ele_face
global Crack3D_Contact_Status

disp(['      ----- Plotting undeformed mesh......'])
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

c_X_Length = Max_X_Coor-Min_X_Coor;
c_Y_Length = Max_Y_Coor-Min_Y_Coor;
c_Z_Length = Max_Z_Coor-Min_Z_Coor;

%===================  
%   New figure
%===================  
Tools_New_Figure
hold on;
title('Finite Element Mesh','FontName',Title_Font,'FontSize',Size_Font)
axis off; axis equal;
delta = sqrt(aveg_area_ele);
axis([Min_X_Coor-delta Max_X_Coor+delta ...
      Min_Y_Coor-delta Max_Y_Coor+delta ...
	  Min_Z_Coor-delta Max_Z_Coor+delta]);
% Set Viewpoint	  
PhiPsi_Viewing_Angle_Settings

%===================  
%    绘制坐标轴
%===================  
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

%===================  	  
%   绘制单元网格
%===================  
Line_width =0.1;
if Key_PLOT(1,9) ==1  && Key_PLOT(1,3)~=1
    c_plot_count = 0;
	Ploted_Ele_lines =[0 0];
	to_be_plot_count = 0;
	to_be_plot_x = [];to_be_plot_y = [];to_be_plot_z = [];  %2021-08-02
    for iElem = 1:Num_Elem
	    % iElem
		NN = [Elem_Node(iElem,1) Elem_Node(iElem,2) Elem_Node(iElem,3) Elem_Node(iElem,4) ...
			  Elem_Node(iElem,5) Elem_Node(iElem,6) Elem_Node(iElem,7) Elem_Node(iElem,8)];      % Nodes for current element
	    % if iElem ==92
		    % NN
		% end
		for i=1:3
		    if not(ismember(sort([NN(i),NN(i+1)]),Ploted_Ele_lines,'rows')) 	
			    c_plot_count = c_plot_count + 1;
			    Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+1)]);
				to_be_plot_count = to_be_plot_count +1;
				to_be_plot_x(to_be_plot_count,1:2) = [Node_Coor(NN(i),1) Node_Coor(NN(i+1),1)];
				to_be_plot_y(to_be_plot_count,1:2) = [Node_Coor(NN(i),2) Node_Coor(NN(i+1),2)];
				to_be_plot_z(to_be_plot_count,1:2) = [Node_Coor(NN(i),3) Node_Coor(NN(i+1),3)];		
            end			
		end
		for i=5:7
		    %%%%%%检查该边线是否已经绘制
		    if not(ismember(sort([NN(i),NN(i+1)]),Ploted_Ele_lines,'rows')) 	  
			    c_plot_count = c_plot_count + 1;
			    Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+1)]);
				to_be_plot_count = to_be_plot_count +1;
				to_be_plot_x(to_be_plot_count,1:2) = [Node_Coor(NN(i),1) Node_Coor(NN(i+1),1)];
				to_be_plot_y(to_be_plot_count,1:2) = [Node_Coor(NN(i),2) Node_Coor(NN(i+1),2)];
				to_be_plot_z(to_be_plot_count,1:2) = [Node_Coor(NN(i),3) Node_Coor(NN(i+1),3)];		
				
            end					  
		end
		for i=1:4
		    %%%%%%%检查该边线是否已经绘制
		    if not(ismember(sort([NN(i),NN(i+4)]),Ploted_Ele_lines,'rows')) 		
			    c_plot_count = c_plot_count + 1;
			    Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+4)]);
				to_be_plot_count = to_be_plot_count +1;
				to_be_plot_x(to_be_plot_count,1:2) = [Node_Coor(NN(i),1) Node_Coor(NN(i+4),1)];
				to_be_plot_y(to_be_plot_count,1:2) = [Node_Coor(NN(i),2) Node_Coor(NN(i+4),2)];
				to_be_plot_z(to_be_plot_count,1:2) = [Node_Coor(NN(i),3) Node_Coor(NN(i+4),3)];						
            end				  
		end	
		%%%%%%%%%检查该边线是否已经绘制
		if not(ismember(sort([NN(1),NN(4)]),Ploted_Ele_lines,'rows')) 		
			c_plot_count = c_plot_count + 1;
			Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(1),NN(4)]);		
			to_be_plot_count = to_be_plot_count +1;
			to_be_plot_x(to_be_plot_count,1:2) = [Node_Coor(NN(1),1) Node_Coor(NN(4),1)];
			to_be_plot_y(to_be_plot_count,1:2) = [Node_Coor(NN(1),2) Node_Coor(NN(4),2)];
			to_be_plot_z(to_be_plot_count,1:2) = [Node_Coor(NN(1),3) Node_Coor(NN(4),3)];				
		end
		if not(ismember(sort([NN(5),NN(8)]),Ploted_Ele_lines,'rows')) 	
			c_plot_count = c_plot_count + 1;
			Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(5),NN(8)]);	
			to_be_plot_count = to_be_plot_count +1;
			to_be_plot_x(to_be_plot_count,1:2) = [Node_Coor(NN(5),1) Node_Coor(NN(8),1)];
			to_be_plot_y(to_be_plot_count,1:2) = [Node_Coor(NN(5),2) Node_Coor(NN(8),2)];
			to_be_plot_z(to_be_plot_count,1:2) = [Node_Coor(NN(5),3) Node_Coor(NN(8),3)];					
	    end
	end 	
	plot3(to_be_plot_x',to_be_plot_y',to_be_plot_z','LineWidth',Line_width,'Color',[.5 .5 .5])	%灰色		
	
elseif Key_PLOT(1,9) ==0 %仅绘制模型边框(Outlines)
    for i=1:size(Model_Outline,1)
			plot3([Node_Coor(Model_Outline(i,1),1),Node_Coor(Model_Outline(i,2),1)],...
				  [Node_Coor(Model_Outline(i,1),2),Node_Coor(Model_Outline(i,2),2)],...
				  [Node_Coor(Model_Outline(i,1),3),Node_Coor(Model_Outline(i,2),3)],'LineWidth',Line_width,'Color','black')    
	end	
end

%===============================  	  
%  绘制给定的单元及其节点号
%===============================
if Key_Plot_Elements ==1 %绘制给定的单元及其节点号
	mean_XN=[];mean_YN=[];mean_ZN=[];
	for iElem = 1:size(Elements_to_be_Ploted,2)
		c_Elem = Elements_to_be_Ploted(iElem);       %NEWFTU-2022050401.
		if  c_Elem <=Num_Elem
			NN = [Elem_Node(c_Elem,1) Elem_Node(c_Elem,2) ...
				  Elem_Node(c_Elem,3) Elem_Node(c_Elem,4) ...
				  Elem_Node(c_Elem,5) Elem_Node(c_Elem,6) ...
				  Elem_Node(c_Elem,7) Elem_Node(c_Elem,8)];                             % Nodes for current element
            XN = Node_Coor(NN,1);
            YN = Node_Coor(NN,2);
		    ZN = Node_Coor(NN,3);				  
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

%=======================================  
%   绘制单元面-不同材料号采用不同颜色.
%=======================================  
for i_Material = 1:num_of_Material %NEWFTU-2023012001.
    if i_Material==1
	    Color_3D_ele_face = [189/255,252/255,201/255];
	elseif i_Material==2
	    Color_3D_ele_face = [255/255,99/255,71/255]; %番茄红. 2023-01-20
	elseif i_Material==3
	    Color_3D_ele_face = [153/255,51/255,250/255]; %湖紫色. 2023-01-20
	elseif i_Material==4
	    Color_3D_ele_face = [0/255,201/255,87/255]; %翠绿色. 2023-01-20	
	else 
	    Color_3D_ele_face = [255/255,125/255,64/255]; %肉色. 2023-01-20				
	end
	if Key_PLOT(1,3) == 1
	  c_plot_count = 0;
	  Ploted_Ele_Face =[0, 0, 0, 0];
	  c_x_1=[];c_y_1=[];c_z_1=[];
	  c_x_2=[];c_y_2=[];c_z_2=[];
	  c_x_3=[];c_y_3=[];c_z_3=[];
	  c_x_4=[];c_y_4=[];c_z_4=[];
	  c_x_5=[];c_y_5=[];c_z_5=[];
	  c_x_6=[];c_y_6=[];c_z_6=[];
	  count_1 = 0;
	  count_2 = 0;
	  count_3 = 0;
	  count_4 = 0;
	  count_5 = 0;
	  count_6 = 0;
	  for iElem = 1:Num_Elem
	    %2023-01-20
		if Elem_Material(iElem) == i_Material 
		    %如果Key_PLOT(1,15)~=0，则仅绘制Key_PLOT(1,15)给定材料号的单元. 2023-01-23.
		    if ((Key_PLOT(1,15)~=0) &  Elem_Material(iElem)==Key_PLOT(1,15)~=0) | Key_PLOT(1,15)==0
				NN = [Elem_Node(iElem,1) Elem_Node(iElem,2) ...
					  Elem_Node(iElem,3) Elem_Node(iElem,4) ...
					  Elem_Node(iElem,5) Elem_Node(iElem,6) ...
					  Elem_Node(iElem,7) Elem_Node(iElem,8)];                             % Nodes for current element
				  %第1个面
				  if not(ismember(sort([NN(1),NN(2),NN(3),NN(4)]),Ploted_Ele_Face,'rows')) %检查该面是否已经绘制(防止重复绘制)
					c_plot_count = c_plot_count + 1;
					Ploted_Ele_Face(c_plot_count,1:4) = sort([NN(1),NN(2),NN(3),NN(4)]);	
					count_1 = count_1 +1;
					c_x_1(1:4,count_1) = [Node_Coor(NN(1),1),Node_Coor(NN(2),1),Node_Coor(NN(3),1),Node_Coor(NN(4),1)];
					c_y_1(1:4,count_1) = [Node_Coor(NN(1),2),Node_Coor(NN(2),2),Node_Coor(NN(3),2),Node_Coor(NN(4),2)];
					c_z_1(1:4,count_1) = [Node_Coor(NN(1),3),Node_Coor(NN(2),3),Node_Coor(NN(3),3),Node_Coor(NN(4),3)];		
				  end	  
				  %第2个面
				  if not(ismember(sort([NN(5),NN(6),NN(7),NN(8)]),Ploted_Ele_Face,'rows')) %检查该面是否已经绘制(防止重复绘制)
					c_plot_count = c_plot_count + 1;
					Ploted_Ele_Face(c_plot_count,1:4) = sort([NN(5),NN(6),NN(7),NN(8)]);	
					count_2 = count_2 +1;
					c_x_2(1:4,count_2) = [Node_Coor(NN(5),1),Node_Coor(NN(6),1),Node_Coor(NN(7),1),Node_Coor(NN(8),1)];
					c_y_2(1:4,count_2) = [Node_Coor(NN(5),2),Node_Coor(NN(6),2),Node_Coor(NN(7),2),Node_Coor(NN(8),2)];
					c_z_2(1:4,count_2) = [Node_Coor(NN(5),3),Node_Coor(NN(6),3),Node_Coor(NN(7),3),Node_Coor(NN(8),3)];			
				  end	
				  %第3个面
				  if not(ismember(sort([NN(1),NN(2),NN(6),NN(5)]),Ploted_Ele_Face,'rows')) %检查该面是否已经绘制(防止重复绘制)
					c_plot_count = c_plot_count + 1;
					Ploted_Ele_Face(c_plot_count,1:4) = sort([NN(1),NN(2),NN(6),NN(5)]);	
					count_3 = count_3 +1;
					c_x_3(1:4,count_3) = [Node_Coor(NN(1),1),Node_Coor(NN(2),1),Node_Coor(NN(6),1),Node_Coor(NN(5),1)];
					c_y_3(1:4,count_3) = [Node_Coor(NN(1),2),Node_Coor(NN(2),2),Node_Coor(NN(6),2),Node_Coor(NN(5),2)];
					c_z_3(1:4,count_3) = [Node_Coor(NN(1),3),Node_Coor(NN(2),3),Node_Coor(NN(6),3),Node_Coor(NN(5),3)];			
				  end	
				  %第4个面
				  if not(ismember(sort([NN(2),NN(3),NN(7),NN(6)]),Ploted_Ele_Face,'rows')) %检查该面是否已经绘制(防止重复绘制)
					c_plot_count = c_plot_count + 1;
					Ploted_Ele_Face(c_plot_count,1:4) = sort([NN(2),NN(3),NN(7),NN(6)]);	
					count_4 = count_4 +1;
					c_x_4(1:4,count_4) = [Node_Coor(NN(2),1),Node_Coor(NN(3),1),Node_Coor(NN(7),1),Node_Coor(NN(6),1)];
					c_y_4(1:4,count_4) = [Node_Coor(NN(2),2),Node_Coor(NN(3),2),Node_Coor(NN(7),2),Node_Coor(NN(6),2)];
					c_z_4(1:4,count_4) = [Node_Coor(NN(2),3),Node_Coor(NN(3),3),Node_Coor(NN(7),3),Node_Coor(NN(6),3)];			
				  end
				  %第5个面
				  if not(ismember(sort([NN(7),NN(8),NN(4),NN(3)]),Ploted_Ele_Face,'rows')) %检查该面是否已经绘制(防止重复绘制)
					c_plot_count = c_plot_count + 1;
					Ploted_Ele_Face(c_plot_count,1:4) = sort([NN(7),NN(8),NN(4),NN(3)]);	
					count_5 = count_5 +1;
					c_x_5(1:4,count_5) = [Node_Coor(NN(7),1),Node_Coor(NN(8),1),Node_Coor(NN(4),1),Node_Coor(NN(3),1)];
					c_y_5(1:4,count_5) = [Node_Coor(NN(7),2),Node_Coor(NN(8),2),Node_Coor(NN(4),2),Node_Coor(NN(3),2)];
					c_z_5(1:4,count_5) = [Node_Coor(NN(7),3),Node_Coor(NN(8),3),Node_Coor(NN(4),3),Node_Coor(NN(3),3)];			
				  end
				  %第6个面
				  if not(ismember(sort([NN(5),NN(1),NN(4),NN(8)]),Ploted_Ele_Face,'rows')) %检查该面是否已经绘制(防止重复绘制)
					c_plot_count = c_plot_count + 1;
					Ploted_Ele_Face(c_plot_count,1:4) = sort([NN(5),NN(1),NN(4),NN(8)]);	
					count_6 = count_6 +1;
					c_x_6(1:4,count_6) = [Node_Coor(NN(5),1),Node_Coor(NN(1),1),Node_Coor(NN(4),1),Node_Coor(NN(8),1)];
					c_y_6(1:4,count_6) = [Node_Coor(NN(5),2),Node_Coor(NN(1),2),Node_Coor(NN(4),2),Node_Coor(NN(8),2)];
					c_z_6(1:4,count_6) = [Node_Coor(NN(5),3),Node_Coor(NN(1),3),Node_Coor(NN(4),3),Node_Coor(NN(8),3)];		
				  end
				end
			end
	  end 
	  if count_1>0 
	      patch(c_x_1(1:4,1:count_1),c_y_1(1:4,1:count_1),c_z_1(1:4,1:count_1),Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)    %2021-08-02
	  end
	  if count_2>0 
	      patch(c_x_2(1:4,1:count_2),c_y_2(1:4,1:count_2),c_z_2(1:4,1:count_2),Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
	  end
	  if count_3>0 
		patch(c_x_3(1:4,1:count_3),c_y_3(1:4,1:count_3),c_z_3(1:4,1:count_3),Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
	  end
	  if count_4>0 
		patch(c_x_4(1:4,1:count_4),c_y_4(1:4,1:count_4),c_z_4(1:4,1:count_4),Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
	  end
	  if count_5>0 
		patch(c_x_5(1:4,1:count_5),c_y_5(1:4,1:count_5),c_z_5(1:4,1:count_5),Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
	  end
	  if count_6>0 
		patch(c_x_6(1:4,1:count_6),c_y_6(1:4,1:count_6),c_z_6(1:4,1:count_6),Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)  
      end	  
	end
end

%===========================  
%  绘制裂缝面及其他附属量
%===========================  
if Key_PLOT(1,5) >= 1 || (Key_PLOT(1,5) == 0  && (Key_PLOT(1,6) + Key_PLOT(1,7))>0)
    disp(['      ----- Plotting crack surface...'])
	if isempty(Crack_X)==0
		for i = 1:num_Crack(isub)
		    %仅绘制给定的裂缝号. 2022-09-28. IMPROV-2022092801.
		    if Crack_to_Plot >=1 
			    if i~= Crack_to_Plot
				    continue
				end
			end
		% for i = 2:2
			if i==1
				c_clor = 'green';
			elseif i==2
				c_clor = 'red';
			elseif i==3
				c_clor = 'blue';
			elseif i==4	
				c_clor = 'cyan';
			elseif i==5	
				c_clor = 'magenta';
			elseif i==6	
				c_clor = 'yellow';
			end
			nPt = size(Crack_X{i},2);
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
			%ooooooooooooooooooooooooooo
			%    绘制裂缝面离散点
			%ooooooooooooooooooooooooooo
			if Key_PLOT(1,5) >= 2
				nnode = size(Crack_node_X{i},2);
				c_node_x = [];c_node_y = [];c_node_z = [];
				for j=1:nnode
					c_node_x(j) = [Crack_node_X{i}(j)];
					c_node_y(j) = [Crack_node_Y{i}(j)];
					c_node_z(j) = [Crack_node_Z{i}(j)];
				end
				plot3(c_node_x,c_node_y,c_node_z,'c.','MarkerSize',16.0)    % MarkerSize 表示点的大小,黑色点
				%裂缝面离散点编号.
				if Key_PLOT(1,5)== 3 
				    tem_string = 1:1:nnode;
					ts = text(c_node_x,c_node_y,c_node_z,string(tem_string),'Color','black','FontSize',12,'FontName','Consolas','FontAngle','italic');
				end		
			end
			%ooooooooooooooooooooooooooo
			%        绘制单元面
			%ooooooooooooooooooooooooooo
			if Key_PLOT(1,5) >= 1
				nele = size(Crack_Ele_1{i},2);
				c_x =[];c_y =[];c_z =[]; c_ele_center_x=[];c_ele_center_y=[];c_ele_center_z=[];
				for j=1:nele
					c_x(j,1:3) = [Crack_node_X{i}(Crack_Ele_1{i}(j)),Crack_node_X{i}(Crack_Ele_2{i}(j)),Crack_node_X{i}(Crack_Ele_3{i}(j))];
					c_y(j,1:3) = [Crack_node_Y{i}(Crack_Ele_1{i}(j)),Crack_node_Y{i}(Crack_Ele_2{i}(j)),Crack_node_Y{i}(Crack_Ele_3{i}(j))];
					c_z(j,1:3) = [Crack_node_Z{i}(Crack_Ele_1{i}(j)),Crack_node_Z{i}(Crack_Ele_2{i}(j)),Crack_node_Z{i}(Crack_Ele_3{i}(j))];	
                    c_ele_center_x(j) =	sum(c_x(j,1:3))/3.0;	
                    c_ele_center_y(j) =	sum(c_y(j,1:3))/3.0;	
                    c_ele_center_z(j) =	sum(c_z(j,1:3))/3.0;	
	
                    % if i==1 && j== 76
                        % patch(c_x(j,1:3),c_y(j,1:3),c_z(j,1:3),[1,0,0],'FaceAlpha',0.5,'FaceLighting','gouraud','LineWidth',0.2)	%橘黄色,不透明,黄色边线						
                    % elseif i==2 && j== 26
                        % patch(c_x(j,1:3),c_y(j,1:3),c_z(j,1:3),[1,0,0],'FaceAlpha',0.5,'FaceLighting','gouraud','LineWidth',0.2)	%橘黄色,不透明,黄色边线		
                    % else
					    % patch(c_x(j,1:3),c_y(j,1:3),c_z(j,1:3),[1,1,0],'FaceAlpha',0.5,'FaceLighting','gouraud','LineWidth',0.2)	%橘黄色,不透明,黄色边线		
                    % end							
				end		
				if Key_PLOT(1,5) ~= 4 
				    %patch(c_x',c_y',c_z',[1,1,0],'FaceAlpha',0.5,'FaceLighting','gouraud','LineWidth',0.2)			        %橘黄色,不透明,黄色边线	
					
					%NEWFTU-2022053001.  不同裂缝面不同颜色(颜色随机).
                    patch(c_x',c_y',c_z',[rand,rand,rand],'FaceAlpha',0.5,'FaceLighting','gouraud','LineWidth',0.2)										
                elseif Key_PLOT(1,5) == 4
				    plot3(c_x',c_y',c_z','black','LineWidth',1) 
				end
				%裂缝面离散单元编号. 
				if Key_PLOT(1,5)==5
				    tem_string = 1:1:nele;
				    ts = text(c_ele_center_x,c_ele_center_y,c_ele_center_z,string(tem_string),'Color','black','FontSize',12,'FontName','Consolas','FontAngle','italic');
				end
                % patch(c_x',c_y',c_z',[1,1,0],'FaceAlpha',0.5,'FaceLighting','gouraud','LineStyle','none')			    %橘黄色,不透明,黄色边线							
                % patch(c_x',c_y',c_z',[1,1,0])				
			end
			
			%ooooooooooooooooooooooooooooooooooooooooooooo
			%    绘制裂缝面编号，NEWFTU-2022050301.
			%ooooooooooooooooooooooooooo000000000000000000
		    %若裂缝数目大于两个就绘制. 在第一个离散单元或流体单元的第一个节点处绘制.
            if num_Crack(isub) >=2   & Key_PLOT(1,14)==1
			    crack_num_string = "Crack "+string(i);
				c_crack_x = Crack_node_X{i}(Crack_Ele_1{i}(1));
				c_crack_y = Crack_node_Y{i}(Crack_Ele_1{i}(1));
				c_crack_z = Crack_node_Z{i}(Crack_Ele_1{i}(1));
			    ts = text(c_crack_x,c_crack_y,c_crack_z,crack_num_string,'Color','black','FontSize',12,'FontName','Consolas','FontAngle','italic');
            end			
			
			
			%ooooooooooooooooooooooooooooooooooooooo
			% 流体单元高斯点外法线向量,2020-01-22
			%ooooooooooooooooooooooooooooooooooooooo
			if Key_PLOT(1,7) == 21
			    nfluid_Ele = Crack3D_Fluid_Ele_Num{i};
				for j=1:nfluid_Ele
					c_num_fluid_nodes = 3;
					c_fluid_nodes = Crack3D_Fluid_Ele_Nodes(i,j,1:c_num_fluid_nodes);
					c_x =Crack3D_CalP_X{i}(c_fluid_nodes);
					c_y =Crack3D_CalP_Y{i}(c_fluid_nodes);
					c_z =Crack3D_CalP_Z{i}(c_fluid_nodes);
					flu_ele_ave_x = sum(c_x)/c_num_fluid_nodes;
					flu_ele_ave_y = sum(c_y)/c_num_fluid_nodes;
					flu_ele_ave_z = sum(c_z)/c_num_fluid_nodes;
					%绘制流体单元Gauss点
					plot3(flu_ele_ave_x,flu_ele_ave_y,flu_ele_ave_z,'black.','MarkerSize',8.0)    % MarkerSize 表示点的大小,黑色点	
					%获得法向量
					c_FlEl_Nor_x = FluidEle_GaussNor_3D_X{i}(j);
					c_FlEl_Nor_y = FluidEle_GaussNor_3D_Y{i}(j);
					c_FlEl_Nor_z = FluidEle_GaussNor_3D_Z{i}(j);
					c_Length = (c_X_Length+c_Y_Length+c_Z_Length)/50;  %法向量的长度
					c_delta_x = c_Length*c_FlEl_Nor_x;
					c_delta_y = c_Length*c_FlEl_Nor_y;
					c_delta_z = c_Length*c_FlEl_Nor_z;
					h = Tools_mArrow3([flu_ele_ave_x flu_ele_ave_y flu_ele_ave_z], ...
					                  [flu_ele_ave_x+c_delta_x flu_ele_ave_y+c_delta_y flu_ele_ave_z+c_delta_z],...
									  'color','blue','stemWidth',c_Length/25.0,'tipWidth',c_Length/10.0,'facealpha',1.0);					
				end					
			end		
			%oooooooooooooooooooooooooooooooooooooooo	
			% 流体单元高斯点局部坐标系,2020-01-22
			%oooooooooooooooooooooooooooooooooooooooo
			if Key_PLOT(1,7) == 22
			    nfluid_Ele = Crack3D_Fluid_Ele_Num{i};
				for j=1:nfluid_Ele
					c_num_fluid_nodes = 3;
					c_fluid_nodes = Crack3D_Fluid_Ele_Nodes(i,j,1:c_num_fluid_nodes);
					c_x =Crack3D_CalP_X{i}(c_fluid_nodes);
					c_y =Crack3D_CalP_Y{i}(c_fluid_nodes);
					c_z =Crack3D_CalP_Z{i}(c_fluid_nodes);
					flu_ele_ave_x = sum(c_x)/c_num_fluid_nodes;
					flu_ele_ave_y = sum(c_y)/c_num_fluid_nodes;
					flu_ele_ave_z = sum(c_z)/c_num_fluid_nodes;
					%绘制流体单元Gauss点
					plot3(flu_ele_ave_x,flu_ele_ave_y,flu_ele_ave_z,'black.','MarkerSize',8.0)    % MarkerSize 表示点的大小,黑色点	
					%坐标系的长度
					c_Length = (c_X_Length+c_Y_Length+c_Z_Length)/60;  
					%局部坐标系X轴
					c_FlEl_LCS_X_X = FluidEle_LCS_VectorX_X{i}(j);
					c_FlEl_LCS_X_Y = FluidEle_LCS_VectorX_Y{i}(j);
					c_FlEl_LCS_X_Z = FluidEle_LCS_VectorX_Z{i}(j);
					c_delta_x = c_Length*c_FlEl_LCS_X_X;
					c_delta_y = c_Length*c_FlEl_LCS_X_Y;
					c_delta_z = c_Length*c_FlEl_LCS_X_Z;
					h = Tools_mArrow3([flu_ele_ave_x flu_ele_ave_y flu_ele_ave_z], ...
					                  [flu_ele_ave_x+c_delta_x flu_ele_ave_y+c_delta_y flu_ele_ave_z+c_delta_z],...
									  'color','red','stemWidth',c_Length/25.0,'tipWidth',c_Length/10.0,'facealpha',1.0);		
					%局部坐标系Y轴
					c_FlEl_LCS_Y_X = FluidEle_LCS_VectorY_X{i}(j);
					c_FlEl_LCS_Y_Y = FluidEle_LCS_VectorY_Y{i}(j);
					c_FlEl_LCS_Y_Z = FluidEle_LCS_VectorY_Z{i}(j);
					c_delta_x = c_Length*c_FlEl_LCS_Y_X;
					c_delta_y = c_Length*c_FlEl_LCS_Y_Y;
					c_delta_z = c_Length*c_FlEl_LCS_Y_Z;
					h = Tools_mArrow3([flu_ele_ave_x flu_ele_ave_y flu_ele_ave_z], ...
					                  [flu_ele_ave_x+c_delta_x flu_ele_ave_y+c_delta_y flu_ele_ave_z+c_delta_z],...
									  'color','green','stemWidth',c_Length/25.0,'tipWidth',c_Length/10.0,'facealpha',1.0);	
					%局部坐标系Z轴
					c_FlEl_LCS_Z_X = FluidEle_LCS_VectorZ_X{i}(j);
					c_FlEl_LCS_Z_Y = FluidEle_LCS_VectorZ_Y{i}(j);
					c_FlEl_LCS_Z_Z = FluidEle_LCS_VectorZ_Z{i}(j);
					c_delta_x = c_Length*c_FlEl_LCS_Z_X;
					c_delta_y = c_Length*c_FlEl_LCS_Z_Y;
					c_delta_z = c_Length*c_FlEl_LCS_Z_Z;
					h = Tools_mArrow3([flu_ele_ave_x flu_ele_ave_y flu_ele_ave_z], ...
					                  [flu_ele_ave_x+c_delta_x flu_ele_ave_y+c_delta_y flu_ele_ave_z+c_delta_z],...
									  'color','blue','stemWidth',c_Length/25.0,'tipWidth',c_Length/10.0,'facealpha',1.0);									  
				end					
			end		
			
			%oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo	
			% 流体单元(接触单元)接触状态,2023-09-23. NEWFTU-2023092301.
			%oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
			if Key_PLOT(1,7) == 26
			    if isempty(Crack3D_CalP_X)==0 && isempty(Crack3D_Contact_Status)==0
					nfluid_Ele = Crack3D_Fluid_Ele_Num{i};
					max_Force_X = max(abs(FluidEle_Contact_Force_X{i}));
					max_Force_Y = max(abs(FluidEle_Contact_Force_Y{i}));
					max_Force_Z = max(abs(FluidEle_Contact_Force_Z{i}));
					max_Force = sqrt(max_Force_X^2 + max_Force_Y^2 + max_Force_Z^2);
					Sticking_count = 0;
					Sliding_count  = 0;
					for j=1:nfluid_Ele
						c_num_fluid_nodes = 3;
						c_fluid_nodes = Crack3D_Fluid_Ele_Nodes(i,j,1:c_num_fluid_nodes);
						c_Contact_status = Crack3D_Contact_Status{i}(j);
						if(c_Contact_status==1) 
						    Sticking_count = Sticking_count+ 1;
							Sticking_c_x(Sticking_count,1:3) =Crack3D_CalP_X{i}(c_fluid_nodes);
							Sticking_c_y(Sticking_count,1:3) =Crack3D_CalP_Y{i}(c_fluid_nodes);
							Sticking_c_z(Sticking_count,1:3) =Crack3D_CalP_Z{i}(c_fluid_nodes);
						elseif(c_Contact_status==2)
						    Sliding_count = Sliding_count + 1;
							Sliding_c_x(Sliding_count,1:3) =Crack3D_CalP_X{i}(c_fluid_nodes);
							Sliding_c_y(Sliding_count,1:3) =Crack3D_CalP_Y{i}(c_fluid_nodes);
							Sliding_c_z(Sliding_count,1:3) =Crack3D_CalP_Z{i}(c_fluid_nodes);
			            end
						% 红色表示粘结单元.
						if (Sticking_count>0)
							patch(Sticking_c_x',Sticking_c_y',Sticking_c_z','red','FaceAlpha',0.5,'FaceLighting','gouraud','LineWidth',0.2)		
						end
						% 绿色表示滑移单元.
						if (Sliding_count>0)
							patch(Sliding_c_x',Sliding_c_y',Sliding_c_z','green','FaceAlpha',0.5,'FaceLighting','gouraud','LineWidth',0.2)	
						end
					end	
                end				
			end	

			%oooooooooooooooooooooooooooooooooooooooooooo	
			% 流体单元(接触单元)高斯点接触力,2020-01-22
			%oooooooooooooooooooooooooooooooooooooooooooo
			if Key_PLOT(1,7) == 25
			    if isempty(Crack3D_CalP_X)==0 && isempty(FluidEle_Contact_Force_X)==0
					nfluid_Ele = Crack3D_Fluid_Ele_Num{i};
					max_Force_X = max(abs(FluidEle_Contact_Force_X{i}));
					max_Force_Y = max(abs(FluidEle_Contact_Force_Y{i}));
					max_Force_Z = max(abs(FluidEle_Contact_Force_Z{i}));
					max_Force = sqrt(max_Force_X^2 + max_Force_Y^2 + max_Force_Z^2);
					for j=1:nfluid_Ele
						c_num_fluid_nodes = 3;
						c_fluid_nodes = Crack3D_Fluid_Ele_Nodes(i,j,1:c_num_fluid_nodes);
						c_x =Crack3D_CalP_X{i}(c_fluid_nodes);
						c_y =Crack3D_CalP_Y{i}(c_fluid_nodes);
						c_z =Crack3D_CalP_Z{i}(c_fluid_nodes);
						flu_ele_ave_x = sum(c_x)/c_num_fluid_nodes;
						flu_ele_ave_y = sum(c_y)/c_num_fluid_nodes;
						flu_ele_ave_z = sum(c_z)/c_num_fluid_nodes;
						%绘制流体单元Gauss点
						plot3(flu_ele_ave_x,flu_ele_ave_y,flu_ele_ave_z,'black.','MarkerSize',8.0)    % MarkerSize 表示点的大小,黑色点	
						%坐标系的长度
						c_Length = (c_X_Length+c_Y_Length+c_Z_Length)/35;  
						c_Contact_Force_X = FluidEle_Contact_Force_X{i}(j);
						c_Contact_Force_Y = FluidEle_Contact_Force_Y{i}(j);
						c_Contact_Force_Z = FluidEle_Contact_Force_Z{i}(j);
						c_delta_x = c_Length*c_Contact_Force_X/max_Force;
						c_delta_y = c_Length*c_Contact_Force_Y/max_Force;
						c_delta_z = c_Length*c_Contact_Force_Z/max_Force;
						h = Tools_mArrow3([flu_ele_ave_x+c_delta_x flu_ele_ave_y+c_delta_y flu_ele_ave_z+c_delta_z], ...
										  [flu_ele_ave_x flu_ele_ave_y flu_ele_ave_z],...
										  'color','red','stemWidth',c_Length/55.0,'tipWidth',c_Length/25.0,'facealpha',1.0);						
					end	
                end				
			end	
			
			%oooooooooooooooooooooooooooooooooooooooo					
			% 绘制流体单元计算点开度(矢量表示)
			%oooooooooooooooooooooooooooooooooooooooo
			if Key_PLOT(1,7) == 4 
			    if isempty(Crack3D_CalP_Aperture)==0 && isempty(Cracks_FluNode_Vector_3D_X)==0 && isempty(Crack3D_CalP_X)==0
				    max_length = (c_X_Length+c_Y_Length+c_Z_Length)/30;
					Max_Aperture =  max(abs(Max_Aperture_of_each_Crack));
					nCalP = size(Crack3D_CalP_X{i},2);
					for j=1:nCalP
						c_CalP_x = Crack3D_CalP_X{i}(j);
						c_CalP_y = Crack3D_CalP_Y{i}(j);
						c_CalP_z = Crack3D_CalP_Z{i}(j);
						c_CalP_V_x = Cracks_FluNode_Vector_3D_X{i}(j);
						c_CalP_V_y = Cracks_FluNode_Vector_3D_Y{i}(j);
						c_CalP_V_z = Cracks_FluNode_Vector_3D_Z{i}(j);
						c_Calp_Apeture = Crack3D_CalP_Aperture{i}(j);
						c_Length = c_Calp_Apeture/Max_Aperture*max_length;
						c_delta_x = c_Length*c_CalP_V_x;
						c_delta_y = c_Length*c_CalP_V_y;
						c_delta_z = c_Length*c_CalP_V_z;
						% plot3(c_CalP_x,c_CalP_y,c_CalP_z,'g.','MarkerSize',12.0)    % MarkerSize 表示点的大小,黑色点
						% ts = text(c_CalP_x,c_CalP_y,c_CalP_z,num2str(j),'Color','black','FontSize',12,'FontName','Consolas','FontAngle','italic');
						if c_Calp_Apeture >=0 
						    %张开型裂缝箭头朝外
						    %张开型裂缝用黑色
						    h = Tools_mArrow3([c_CalP_x c_CalP_y c_CalP_z],[c_CalP_x+c_delta_x c_CalP_y+c_delta_y c_CalP_z+c_delta_z],...
							'color','black','stemWidth',c_Length/25.0,'tipWidth',c_Length/10.0,'facealpha',1.0);
						    h = Tools_mArrow3([c_CalP_x c_CalP_y c_CalP_z],[c_CalP_x-c_delta_x c_CalP_y-c_delta_y c_CalP_z-c_delta_z],...
							'color','black','stemWidth',c_Length/25.0,'tipWidth',c_Length/10.0,'facealpha',1.0);
						else
						    %闭合型裂缝箭头朝内(指向裂缝面)
						    h = Tools_mArrow3([c_CalP_x+c_delta_x c_CalP_y+c_delta_y c_CalP_z+c_delta_z],[c_CalP_x c_CalP_y c_CalP_z],...
							'color','black','stemWidth',c_Length/25.0,'tipWidth',c_Length/10.0,'facealpha',1.0);
						    h = Tools_mArrow3([c_CalP_x-c_delta_x c_CalP_y-c_delta_y c_CalP_z-c_delta_z],[c_CalP_x c_CalP_y c_CalP_z],...
							'color','black','stemWidth',c_Length/25.0,'tipWidth',c_Length/10.0,'facealpha',1.0);
                        end							
						
					end
				end
			end			
            %oooooooooooooooooooooooooooooooooooooooo
			% 绘制流体单元开度(云图)
			%oooooooooooooooooooooooooooooooooooooooo
			if Key_PLOT(1,7) == 14
			    if isempty(Crack3D_FluEl_Aperture)==0
				    Max_Aper = max(Max_Aperture_of_each_Crack(i));
					Min_Aper = min(Min_Aperture_of_each_Crack(i));
					nfluid_Ele = Crack3D_Fluid_Ele_Num{i};
					for j=1:nfluid_Ele
					    c_Aperture = Crack3D_FluEl_Aperture{i}(j);
						c_num_fluid_nodes = 3;
						c_fluid_nodes = Crack3D_Fluid_Ele_Nodes(i,j,1:c_num_fluid_nodes);
						c_x =Crack3D_CalP_X{i}(c_fluid_nodes);
						c_y =Crack3D_CalP_Y{i}(c_fluid_nodes);
						c_z =Crack3D_CalP_Z{i}(c_fluid_nodes);
						c_Color_Value = (c_Aperture-Min_Aper)/(Max_Aper-Min_Aper);
						
						if c_Color_Value >=0.0 && c_Color_Value <=0.1 
						    patch(c_x,c_y,c_z,[0/255,0/255,253/255])	
                        elseif c_Color_Value >0.1 && c_Color_Value <=0.2 
						    patch(c_x,c_y,c_z,[1/255,173/255,255/255])	
                        elseif c_Color_Value >0.2 && c_Color_Value <=0.3 
						    patch(c_x,c_y,c_z,[0/255,255/255,255/255])	
                        elseif c_Color_Value >0.3 && c_Color_Value <=0.4 
						    patch(c_x,c_y,c_z,[0/255,255/255,173/255])	
                        elseif c_Color_Value >0.4 && c_Color_Value <=0.5 
						    patch(c_x,c_y,c_z,[0/255,255/255,85/255])	
                        elseif c_Color_Value >0.5 && c_Color_Value <=0.6 
						    patch(c_x,c_y,c_z,[84/255,255/255,0/255])	
                        elseif c_Color_Value >0.6 && c_Color_Value <=0.7 
						    patch(c_x,c_y,c_z,[173/255,255/255,0/255])	
                        elseif c_Color_Value >0.7 && c_Color_Value <=0.8 
						    patch(c_x,c_y,c_z,[255/255,255/255,0/255])	
                        elseif c_Color_Value >0.8 && c_Color_Value <=0.9 
						    patch(c_x,c_y,c_z,[255/255,173/255,1/255])	
                        elseif c_Color_Value >0.9 && c_Color_Value <=1.0 
						    patch(c_x,c_y,c_z,[255/255,0/255,0/255])								
                        end						
					end
				end
			end	

			%oooooooooooooooooooooooooooooooooooooooo
			%       绘制流体单元和节点以及编号
			%oooooooooooooooooooooooooooooooooooooooo
			if Key_PLOT(1,6) >=1
				nfluid_Ele = Crack3D_Fluid_Ele_Num{i};
				% nfluid_Ele
				c_x =[];c_y =[];c_z =[];
				flu_ele_ave_x = []; flu_ele_ave_y = []; flu_ele_ave_z = [];   %BUGFIX-2022050301.
				for j=1:nfluid_Ele
				    c_num_fluid_nodes = 3;
				    c_fluid_nodes = Crack3D_Fluid_Ele_Nodes(i,j,1:c_num_fluid_nodes);
					c_x(j,1:3) =Crack3D_CalP_X{i}(c_fluid_nodes);
					c_y(j,1:3) =Crack3D_CalP_Y{i}(c_fluid_nodes);
					c_z(j,1:3) =Crack3D_CalP_Z{i}(c_fluid_nodes);
                    % 流体单元编号
                    if Key_PLOT(1,6) == 3 | Key_PLOT(1,6) == 4
					    flu_ele_ave_x(j) = sum(c_x(j,1:3))/c_num_fluid_nodes;
						flu_ele_ave_y(j) = sum(c_y(j,1:3))/c_num_fluid_nodes;
						flu_ele_ave_z(j) = sum(c_z(j,1:3))/c_num_fluid_nodes;
                    end								
				end
				
				
				% patch(c_x',c_y',c_z',[rand,rand,rand],'FaceAlpha',0.3,'FaceLighting','gouraud','LineWidth',0.2)	
				
				% 2023-09-13.
				if (Key_PLOT(1,7) ~= 26)  %如果已经绘制了接触单元接触状态，那么这里就不再绘制. 2023-09-23.
					patch(c_x',c_y',c_z',[rand,rand,rand],'FaceAlpha',0.3,'FaceLighting','gouraud','LineWidth',0.2)	
				end
				
				%patch(c_x',c_y',c_z',[96/255,182/255,255/255])
				
                if Key_PLOT(1,6) ==3 |  Key_PLOT(1,6) ==4	
                    tem_string = 1:1:nfluid_Ele;					
				    ts = text(flu_ele_ave_x,flu_ele_ave_y,flu_ele_ave_z,string(tem_string),'Color','blue','FontSize',10,'FontName','Consolas','FontAngle','italic'); % 流体单元编号			
				end				
				%绘制计算点及编号
				nCalP = size(Crack3D_CalP_X{i},2);
				c_CalP_x = []; c_CalP_y = []; c_CalP_z = [];                %BUGFIX-2022050301.
				for j=1:nCalP
					c_CalP_x(j) = Crack3D_CalP_X{i}(j);
					c_CalP_y(j) = Crack3D_CalP_Y{i}(j);
					c_CalP_z(j) = Crack3D_CalP_Z{i}(j);
				end
				if Key_PLOT(1,6) ~=5
				    plot3(c_CalP_x,c_CalP_y,c_CalP_z,'g.','MarkerSize',10.0)    % MarkerSize 表示点的大小,黑色点
				end
				if Key_PLOT(1,6) ==2 |  Key_PLOT(1,6) ==4
				    tem_string = 1:1:nCalP;
					ts = text(c_CalP_x,c_CalP_y,c_CalP_z,string(tem_string),'Color','red','FontSize',10,'FontName','Consolas','FontAngle','italic');
				end								
			end				
		end	
	end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%绘制离散裂缝面边界节点的局部坐标系
% for i = 1:num_Crack(isub)
	% for j=1:size(Crack3D_Meshed_Outline{i},2)
		% Crack_Node = Crack3D_Meshed_Outline{i}(j);	
		% c_node_x = [Crack_node_X{i}(Crack_Node)];
		% c_node_y = [Crack_node_Y{i}(Crack_Node)];
		% c_node_z = [Crack_node_Z{i}(Crack_Node)];			
		    % last_c_node_x = c_node_x;
			% last_c_node_y = c_node_y;
			% last_c_node_z = c_node_z;	
			%%%%%%%%%%%%%%%%%%显示离散裂缝面边界节点编号(测试用)
			%%%%%%ts = text(last_c_node_x,last_c_node_y,last_c_node_z,num2str(Crack_Node),'Color','black','FontSize',12,'FontName','Consolas','FontAngle','italic');	%真实编号
			%%%%% ts = text(last_c_node_x,last_c_node_y,last_c_node_z,num2str(j),'Color','black','FontSize',12,'FontName','Consolas','FontAngle','italic');	%边界编号
	% end
% end

%==============================================================  	  	
% 绘制所有自由度的载荷. Added on 2022-04-23. NEWFTU-2022042301. 
% 该段代码与2D问题中的Plot_Mesh.m中的代码结构相同.
%==============================================================  
if Key_PLOT(1,7)==1 && num_Crack(isub)~=0
    disp(['      ----- Plotting forces of enriched DOFs...'])
	%如果载荷文件存在则：
	if exist([Full_Pathname,'.fxdf_',num2str(isub)], 'file') ==2  
		% Read x方向载荷.
		if Key_Data_Format==1 
			Force_x = load([Full_Pathname,'.fxdf_',num2str(isub)]);   
		elseif Key_Data_Format==2  %Binary
			c_file = fopen([Full_Pathname,'.fxdf_',num2str(isub)],'rb');
			[Force_x,cc_count]   = fread(c_file,inf,'double');
			fclose(c_file);
		end
		% Read y方向载荷.
		if Key_Data_Format==1 
			Force_y = load([Full_Pathname,'.fydf_',num2str(isub)]);   
		elseif Key_Data_Format==2  %Binary
			c_file = fopen([Full_Pathname,'.fydf_',num2str(isub)],'rb');
			[Force_y,cc_count]   = fread(c_file,inf,'double');
			fclose(c_file);
		end
		% Read z方向载荷.
		if Key_Data_Format==1 
			Force_z = load([Full_Pathname,'.fzdf_',num2str(isub)]);   
		elseif Key_Data_Format==2  %Binary
			c_file = fopen([Full_Pathname,'.fzdf_',num2str(isub)],'rb');
			[Force_z,cc_count]   = fread(c_file,inf,'double');
			fclose(c_file);
		end
		
		Node_Force_x(1:Num_Node) = 0;
		Node_Force_y(1:Num_Node) = 0;
		Node_Force_z(1:Num_Node) = 0;
		% 节点循环,计算每个节点对应的增强节点号 
		for i_N =1:Num_Node
			for iCrack=1:num_Crack(isub)
				Num_Enriched_Node = POS(i_N,iCrack);
				if Num_Enriched_Node~=0 
					Node_Force_x(i_N)=Node_Force_x(i_N) + Force_x(Num_Enriched_Node);
					Node_Force_y(i_N)=Node_Force_y(i_N) + Force_y(Num_Enriched_Node);
					Node_Force_z(i_N)=Node_Force_z(i_N) + Force_z(Num_Enriched_Node);
				end
				% if Num_Enriched_Node~=0 %& (abs(Node_Force_x(i_N)) + abs(Node_Force_y(i_N))>10)
					% i_N,Force_x(Num_Enriched_Node),Force_y(Num_Enriched_Node)
				% end
			end
		end

		% Plot forces.
		Max_x_Force = max(abs(Node_Force_x));
		Max_y_Force = max(abs(Node_Force_y));
		Max_z_Force = max(abs(Node_Force_z));
		%Min_x_Force = min(Node_Force_x)
		%Min_y_Force = min(Node_Force_y)
		Max_Force   = max(Max_x_Force,max(Max_y_Force,Max_z_Force));
		
		% Get the maximum and minimum value of the new coordinates of all nodes.
		Min_X_Coor = min(min(Node_Coor(:,1)));
		Max_X_Coor = max(max(Node_Coor(:,1)));
		Min_Y_Coor = min(min(Node_Coor(:,2)));
		Max_Y_Coor = max(max(Node_Coor(:,2)));	
		Min_Z_Coor = min(min(Node_Coor(:,3)));
		Max_Z_Coor = max(max(Node_Coor(:,3)));			
		W = Max_X_Coor - Min_X_Coor;
		H = Max_Y_Coor - Min_Y_Coor;
			
		% length of force arrow         
		length_arrow = (c_X_Length+c_Y_Length+c_Z_Length)/30;
		% length_arrow = sqrt(aveg_area_ele)*0.8;
		% Loop through each node.
		for i = 1:Num_Node
			if Node_Force_x(i) ~=0 || Node_Force_y(i) ~=0 || Node_Force_z(i) ~=0         % If the nodes has force load, then:
				c_force_x   = Node_Force_x(i);
				c_force_y   = Node_Force_y(i);
				c_force_z   = Node_Force_z(i);
				delta_L_x = c_force_x*length_arrow/Max_Force;
				delta_L_y = c_force_y*length_arrow/Max_Force;
				delta_L_z = c_force_z*length_arrow/Max_Force;
				
				StartPoint = [Node_Coor(i,1)                 Node_Coor(i,2)                Node_Coor(i,3)];
				EndPoint   = [Node_Coor(i,1)+delta_L_x       Node_Coor(i,2)+delta_L_y      Node_Coor(i,3)+delta_L_z];
				
				% h = Tools_mArrow3(StartPoint,EndPoint,'color','red','stemWidth',length_arrow/10,'tipWidth',length_arrow/35.0,'facealpha',1.0);
				h = Tools_mArrow3(StartPoint,EndPoint,'color','red','stemWidth',length_arrow/50,'tipWidth',length_arrow/35*2,'facealpha',1.0);
				% line([StartPoint(1) EndPoint(1)],[StartPoint(2) EndPoint(2)],'color','red','LineWidth',2)
				
				% The length of the head of the arrow.
				% length_arrow_head = length_arrow/3;
				
				% Plot the head of the arrow.
				% theta = atan2(EndPoint(2)-StartPoint(2),EndPoint(1)-StartPoint(1));
				% theta_1 = pi/2 - theta - pi/3;
				% delta_x = -length_arrow_head*cos(theta_1);
				% delta_y =  length_arrow_head*sin(theta_1);
				% line([EndPoint(1) EndPoint(1)+delta_x],[EndPoint(2) EndPoint(2)+delta_y],'color','red','LineWidth',1.5);
				% theta_2 = 3*pi/2 - theta + pi/3;
				% delta_x = -length_arrow_head*cos(theta_2);
				% delta_y =  length_arrow_head*sin(theta_2);
				% line([EndPoint(1) EndPoint(1)+delta_x],[EndPoint(2) EndPoint(2)+delta_y],'color','red','LineWidth',1.5);
				
			end	
		end
		
			% c_Length = c_Calp_Apeture/Max_Aperture*max_length;
			% c_delta_x = c_Length*c_CalP_V_x;
			% c_delta_y = c_Length*c_CalP_V_y;
			% c_delta_z = c_Length*c_CalP_V_z;
			% plot3(c_CalP_x,c_CalP_y,c_CalP_z,'g.','MarkerSize',12.0)    % MarkerSize 表示点的大小,黑色点
			% ts = text(c_CalP_x,c_CalP_y,c_CalP_z,num2str(j),'Color','black','FontSize',12,'FontName','Consolas','FontAngle','italic');
			% if c_Calp_Apeture >=0 
				% 张开型裂缝箭头朝外
				% 张开型裂缝用黑色
				% h = Tools_mArrow3([c_CalP_x c_CalP_y c_CalP_z],[c_CalP_x+c_delta_x c_CalP_y+c_delta_y c_CalP_z+c_delta_z],...
				% 'color','black','stemWidth',c_Length/25.0,'tipWidth',c_Length/10.0,'facealpha',1.0);
				% h = Tools_mArrow3([c_CalP_x c_CalP_y c_CalP_z],[c_CalP_x-c_delta_x c_CalP_y-c_delta_y c_CalP_z-c_delta_z],...
				% 'color','black','stemWidth',c_Length/25.0,'tipWidth',c_Length/10.0,'facealpha',1.0);
			% else
				% 闭合型裂缝箭头朝内(指向裂缝面)
				% h = Tools_mArrow3([c_CalP_x+c_delta_x c_CalP_y+c_delta_y c_CalP_z+c_delta_z],[c_CalP_x c_CalP_y c_CalP_z],...
				% 'color','black','stemWidth',c_Length/25.0,'tipWidth',c_Length/10.0,'facealpha',1.0);
				% h = Tools_mArrow3([c_CalP_x-c_delta_x c_CalP_y-c_delta_y c_CalP_z-c_delta_z],[c_CalP_x c_CalP_y c_CalP_z],...
				% 'color','black','stemWidth',c_Length/25.0,'tipWidth',c_Length/10.0,'facealpha',1.0);
			% end				
	end
end

%==============================================================  	  	
% 绘制面力转换成的节点载荷. 2023-01-23.
%==============================================================  
if Key_PLOT(1,7)==11 
    disp(['      ----- Plotting surface load...'])
    %计算总的面力节点载荷.
	Node_Force_x(1:Num_Node) = 0;
	Node_Force_y(1:Num_Node) = 0;
	Node_Force_z(1:Num_Node) = 0;
    for i_SL = 1:100
		%如果载荷文件存在则：
		if exist([Full_Pathname,'.fxsl_',num2str(i_SL),'_',num2str(isub)], 'file') ==2  
			% Read x方向载荷.
			Force_x = load([Full_Pathname,'.fxsl_',num2str(i_SL),'_',num2str(isub)]);   
			% Read y方向载荷.
			Force_y = load([Full_Pathname,'.fysl_',num2str(i_SL),'_',num2str(isub)]);   
			% Read z方向载荷.
			Force_z = load([Full_Pathname,'.fzsl_',num2str(i_SL),'_',num2str(isub)]);   
			for i_N =1:Num_Node
				Node_Force_x(i_N)=Node_Force_x(i_N) + Force_x(i_N);
				Node_Force_y(i_N)=Node_Force_y(i_N) + Force_y(i_N);
				Node_Force_z(i_N)=Node_Force_z(i_N) + Force_z(i_N);
			end
		end
	end
	% 最大载荷.
	Max_x_Force = max(abs(Node_Force_x));
	Max_y_Force = max(abs(Node_Force_y));
	Max_z_Force = max(abs(Node_Force_z));
	Max_Force   = max(Max_x_Force,max(Max_y_Force,Max_z_Force));
    % 逐个面力绘制.			
    for i_SL = 1:100
	    %箭头颜色
		if  i_SL==1
		    c_color = [255/255,0/255,0/255];
		elseif  i_SL==2
		    c_color = [160/255, 32/255, 240/255,]; 
		elseif  i_SL==3
		    c_color = [56/255, 94/255, 15/255]; 
		elseif  i_SL==4
		    c_color = [0/255,0/255,225/255]; 
		elseif  i_SL==5
		    c_color = [218/255, 112/255, 214/255]; 	
        else
		
		end
		%如果载荷文件存在则：
		if exist([Full_Pathname,'.fxsl_',num2str(i_SL),'_',num2str(isub)], 'file') ==2  
			% Read x方向载荷.
			Force_x = load([Full_Pathname,'.fxsl_',num2str(i_SL),'_',num2str(isub)]);   
			% Read y方向载荷.
			Force_y = load([Full_Pathname,'.fysl_',num2str(i_SL),'_',num2str(isub)]);   
			% Read z方向载荷.
			Force_z = load([Full_Pathname,'.fzsl_',num2str(i_SL),'_',num2str(isub)]);   
			
			% Get the maximum and minimum value of the new coordinates of all nodes.
			Min_X_Coor = min(min(Node_Coor(:,1)));
			Max_X_Coor = max(max(Node_Coor(:,1)));
			Min_Y_Coor = min(min(Node_Coor(:,2)));
			Max_Y_Coor = max(max(Node_Coor(:,2)));	
			Min_Z_Coor = min(min(Node_Coor(:,3)));
			Max_Z_Coor = max(max(Node_Coor(:,3)));			
			W = Max_X_Coor - Min_X_Coor;
			H = Max_Y_Coor - Min_Y_Coor;
				
			% length of force arrow         
			length_arrow = (c_X_Length+c_Y_Length+c_Z_Length)/30;
			% Loop through each node.
			for i = 1:Num_Node
				if Force_x(i) ~=0 || Force_y(i) ~=0 || Force_z(i) ~=0         % If the nodes has force load, then:
					c_force_x   =Force_x(i);
					c_force_y   =Force_y(i);
					c_force_z   =Force_z(i);
					delta_L_x = c_force_x*length_arrow/Max_Force;
					delta_L_y = c_force_y*length_arrow/Max_Force;
					delta_L_z = c_force_z*length_arrow/Max_Force;
					StartPoint = [Node_Coor(i,1)                 Node_Coor(i,2)                Node_Coor(i,3)];
					EndPoint   = [Node_Coor(i,1)+delta_L_x       Node_Coor(i,2)+delta_L_y      Node_Coor(i,3)+delta_L_z];
					h = Tools_mArrow3(StartPoint,EndPoint,'color',c_color,'stemWidth',length_arrow/80,'tipWidth',length_arrow/35*1.5,'facealpha',1.0);
				end	
			end				
		end
	end
end

%==========================
% 绘制离散裂缝面边界线.
%========================== 
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
		plot3(c_node_x,c_node_y,c_node_z,'LineWidth',1,'Color','black')	
	end
end

%=================================                     
% Plot the node numbers.
%=================================
if Key_PLOT(1,2) ==2
    disp(['      ----- Plotting node number...'])
	tem_string = 1:1:Num_Node;
    text(Node_Coor(:,1),Node_Coor(:,2),Node_Coor(:,3),string(tem_string),'FontName',Title_Font,'FontSize',9,'color',[3/255,168/255,158/255])	%锰蓝色
end

%================================= 
% Plot the element numbers.
%================================= 
if Key_PLOT(1,3) >=2
    disp(['      ----- Plotting element number...'])
    for iElem = 1:Num_Elem
        NN = [Elem_Node(iElem,1) Elem_Node(iElem,2) Elem_Node(iElem,3) Elem_Node(iElem,4) Elem_Node(iElem,5) Elem_Node(iElem,6) Elem_Node(iElem,7) Elem_Node(iElem,8)];
        XN = Node_Coor(NN,1);
        YN = Node_Coor(NN,2);
		ZN = Node_Coor(NN,3);
		% mean_XN(iElem) = mean(XN)+rand()*0.001;
		% mean_YN(iElem) = mean(YN)+rand()*0.001;
		% mean_ZN(iElem) = mean(ZN)+rand()*0.001;
		mean_XN(iElem) = mean(XN);
		mean_YN(iElem) = mean(YN);
		mean_ZN(iElem) = mean(ZN);		
    end
	tem_string = 1:1:Num_Elem;	
    text(mean_XN,mean_YN,mean_ZN,string(tem_string),'FontName',Title_Font,'FontSize',10,'color','black')	
	%Plot element center
	if Key_PLOT(1,3) >=3
	    plot3(mean_XN,mean_YN,mean_ZN,'k*','MarkerSize',9.0)    % MarkerSize 表示点的大小,黑色点
	end
end

%===================
%   Plot nodes.
%=================== 
if isempty(Node_Coor) ~= 1
    length_min = min(c_X_Length,min(c_Y_Length,c_Z_Length))/5.0; 
	r = length_min/20;
    if Key_PLOT(1,2)>=1
		disp(['      ----- Plotting nodes......'])
		x_node =[];y_node =[];z_node =[];
		count = 0;
		for j =1:Num_Node
			count = count +1;
			x_node(count) = Node_Coor(j,1);                                          
			y_node(count) = Node_Coor(j,2);  
			z_node(count) = Node_Coor(j,3);  		
		end
		plot3(x_node,y_node,z_node,'k.','MarkerSize',5.0)    % MarkerSize 表示点的大小,黑色点
	end
end

%================================= 
%     Plot enriched nodes.
%================================= 
if isempty(Post_Enriched_Nodes) ~= 1
    length_min = min(c_X_Length,min(c_Y_Length,c_Z_Length))/5.0; 
	r = length_min/10;
    if (Key_PLOT(1,8)==1 || Key_PLOT(1,8)==2 || Key_PLOT(1,8)==3)
		disp(['      ----- Plotting enriched nodes......'])
		count_1 = 0;count_2 = 0;count_3 = 0;
		x_node_1 =[];y_node_1 =[];z_node_1 =[];		
		x_node_2 =[];y_node_2 =[];z_node_2 =[];	
		x_node_3 =[];y_node_3 =[];z_node_3 =[];	
		tem_string_1 = [];tem_string_2= [];tem_string_3= [];
		for i =1 :size(Post_Enriched_Nodes,2)
		
		    %仅绘制给定的裂缝号. 2022-09-28. IMPROV-2022092801.
		    if Crack_to_Plot >=1 
			    if i~= Crack_to_Plot
				    continue
				end
			end		
		% for i =1 :1
		% for i =2 :2
			for j =1:Num_Node
				x_node = Node_Coor(j,1);                                          
				y_node = Node_Coor(j,2);  
                z_node = Node_Coor(j,3);  				
				if Post_Enriched_Nodes(j,i)==1     % Tip nodes
				    count_1 = count_1 +1;
				    x_node_1(count_1) = Node_Coor(j,1);                                          
				    y_node_1(count_1) = Node_Coor(j,2);  
                    z_node_1(count_1) = Node_Coor(j,3);  	
                    tem_string_1(count_1) = j;		
				elseif Post_Enriched_Nodes(j,i)==2 % Heaviside nodes
				    count_2 = count_2 +1;
				    x_node_2(count_2) = Node_Coor(j,1);                                          
				    y_node_2(count_2) = Node_Coor(j,2);  
                    z_node_2(count_2) = Node_Coor(j,3);  
                    tem_string_2(count_2) = j;						
				elseif Post_Enriched_Nodes(j,i)==3 % Junction nodes
				    count_3 = count_3 +1;
				    x_node_3(count_3) = Node_Coor(j,1);                                          
				    y_node_3(count_3) = Node_Coor(j,2);  
                    z_node_3(count_3) = Node_Coor(j,3);
                    tem_string_3(count_3) = j;	  					
				end
			end
		end

		plot3(x_node_1,y_node_1,z_node_1,'r.','MarkerSize',18.0) %裂尖增强节点 		
		plot3(x_node_2,y_node_2,z_node_2,'b.','MarkerSize',18.0) %Heaviside增强节点
		plot3(x_node_3,y_node_3,z_node_3,'c.','MarkerSize',26.0) %Junction增强节点
		
		%绘制强节点对应的FEM节点号. 2022-07-06.
	    if Key_PLOT(1,8)==3
			text(x_node_1,y_node_1,z_node_1,string(tem_string_1),'FontName',Title_Font,'FontSize',9,'color','r')	
			text(x_node_2,y_node_2,z_node_2,string(tem_string_2),'FontName',Title_Font,'FontSize',9,'color','b')		
			text(x_node_3,y_node_3,z_node_3,string(tem_string_3),'FontName',Title_Font,'FontSize',9,'color','c')
        end		
	end

	%绘制增强单元网格. 2022-06-18.
	if Key_PLOT(1,8)==2
	    disp(['      ----- Plotting enriched elements......'])
		c_plot_count = 0;
		Ploted_Ele_lines =[0 0];	
		to_be_plot_count = 0;
		to_be_plot_x = [];to_be_plot_y = [];to_be_plot_z = [];  %2021-08-02		
		c_num_count_ele = 0;
		El_Center_x =[];El_Center_y =[];El_Center_z =[];Elem_Num_Vector =[];
		for iElem = 1:Num_Elem
			NN = [Elem_Node(iElem,1) Elem_Node(iElem,2) ...
				  Elem_Node(iElem,3) Elem_Node(iElem,4) ...
				  Elem_Node(iElem,5) Elem_Node(iElem,6) ...
				  Elem_Node(iElem,7) Elem_Node(iElem,8)];                             % Nodes for current element
  			%如果该单元含有增强节点	
			if isempty(Post_Enriched_Nodes)==0
				if (min(min(Post_Enriched_Nodes(NN,1:size(Post_Enriched_Nodes,2))))>=1 )   %8个节点都增强的增强单元
					for i=1:3
						%检查该边线是否已经绘制(防止重复绘制)
						if not(ismember(sort([NN(i),NN(i+1)]),Ploted_Ele_lines,'rows')) 		
							c_plot_count = c_plot_count + 1;
							Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+1)]);
							c_plot_count = c_plot_count + 1;
							Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+1)]);
							to_be_plot_count = to_be_plot_count +1;
							to_be_plot_x(to_be_plot_count,1:2) = [Node_Coor(NN(i),1) Node_Coor(NN(i+1),1)];
							to_be_plot_y(to_be_plot_count,1:2) = [Node_Coor(NN(i),2) Node_Coor(NN(i+1),2)];
							to_be_plot_z(to_be_plot_count,1:2) = [Node_Coor(NN(i),3) Node_Coor(NN(i+1),3)];								
						end			
					end
					for i=5:7
						%检查该边线是否已经绘制
						if not(ismember(sort([NN(i),NN(i+1)]),Ploted_Ele_lines,'rows')) 		
							c_plot_count = c_plot_count + 1;
							Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+1)]);
							to_be_plot_count = to_be_plot_count +1;
							to_be_plot_x(to_be_plot_count,1:2) = [Node_Coor(NN(i),1) Node_Coor(NN(i+1),1)];
							to_be_plot_y(to_be_plot_count,1:2) = [Node_Coor(NN(i),2) Node_Coor(NN(i+1),2)];
							to_be_plot_z(to_be_plot_count,1:2) = [Node_Coor(NN(i),3) Node_Coor(NN(i+1),3)];									
						end					  
					end
					for i=1:4
						%检查该边线是否已经绘制
						if not(ismember(sort([NN(i),NN(i+4)]),Ploted_Ele_lines,'rows')) 		
							c_plot_count = c_plot_count + 1;
							Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(i),NN(i+4)]);
							to_be_plot_count = to_be_plot_count +1;
							to_be_plot_x(to_be_plot_count,1:2) = [Node_Coor(NN(i),1) Node_Coor(NN(i+4),1)];
							to_be_plot_y(to_be_plot_count,1:2) = [Node_Coor(NN(i),2) Node_Coor(NN(i+4),2)];
							to_be_plot_z(to_be_plot_count,1:2) = [Node_Coor(NN(i),3) Node_Coor(NN(i+4),3)];	
						end				  
					end	
					%检查该边线是否已经绘制
					if not(ismember(sort([NN(1),NN(4)]),Ploted_Ele_lines,'rows')) 		
						c_plot_count = c_plot_count + 1;
						Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(1),NN(4)]);		
						to_be_plot_count = to_be_plot_count +1;
						to_be_plot_x(to_be_plot_count,1:2) = [Node_Coor(NN(1),1) Node_Coor(NN(4),1)];
						to_be_plot_y(to_be_plot_count,1:2) = [Node_Coor(NN(1),2) Node_Coor(NN(4),2)];
						to_be_plot_z(to_be_plot_count,1:2) = [Node_Coor(NN(1),3) Node_Coor(NN(4),3)];							
					end
					if not(ismember(sort([NN(5),NN(8)]),Ploted_Ele_lines,'rows')) 	
						c_plot_count = c_plot_count + 1;
						Ploted_Ele_lines(c_plot_count,1:2) = sort([NN(5),NN(8)]);			
						to_be_plot_count = to_be_plot_count +1;
						to_be_plot_x(to_be_plot_count,1:2) = [Node_Coor(NN(5),1) Node_Coor(NN(8),1)];
						to_be_plot_y(to_be_plot_count,1:2) = [Node_Coor(NN(5),2) Node_Coor(NN(8),2)];
						to_be_plot_z(to_be_plot_count,1:2) = [Node_Coor(NN(5),3) Node_Coor(NN(8),3)];							
					end					  
				end		
			end
		end 
        plot3(to_be_plot_x',to_be_plot_y',to_be_plot_z','LineWidth',Line_width,'Color',[.5 .5 .5])	%灰色	
	end
end

%==============================================
% 绘制井筒, Plot wellbore, NEWFTU-2022041901.
%==============================================
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

%============================================================  	  
%   绘制某单元的Gauss点坐标. 2022-07-16. NEWFTU-2022071601.
%   仅适用于固定积分算法. Key_Integral_Sol  = 2 
%============================================================  
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

%============================================================  	  
%   绘制3D天然裂缝. NEWFTU-2023010901.
%============================================================ 
if (Key_PLOT(1,12)==1 | Key_PLOT(1,12)==2)
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
				  [Crack3D_NF_nfcz{i_NF}(i_side),Crack3D_NF_nfcz{i_NF}(i_side+1)],'LineWidth',0.1,'Color',[128/255, 138/255, 135/255])	%灰色	
		end	
		plot3([Crack3D_NF_nfcx{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcx{i_NF}(1)], ...
			  [Crack3D_NF_nfcy{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcy{i_NF}(1)], ...
			  [Crack3D_NF_nfcz{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcz{i_NF}(1)],'LineWidth',0.1,'Color',[128/255, 138/255, 135/255])	%灰色
		%绘制天然裂缝编号.
		if (Key_PLOT(1,12)==2)
			ts = text(c_Center_x,c_Center_y,c_Center_z,string(i_NF),'Color','black','FontSize',8,'FontName','Consolas','FontAngle','italic');		
		end
	end
end
%以下用于测试,绘制1703号单元的Guass点（保存在*.gauss1703文件中）, 2022-07-30：
% Element_Gauss_Points = load([Full_Pathname,'.gauss1703']);
% plot3(Element_Gauss_Points(:,1),Element_Gauss_Points(:,2),Element_Gauss_Points(:,3),'k.','MarkerSize',9.0)    % MarkerSize 表示点的大小,黑色点



%TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
%裂尖增强单元的基准线(baseline)和基准线的局部坐标系,2020-01-21
%TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
% for iElem = 1:Num_Elem
	% if sum(abs(Tip_Enriched_Ele_BaseLine(iElem,1:6)))>1.0D-10
		% Point_A = Tip_Enriched_Ele_BaseLine(iElem,1:3);
		% Point_B = Tip_Enriched_Ele_BaseLine(iElem,4:6);
		% plot3([Point_A(1),Point_B(1)],[Point_A(2),Point_B(2)],[Point_A(3),Point_B(3)],'LineWidth',1.5,'Color','m')	
		% plot3(Point_A(1),Point_A(2),Point_A(3),'r.','MarkerSize',16.0);    % MarkerSize 表示点的大小,青色点 
		% plot3(Point_B(1),Point_B(2),Point_B(3),'r.','MarkerSize',16.0);    % MarkerSize 表示点的大小,青色点 
        % StartPoint = Point_A;
	    % EndPoint   = Point_B;
		% h = Tools_mArrow3(StartPoint,EndPoint,'color','black','stemWidth',0.018,'facealpha',1.0);
	% end		
% end
		
% Plot Gauss points.
% if Key_PLOT(1,4) == 1
    % disp(['      ----- Plotting Gauss points...'])
    %%%% Read gauss point coordinates file.
	% Gauss_Coor = load([Full_Pathname,'.gcor_',num2str(isub)]);
	% plot(Gauss_Coor(:,2),Gauss_Coor(:,3),'bo','MarkerSize',1,'Color','black')

	% clear Gauss_Coor
% end



% Active Figure control widget (2021-08-01)
% Ref: https://ww2.mathworks.cn/matlabcentral/fileexchange/38019-figure-control-widget
% Press q to exit.
% Press r (or double-click) to reset to the initial.


%光源设置

% light
% light('Position',[0 0 0.1],'Style','local')
% light('Position',[0 0 0])
% lighting flat
% lighting gouraud
% lighting phong



% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除
% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除
% c_A = [3.0,3.0,3.0]
% c_B = [5.0,5.0,5.0]
% c_A = [5.5,1.5,5.5]
% c_B = [5.0,5.0,5.0]
% c_A = [1.0,1.5,5.5]
% c_B = [7.0,1.5,5.5]  
% Inter_Points(1,1:3) =  [6.0000000000000000        1.5000000000000000        5.5000000000000000]
% Inter_Points(2,1:3) = [5.4285714285714288        2.0000000000000000        5.4285714285714288]	    
% plot3([c_A(1),c_B(1)],[c_A(2),c_B(2)],[c_A(3),c_B(3)],'m','MarkerSize',20.0)    % MarkerSize 表示点的大小
%% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除 交叉点
% plot3(Inter_Points(1,1) ,Inter_Points(1,2),Inter_Points(1,3),'g.','MarkerSize',20.0)    % MarkerSize 表示点的大小
% plot3(Inter_Points(2,1) ,Inter_Points(2,2),Inter_Points(2,3),'g.','MarkerSize',20.0)    % MarkerSize 表示点的大小
% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除
% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除% 用于测试，可删除


% i_G=1
% tem(1:3) =[7.0198550717512314        7.0198550717512314        6.0198550717512322]
% plot3(tem(1),tem(2),tem(3),'r.','MarkerSize',30.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'i_G=1','Color','red','FontSize',10,'FontName','Consolas','FontAngle','italic');

% i_G=8
% tem(1:3) =[7.0198550717512322        7.0198550717512322        6.9801449282487686]
% plot3(tem(1),tem(2),tem(3),'r.','MarkerSize',30.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'i_G=8','Color','red','FontSize',10,'FontName','Consolas','FontAngle','italic');

% i_G=478
% tem(1:3) =[7.9801449282487678        7.4082826787521752        6.7627662049581652]
% plot3(tem(1),tem(2),tem(3),'r.','MarkerSize',30.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'i_G=478','Color','red','FontSize',10,'FontName','Consolas','FontAngle','italic');

% i_G=512
% tem(1:3) =[7.9801449282487678        7.9801449282487678        6.9801449282487678]
% plot3(tem(1),tem(2),tem(3),'r.','MarkerSize',30.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'i_G=512','Color','red','FontSize',10,'FontName','Consolas','FontAngle','italic');


% i_G=508
% tem(1:3) =[ 8.9801449282487695        8.9801449282487695        4.4082826787521761]
% plot3(tem(1),tem(2),tem(3),'r.','MarkerSize',30.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'i_G=508','Color','red','FontSize',10,'FontName','Consolas','FontAngle','italic');


% tem(1:3) =[ -3.6716209765639185      -0.62709433839651940        5.000000000000000]
% plot3(tem(1),tem(2),tem(3),'r.','MarkerSize',30.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'i_G=508','Color','red','FontSize',10,'FontName','Consolas','FontAngle','italic');

% tem(1:3) =[ 5.5000000000000000        8.5000000000000000        8.5000000000000000]
% plot3(tem(1),tem(2),tem(3),'r.','MarkerSize',30.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'Center','Color','red','FontSize',50,'FontName','Consolas','FontAngle','italic');


% i_G=508
% tem(1:3) =[  14.6110005134771        14.3596346691710 3.31862845248504]
% plot3(tem(1),tem(2),tem(3),'r.','MarkerSize',30.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'i_G=508','Color','red','FontSize',10,'FontName','Consolas','FontAngle','italic');


% tem(1:3) =[ 14.6399500984347        14.3596346691710 2.99899027014304]
% plot3(tem(1),tem(2),tem(3),'r.','MarkerSize',30.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'i_G=508','Color','red','FontSize',10,'FontName','Consolas','FontAngle','italic');

% tem(1:3) =[  13.4421067463608        14.3596346691710  3.31381111849030]
% plot3(tem(1),tem(2),tem(3),'r.','MarkerSize',30.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'Center','Color','red','FontSize',50,'FontName','Consolas','FontAngle','italic');


%用于测试；2022-08-02.
% test_points  = load(['test.txt']);
% for i=1:size(test_points,1)
	% plot3([test_points(i,1)*10,0],[test_points(i,2)*10,0],[test_points(i,3)*10,0],'blue');
% end
 
%用于测试；2022-12-18.
% test_points  = load(['X:\PhiPsi_Project\PhiPsi_Work\3D_Block_25x25x25_Fixed_NonUni2\3D_Block_25x25x25_Fixed_NonUni2_before_points.txt']);
% for i=1:size(test_points,1)
	% plot3(test_points(i,1),test_points(i,2),test_points(i,3),'r.','MarkerSize',30.0)  
	% ts = text(test_points(i,1),test_points(i,2),test_points(i,3),num2str(i),'Color','red','FontSize',20,'FontName','Consolas','FontAngle','italic');
% end 
% test_points  = load(['X:\PhiPsi_Project\PhiPsi_Work\3D_Block_25x25x25_Fixed_NonUni2\3D_Block_25x25x25_Fixed_NonUni2_after_points.txt']);
% for i=1:size(test_points,1)
	% plot3(test_points(i,1),test_points(i,2),test_points(i,3),'b.','MarkerSize',30.0)  
% end  

 
 
 
% tem(1:3) =[10.0198550717512        10.0198550717512        10.0198550717512]
% plot3(tem(1),tem(2),tem(3),'r.','MarkerSize',10.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'Point','Color','red','FontSize',10,'FontName','Consolas','FontAngle','italic'); 
 
% tem(1:3) =[10.5000000000000        10.0198550717512        10.0198550717512]
% plot3(tem(1),tem(2),tem(3),'b.','MarkerSize',10.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'Per','Color','blue','FontSize',10,'FontName','Consolas','FontAngle','italic');  
 
% tem(1:3) =[10.5000000000000        11.7500000000000 9.25000000000000]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P1','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 

% tem(1:3) =[10.5000000000000        10.9166666666667 9.25000000000000]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P2','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 

% tem(1:3) =[10.5000000000000        10.0833333333333 9.25000000000000]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P3','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 

% tem(1:3) =[10.5000000000000        9.25000000000000 9.25000000000000]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P4','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 

% tem(1:3) =[10.5000000000000        9.25000000000000 10.0833333333333]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P5','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 

% tem(1:3) =[10.5000000000000        9.25000000000000 10.9166666666667]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P6','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 

% tem(1:3) =[10.5000000000000        9.25000000000000 11.7500000000000]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P7','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 

% tem(1:3) =[10.5000000000000        10.0833333333333 11.7500000000000]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P8','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 

% tem(1:3) =[10.5000000000000        10.9166666666667 11.7500000000000]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P9','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 

% tem(1:3) =[10.5000000000000        11.7500000000000 11.7500000000000]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P10','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 

% tem(1:3) =[10.5000000000000        11.7500000000000 10.9166666666667]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P11','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 

% tem(1:3) =[279.699309400676        378.604607385752 227.646929860624]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P12','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 
 
% tem(1:3) =[266.409759970920        355.737317120183        206.997148134291]
% plot3(tem(1),tem(2),tem(3),'black.','MarkerSize',15.0)    % MarkerSize 表示点的大小
% ts = text(tem(1),tem(2),tem(3),'P12','Color','black','FontSize',15,'FontName','Consolas','FontAngle','italic'); 
 
if Key_Figure_Control_Widget==1
    fcw(gca);
end

% Save pictures.
Save_Picture(c_figure,Full_Pathname,'mesh')
