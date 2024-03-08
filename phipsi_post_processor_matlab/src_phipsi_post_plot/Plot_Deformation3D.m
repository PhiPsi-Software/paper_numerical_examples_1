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

function Plot_Deformation3D(isub,Crack_X,Crack_Y,Crack_Z,Post_Enriched_Nodes,POS)
%绘制三维变形图.

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
global Tip_Enriched_Node_Ref_Element
global Cracks_CalP_UpDis_3D_X Cracks_CalP_UpDis_3D_Y Cracks_CalP_UpDis_3D_Z
global Cracks_CalP_LowDis_3D_X Cracks_CalP_LowDis_3D_Y Cracks_CalP_LowDis_3D_Z
global Crack3D_FluEl_Aperture Crack3D_Fluid_Ele_Num Crack3D_Fluid_Ele_Nodes
global Cracks_FluNode_Vector_3D_X Cracks_FluNode_Vector_3D_Y Cracks_FluNode_Vector_3D_Z
global Title_Font Key_Figure_Control_Widget
global num_Wellbore num_Points_WB_1 num_Points_WB_2 num_Points_WB_3 num_Points_WB_4 num_Points_WB_5
global Wellbore_1 Wellbore_2 Wellbore_3 Wellbore_4 Wellbore_5 Frac_Stage_Points
global DISP_with_XFEM
global Key_Axis_NE
global Yes_has_FZ frac_zone_min_x frac_zone_max_x frac_zone_min_y frac_zone_max_y frac_zone_min_z frac_zone_max_z
global Key_Plot_Elements Elements_to_be_Ploted
global Key_Plot_EleGauss EleGauss_to_be_Ploted
global Crack_to_Plot
global Crack3D_NF_nfcx Crack3D_NF_nfcy Crack3D_NF_nfcz Num_NF_3D
global FaceAlpha_3D_ele_face
global RESECH_CODE

% global Tri_BCD
disp(['      ----- Plotting deformed mesh......'])
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
title('Deformation','FontName',Title_Font,'FontSize',Size_Font)
axis off; axis equal;
delta = sqrt(aveg_area_ele);
axis([Min_X_Coor_New-delta Max_X_Coor_New+delta ...
      Min_Y_Coor_New-delta Max_Y_Coor_New+delta ...
	  Min_Z_Coor_New-delta Max_Z_Coor_New+delta]);
	  
% Set Viewpoint	  
PhiPsi_Viewing_Angle_Settings

%生成随机颜色:用于不同裂缝面的颜色.
myMap = rand(5000,3);  %随机颜色		
myMap(3,1:3) =    [0   201/255   87/255];
%
% myMap(1,1:3) =    [0.884314440485327   0.161313421622389   0.525775320328067];
% myMap(2,1:3) =    [0.733649413450638   0.854249735848101   0.427394772050207];
% myMap(3,1:3) =    [0.866326872203972   0.319323003476076   0.432045096884756];
% myMap(4,1:3) =    [0.618879563737718   0.668939362552731   0.403628300164498];
% myMap(5,1:3) =    [0.310937756907351   0.020179285105203   0.098491934107055];
% myMap(6,1:3) =    [0.897011467980662   0.841600575430439   0.156597620323033];
% myMap(7,1:3) =    [0.994592811426075   0.707817580212907   0.385552448208415];
% myMap(8,1:3) =    [0.136984808441040   0.961877402959021   0.562162654489000];
% myMap(9,1:3) =    [0.419704269134258   0.770588797489797   0.724513426570022];
% myMap(10,1:3) =    [0.047997710573757   0.614788282839491   0.683899902754217];
% myMap(11,1:3) =    [0.007942084712926   0.136981480006215   0.421643397006816];
% myMap(12,1:3) =    [0.136028369582063   0.777110556306684   0.348278892672013];
% myMap(13,1:3) =    [0.976234437038657   0.635160241781029   0.721858535901053];
% myMap(14,1:3) =    [0.055475862871541   0.358816731739953   0.680519522959160];
% myMap(15,1:3) =    [0.670492414411660   0.787325065065044   0.445462874129049];
% myMap(16,1:3) =    [0.897708760392552   0.299796633865879   0.264058584058194];
% myMap(17,1:3) =    [0.300634138121817   0.228907366313687   0.738467729633833];
% myMap(18,1:3) =    [0.314789999978171   0.177176852767750   0.149247481893918];
% myMap(19,1:3) =    [0.632671549640363   0.259630047866087   0.190387676408159];
% myMap(20,1:3) =    [0.848954410204599   0.311477034145926   0.830064457942007];
% myMap(21,1:3) =    [0.469736471427612   0.293619050589780   0.186210164120694];
% myMap(22,1:3) =    [0.293217962585692   0.998473999143082   0.422944195282633];
% myMap(23,1:3) =    [0.147299670743357   0.437671375087110   0.780148539451202];
% myMap(24,1:3) =    [0.359751969744317   0.645664705194988   0.451329016178710];
% myMap(25,1:3) =    [0.757122972947799   0.574184086953072   0.826607192091113];

%============================================  	
%绘制裂尖应力计算点及计算球内的高斯点.
%============================================  	
if Key_PLOT(2,12)==1 |  Key_PLOT(2,12)==2   
    %绘制裂尖应力计算点
	if exist([Full_Pathname,'.vspt_',num2str(isub)], 'file') ==2
		test= load([Full_Pathname,'.vspt_',num2str(isub)]);
		if isempty(test)==0 %不为空
		    plot3(test(:,1),test(:,2),test(:,3),'k.','MarkerSize',15.0,'color','m') 
			num_Ball = size(test,1);
			%绘制透明圆球
			for i_Ball = 1:num_Ball
				r_ball = test(i_Ball,4);
				x_cor = test(i_Ball,1);
				y_cor = test(i_Ball,2);
				z_cor = test(i_Ball,3);
				[x_ball,y_ball,z_ball]=sphere(30);
				surf(r_ball*x_ball +x_cor,r_ball*y_ball +y_cor,r_ball*z_ball +z_cor,'FaceColor','red','LineStyle','none','FaceAlpha',0.2);
			end
		end
	end
	% 计算球内的高斯点
	if Key_PLOT(2,12)==2 
		if exist([Full_Pathname,'.vspg_',num2str(isub)], 'file') ==2
			test= load([Full_Pathname,'.vspg_',num2str(isub)]);
			num_Total_Gauss = size(test,1);
			if isempty(test)==0%不为空
			    plot3(test(:,1),test(:,2),test(:,3),'k.','MarkerSize',5.0) 
			end
		end	
	end
end

%==========================================  
%   绘制单元面-不同材料号采用不同颜色. 
%==========================================   	
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
	if Key_PLOT(2,3) == 1
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
		if Elem_Material(iElem) == i_Material
			NN = [Elem_Node(iElem,1) Elem_Node(iElem,2) ...
				  Elem_Node(iElem,3) Elem_Node(iElem,4) ...
				  Elem_Node(iElem,5) Elem_Node(iElem,6) ...
				  Elem_Node(iElem,7) Elem_Node(iElem,8)];                             % Nodes for current element
			  %第1个面
			  if not(ismember(sort([NN(1),NN(2),NN(3),NN(4)]),Ploted_Ele_Face,'rows')) %检查该面是否已经绘制(防止重复绘制)
				c_plot_count = c_plot_count + 1;
				Ploted_Ele_Face(c_plot_count,1:4) = sort([NN(1),NN(2),NN(3),NN(4)]);	
				count_1 = count_1 +1;
				c_x_1(1:4,count_1) = [New_Node_Coor(NN(1),1),New_Node_Coor(NN(2),1),New_Node_Coor(NN(3),1),New_Node_Coor(NN(4),1)];
				c_y_1(1:4,count_1) = [New_Node_Coor(NN(1),2),New_Node_Coor(NN(2),2),New_Node_Coor(NN(3),2),New_Node_Coor(NN(4),2)];
				c_z_1(1:4,count_1) = [New_Node_Coor(NN(1),3),New_Node_Coor(NN(2),3),New_Node_Coor(NN(3),3),New_Node_Coor(NN(4),3)];		
			  end	  
			  %第2个面
			  if not(ismember(sort([NN(5),NN(6),NN(7),NN(8)]),Ploted_Ele_Face,'rows')) %检查该面是否已经绘制(防止重复绘制)
				c_plot_count = c_plot_count + 1;
				Ploted_Ele_Face(c_plot_count,1:4) = sort([NN(5),NN(6),NN(7),NN(8)]);	
				count_2 = count_2 +1;
				c_x_2(1:4,count_2) = [New_Node_Coor(NN(5),1),New_Node_Coor(NN(6),1),New_Node_Coor(NN(7),1),New_Node_Coor(NN(8),1)];
				c_y_2(1:4,count_2) = [New_Node_Coor(NN(5),2),New_Node_Coor(NN(6),2),New_Node_Coor(NN(7),2),New_Node_Coor(NN(8),2)];
				c_z_2(1:4,count_2) = [New_Node_Coor(NN(5),3),New_Node_Coor(NN(6),3),New_Node_Coor(NN(7),3),New_Node_Coor(NN(8),3)];			
			  end	
			  %第3个面
			  if not(ismember(sort([NN(1),NN(2),NN(6),NN(5)]),Ploted_Ele_Face,'rows')) %检查该面是否已经绘制(防止重复绘制)
				c_plot_count = c_plot_count + 1;
				Ploted_Ele_Face(c_plot_count,1:4) = sort([NN(1),NN(2),NN(6),NN(5)]);	
				count_3 = count_3 +1;
				c_x_3(1:4,count_3) = [New_Node_Coor(NN(1),1),New_Node_Coor(NN(2),1),New_Node_Coor(NN(6),1),New_Node_Coor(NN(5),1)];
				c_y_3(1:4,count_3) = [New_Node_Coor(NN(1),2),New_Node_Coor(NN(2),2),New_Node_Coor(NN(6),2),New_Node_Coor(NN(5),2)];
				c_z_3(1:4,count_3) = [New_Node_Coor(NN(1),3),New_Node_Coor(NN(2),3),New_Node_Coor(NN(6),3),New_Node_Coor(NN(5),3)];			
			  end	
			  %第4个面
			  if not(ismember(sort([NN(2),NN(3),NN(7),NN(6)]),Ploted_Ele_Face,'rows')) %检查该面是否已经绘制(防止重复绘制)
				c_plot_count = c_plot_count + 1;
				Ploted_Ele_Face(c_plot_count,1:4) = sort([NN(2),NN(3),NN(7),NN(6)]);	
				count_4 = count_4 +1;
				c_x_4(1:4,count_4) = [New_Node_Coor(NN(2),1),New_Node_Coor(NN(3),1),New_Node_Coor(NN(7),1),New_Node_Coor(NN(6),1)];
				c_y_4(1:4,count_4) = [New_Node_Coor(NN(2),2),New_Node_Coor(NN(3),2),New_Node_Coor(NN(7),2),New_Node_Coor(NN(6),2)];
				c_z_4(1:4,count_4) = [New_Node_Coor(NN(2),3),New_Node_Coor(NN(3),3),New_Node_Coor(NN(7),3),New_Node_Coor(NN(6),3)];			
			  end
			  %第5个面
			  if not(ismember(sort([NN(7),NN(8),NN(4),NN(3)]),Ploted_Ele_Face,'rows')) %检查该面是否已经绘制(防止重复绘制)
				c_plot_count = c_plot_count + 1;
				Ploted_Ele_Face(c_plot_count,1:4) = sort([NN(7),NN(8),NN(4),NN(3)]);	
				count_5 = count_5 +1;
				c_x_5(1:4,count_5) = [New_Node_Coor(NN(7),1),New_Node_Coor(NN(8),1),New_Node_Coor(NN(4),1),New_Node_Coor(NN(3),1)];
				c_y_5(1:4,count_5) = [New_Node_Coor(NN(7),2),New_Node_Coor(NN(8),2),New_Node_Coor(NN(4),2),New_Node_Coor(NN(3),2)];
				c_z_5(1:4,count_5) = [New_Node_Coor(NN(7),3),New_Node_Coor(NN(8),3),New_Node_Coor(NN(4),3),New_Node_Coor(NN(3),3)];			
			  end
			  %第6个面
			  if not(ismember(sort([NN(5),NN(1),NN(4),NN(8)]),Ploted_Ele_Face,'rows')) %检查该面是否已经绘制(防止重复绘制)
				c_plot_count = c_plot_count + 1;
				Ploted_Ele_Face(c_plot_count,1:4) = sort([NN(5),NN(1),NN(4),NN(8)]);	
				count_6 = count_6 +1;
				c_x_6(1:4,count_6) = [New_Node_Coor(NN(5),1),New_Node_Coor(NN(1),1),New_Node_Coor(NN(4),1),New_Node_Coor(NN(8),1)];
				c_y_6(1:4,count_6) = [New_Node_Coor(NN(5),2),New_Node_Coor(NN(1),2),New_Node_Coor(NN(4),2),New_Node_Coor(NN(8),2)];
				c_z_6(1:4,count_6) = [New_Node_Coor(NN(5),3),New_Node_Coor(NN(1),3),New_Node_Coor(NN(4),3),New_Node_Coor(NN(8),3)];		
			  end
		  end
	  end 
	  patch(c_x_1(1:4,1:count_1),c_y_1(1:4,1:count_1),c_z_1(1:4,1:count_1),Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)    %2021-08-02
	  patch(c_x_2(1:4,1:count_2),c_y_2(1:4,1:count_2),c_z_2(1:4,1:count_2),Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
	  patch(c_x_3(1:4,1:count_3),c_y_3(1:4,1:count_3),c_z_3(1:4,1:count_3),Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
	  patch(c_x_4(1:4,1:count_4),c_y_4(1:4,1:count_4),c_z_4(1:4,1:count_4),Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
	  patch(c_x_5(1:4,1:count_5),c_y_5(1:4,1:count_5),c_z_5(1:4,1:count_5),Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)
	  patch(c_x_6(1:4,1:count_6),c_y_6(1:4,1:count_6),c_z_6(1:4,1:count_6),Color_3D_ele_face,'FaceAlpha',FaceAlpha_3D_ele_face)    
	end
end

% 888

%============================================  	
%绘制变形后的网格.
%============================================  	
Line_width =0.1;
if Key_PLOT(2,1)==1
    if Key_PLOT(2,9)==1 &&  Key_PLOT(2,3) ~= 1
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
		plot3(to_be_plot_x',to_be_plot_y',to_be_plot_z','LineWidth',Line_width,'Color','green')	%灰色				
	end
	%绘制增强单元网格(2021-08-21改进)
    if Key_PLOT(2,9)==2  | Key_PLOT(2,9)==4  | Key_PLOT(2,9)==5 | Key_PLOT(2,9)==12  | Key_PLOT(2,9)==14  | Key_PLOT(2,9)==15  | Key_PLOT(2,9)==6  | Key_PLOT(2,9)==16%增强单元的网格
	%12、14、15、16额外绘制增强单元编号
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
			    %------------------------
			    %全部增强单元
				%------------------------
				if ((Key_PLOT(2,9)==2 | Key_PLOT(2,9)==4 | Key_PLOT(2,9)==12 | Key_PLOT(2,9)==14) && sum(sum(Post_Enriched_Nodes(NN,1:size(Post_Enriched_Nodes,2))))~=0) 
				   %仅裂尖增强单元(8个节点都是裂尖增强) 
					%用于绘制增强单元编号和形心点(2021-08-21)
					c_num_count_ele = c_num_count_ele +1;
					El_Center_x(c_num_count_ele) = sum(New_Node_Coor(NN,1))/8;
					El_Center_y(c_num_count_ele) = sum(New_Node_Coor(NN,2))/8;
					El_Center_z(c_num_count_ele) = sum(New_Node_Coor(NN,3))/8;
	                Elem_Num_Vector(c_num_count_ele) = iElem;
					
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
				
				%------------------------
			    %纯裂尖增强单元
				%------------------------
				if ((Key_PLOT(2,9)==5 | Key_PLOT(2,9)==15) && ...    
				   (sum(sum(Post_Enriched_Nodes(NN,1:size(Post_Enriched_Nodes,2))))==8 && max(max(Post_Enriched_Nodes(NN,1:size(Post_Enriched_Nodes,2))))==1 ))  
				   %仅裂尖增强单元(8个节点都是裂尖增强) 
					%用于绘制增强单元编号和形心点(2021-08-21)
					c_num_count_ele = c_num_count_ele +1;
					El_Center_x(c_num_count_ele) = sum(New_Node_Coor(NN,1))/8;
					El_Center_y(c_num_count_ele) = sum(New_Node_Coor(NN,2))/8;
					El_Center_z(c_num_count_ele) = sum(New_Node_Coor(NN,3))/8;
	                Elem_Num_Vector(c_num_count_ele) = iElem;
					
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

				%--------------------------------------
			    %纯Heaviside增强单元. 2022-07-31.
				%--------------------------------------
				if ((Key_PLOT(2,9)==6 | Key_PLOT(2,9)==16) && ...      %纯Heaviside增强单元
				   (sum(sum(Post_Enriched_Nodes(NN,1:size(Post_Enriched_Nodes,2))))==16 && max(max(Post_Enriched_Nodes(NN,1:size(Post_Enriched_Nodes,2))))==2 )) 
				   %仅裂尖增强单元(8个节点都是裂尖增强) 
					%用于绘制增强单元编号和形心点(2021-08-21)
					c_num_count_ele = c_num_count_ele +1;
					El_Center_x(c_num_count_ele) = sum(New_Node_Coor(NN,1))/8;
					El_Center_y(c_num_count_ele) = sum(New_Node_Coor(NN,2))/8;
					El_Center_z(c_num_count_ele) = sum(New_Node_Coor(NN,3))/8;
	                Elem_Num_Vector(c_num_count_ele) = iElem;
					
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
		%绘制增强单元编号和形心点(2021-08-21)
		if Key_PLOT(2,9)==12  | Key_PLOT(2,9)==14  | Key_PLOT(2,9)==15  | Key_PLOT(2,9)==16
			plot3(El_Center_x,El_Center_y,El_Center_z,'r.','MarkerSize',13.0)    % MarkerSize 表示点的大小，b.表示绿色的点
			% Elem_Num_Vector
			ts = text(El_Center_x,El_Center_y,El_Center_z,string(Elem_Num_Vector),'Color','b','FontSize',12,'FontName','Consolas','FontAngle','italic');	
		end
		
		%边框
		to_be_plot_count = 0;
		to_be_plot_x = [];to_be_plot_y = [];to_be_plot_z = []; 			
		for i=1:size(Model_Outline,1)
			to_be_plot_count = to_be_plot_count +1;
			to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(Model_Outline(i,1),1),New_Node_Coor(Model_Outline(i,2),1)];
			to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(Model_Outline(i,1),2),New_Node_Coor(Model_Outline(i,2),2)];
			to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(Model_Outline(i,1),3),New_Node_Coor(Model_Outline(i,2),3)];		
		end		
		plot3(to_be_plot_x',to_be_plot_y',to_be_plot_z','LineWidth',Line_width,'Color',[.5 .5 .5])	%灰色			
	end	
	
	
	
    if Key_PLOT(2,9)==3  | Key_PLOT(2,9)==4  | Key_PLOT(2,9)==14 %模型的表面网格	
		to_be_plot_count = 0;
		to_be_plot_x = [];to_be_plot_y = [];to_be_plot_z = []; 		
		for i=1:size(Model_OutArea,1)
			to_be_plot_count = to_be_plot_count +1;
			to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(Model_OutArea(i,1),1) New_Node_Coor(Model_OutArea(i,2),1)];
			to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(Model_OutArea(i,1),2) New_Node_Coor(Model_OutArea(i,2),2)];
			to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(Model_OutArea(i,1),3) New_Node_Coor(Model_OutArea(i,2),3)];				  
		end	
		plot3(to_be_plot_x',to_be_plot_y',to_be_plot_z','LineWidth',Line_width,'Color',[.5 .5 .5])	%灰色	
		
		%边框
		to_be_plot_count = 0;
		to_be_plot_x = [];to_be_plot_y = [];to_be_plot_z = []; 			
		for i=1:size(Model_Outline,1)
			to_be_plot_count = to_be_plot_count +1;
			to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(Model_Outline(i,1),1) New_Node_Coor(Model_Outline(i,2),1)];
			to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(Model_Outline(i,1),2) New_Node_Coor(Model_Outline(i,2),2)];
			to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(Model_Outline(i,1),3) New_Node_Coor(Model_Outline(i,2),3)];		
		end		
		plot3(to_be_plot_x',to_be_plot_y',to_be_plot_z','LineWidth',Line_width,'Color',[.5 .5 .5])	%灰色	
	end		
	
    if Key_PLOT(2,9) ==0 %仅绘制模型边框(Outlines)
		%边框
		to_be_plot_count = 0;
		to_be_plot_x = [];to_be_plot_y = [];to_be_plot_z = []; 			
		for i=1:size(Model_Outline,1)
			to_be_plot_count = to_be_plot_count +1;
			to_be_plot_x(to_be_plot_count,1:2) = [New_Node_Coor(Model_Outline(i,1),1) New_Node_Coor(Model_Outline(i,2),1)];
			to_be_plot_y(to_be_plot_count,1:2) = [New_Node_Coor(Model_Outline(i,1),2) New_Node_Coor(Model_Outline(i,2),2)];
			to_be_plot_z(to_be_plot_count,1:2) = [New_Node_Coor(Model_Outline(i,1),3) New_Node_Coor(Model_Outline(i,2),3)];		
		end		
		plot3(to_be_plot_x',to_be_plot_y',to_be_plot_z','LineWidth',Line_width,'Color',[.5 .5 .5])	%灰色	
	end
    % if Key_PLOT(2,8) ==1 %变形前的网格边界
		% for i=1:size(Model_Outline,1)
			% plot3([Node_Coor(Model_Outline(i,1),1),Node_Coor(Model_Outline(i,2),1)],...
				  % [Node_Coor(Model_Outline(i,1),2),Node_Coor(Model_Outline(i,2),2)],...
				  % [Node_Coor(Model_Outline(i,1),3),Node_Coor(Model_Outline(i,2),3)],'--','LineWidth',Line_width,'Color','black')	    
		% end
	% end	
end

% 999
%============================================  	
%绘制变形前的网格.
%============================================  	
Line_width =0.1;
if Key_PLOT(2,8)==1
    %不允许仅绘制变形前的网格而不绘制变形后的网格(2021-08-02)
	if Key_PLOT(2,9)~=1
		disp(' >> Error :: Key_PLOT(2,8)==1 but Key_PLOT(2,9)~=1, not allow!') 
		Error_Message
	end
	
	c_plot_count = 0;
	Ploted_Ele_lines =[0 0];
	to_be_plot_count = 0;
	to_be_plot_x = [];to_be_plot_y = [];to_be_plot_z = [];  %2021-08-02
	to_be_plot_x_1 = [];to_be_plot_y_1 = [];to_be_plot_z_1 = [];  %2021-08-02
	to_be_plot_x_2 = [];to_be_plot_y_2 = [];to_be_plot_z_2 = [];
	p_1 = [];
	p_2 = [];
	lines =[];
	for iElem = 1:Num_Elem
		NN = [Elem_Node(iElem,1) Elem_Node(iElem,2) Elem_Node(iElem,3) Elem_Node(iElem,4) ...
			  Elem_Node(iElem,5) Elem_Node(iElem,6) Elem_Node(iElem,7) Elem_Node(iElem,8)];                             % Nodes for current element
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
	plot3(to_be_plot_x',to_be_plot_y',to_be_plot_z','LineWidth',Line_width,'Color',[0.5,0.5,0.5])	%灰色			
end

if Key_PLOT(2,8)==2	
	%仅绘制模型边框(Outlines)
	to_be_plot_count = 0;
	to_be_plot_x = [];to_be_plot_y = [];to_be_plot_z = []; 			
	for i=1:size(Model_Outline,1)
		to_be_plot_count = to_be_plot_count +1;
		to_be_plot_x(to_be_plot_count,1:2) = [Node_Coor(Model_Outline(i,1),1) Node_Coor(Model_Outline(i,2),1)];
		to_be_plot_y(to_be_plot_count,1:2) = [Node_Coor(Model_Outline(i,1),2) Node_Coor(Model_Outline(i,2),2)];
		to_be_plot_z(to_be_plot_count,1:2) = [Node_Coor(Model_Outline(i,1),3) Node_Coor(Model_Outline(i,2),3)];		
	end		
	plot3(to_be_plot_x',to_be_plot_y',to_be_plot_z','LineWidth',Line_width,'Color','red')	%红色		
	
end

%============================================  	
%绘制坐标轴.
%============================================  	
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

%============================================  	
%绘制载荷.
%============================================  	
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
	    if FORCE_Matrix(i,1) ~=0  | FORCE_Matrix(i,2) ~=0 | FORCE_Matrix(i,3) ~=0         % If the nodes has force load, then:
			c_force_x   = FORCE_Matrix(i,1);
			c_force_y   = FORCE_Matrix(i,2);
            c_force_z   = FORCE_Matrix(i,3);
			delta_L_x = c_force_x*length_arrow/Max_Force;
			delta_L_y = c_force_y*length_arrow/Max_Force;
			delta_L_z = c_force_z*length_arrow/Max_Force;
			
			% StartPoint = [New_Node_Coor(i,1)-delta_L_x   New_Node_Coor(i,2)-delta_L_y     New_Node_Coor(i,3)-delta_L_z];
			% EndPoint   = [New_Node_Coor(i,1)             New_Node_Coor(i,2)               New_Node_Coor(i,3)          ];
			StartPoint = [New_Node_Coor(i,1)               New_Node_Coor(i,2)               New_Node_Coor(i,3)]; %2021-08-16
			EndPoint   = [New_Node_Coor(i,1)+delta_L_x     New_Node_Coor(i,2)+delta_L_y     New_Node_Coor(i,3)+delta_L_z          ];			
			%plot3([StartPoint(1),EndPoint(1)],[StartPoint(2),EndPoint(2)], [StartPoint(3),EndPoint(3)],'LineWidth',2.0,'Color',[153/255,51/255,250/255]);
			%plot3([StartPoint(1),EndPoint(1)],[StartPoint(2),EndPoint(2)], [StartPoint(3),EndPoint(3)],'LineWidth',1.5,'Color','red');
			h = Tools_mArrow3(StartPoint,EndPoint,'color','red','stemWidth',length_arrow/35.0,'tipWidth',length_arrow/15.0,'facealpha',1.0);	
		end	
	end
end

%============================================  	
%绘制边界条件.
%============================================  	
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

%============================================  	
% Plot nodes.
%============================================  	
if isempty(Post_Enriched_Nodes) ~= 1
    length_min = min(c_X_Length,min(c_Y_Length,c_Z_Length))/5.0; 
	r = length_min/20;
    if Key_PLOT(2,2)==1
		disp(['      ----- Plotting nodes......'])
		for i =1 :size(Post_Enriched_Nodes,2)
			x_node =[];y_node =[];z_node =[];
			count = 0;		
			for j =1:Num_Node
			    count = count +1;
				x_node(count) = New_Node_Coor(j,1);                                          
				y_node(count) = New_Node_Coor(j,2);  
                z_node(count) = New_Node_Coor(j,3);  				
			end
		end
		plot3(x_node,y_node,z_node,'k.','MarkerSize',9.0)    % MarkerSize 表示点的大小,黑色点				
	end
end

%============================================  	
% Plot enriched nodes.
%============================================  	
if isempty(Post_Enriched_Nodes) ~= 1
    length_min = min(c_X_Length,min(c_Y_Length,c_Z_Length))/5.0; 
	r = length_min/10;
    if Key_PLOT(2,14)==1
		disp(['      ----- Plotting enriched nodes......'])
		x_node_tip =[];y_node_tip =[];z_node_tip =[];
		count_tip =0;
		x_node_H=[];y_node_H =[];z_node_H =[];
		count_H =0;		
		x_node_J=[];y_node_J =[];z_node_J =[];
		count_J =0;				
		for i =1 :size(Post_Enriched_Nodes,2)
		    %仅绘制给定的裂缝号. 2022-09-28. IMPROV-2022092801.
		    if Crack_to_Plot >=1 
			    if i~= Crack_to_Plot
				    continue
				end
			end
			
			for j =1:Num_Node
				x_node = New_Node_Coor(j,1);                                          
				y_node = New_Node_Coor(j,2);  
                z_node = New_Node_Coor(j,3);  				
				if Post_Enriched_Nodes(j,i)==1     % Tip nodes
					count_tip = count_tip +1;
					x_node_tip(count_tip) = x_node;
					y_node_tip(count_tip) = y_node;
					z_node_tip(count_tip) = z_node;
				elseif Post_Enriched_Nodes(j,i)==2 % Heaviside nodes
					count_H = count_H +1;
					x_node_H(count_H) = x_node;
					y_node_H(count_H) = y_node;
					z_node_H(count_H) = z_node;
				elseif Post_Enriched_Nodes(j,i)==3 % Junction nodes
					count_J = count_J +1;
					x_node_J(count_J) = x_node;
					y_node_J(count_J) = y_node;
					z_node_J(count_J) = z_node;
				end
			end
		end
		plot3(x_node_tip,y_node_tip,z_node_tip,'r.','MarkerSize',14.0)    % MarkerSize 表示点的大小，r.表示红色的点
		plot3(x_node_H,y_node_H,z_node_H,'b.','MarkerSize',12.0)          % MarkerSize 表示点的大小，b.表示蓝色的点		
		plot3(x_node_J,y_node_J,z_node_J,'go','MarkerSize',10.0,'LineWidth',3.0)  % MarkerSize 表示点的大小，go表示绿色的圆圈	
	end
end

%=========================================================================
%绘制增强节点的位移向量(节点的实际位移，不是增强自由度位移),2020-01-05
%=========================================================================
if Key_PLOT(2,12)==3
	% length of displacement arrow
	length_arrow = (c_X_Length+c_Y_Length+c_Z_Length)/15.0;  
	Max_Value    = max(max(abs(DISP(1:Num_Node,2:4))));
    if isempty(Post_Enriched_Nodes) ~= 1
		disp(['      ----- Plotting real displacement vector of enriched nodes......'])
		for i =1 :size(Post_Enriched_Nodes,2)
		    %仅绘制给定的裂缝号. 2022-09-28. IMPROV-2022092801.
		    if Crack_to_Plot >=1 
			    if i~= Crack_to_Plot
				    continue
				end
			end		
            for j =1:Num_Node
			    if Post_Enriched_Nodes(j,i)~=0     %增强节点
					x_node = New_Node_Coor(j,1);                                          
					y_node = New_Node_Coor(j,2);  
					z_node = New_Node_Coor(j,3);  				
					c_dx   = DISP(j,2);
					c_dy   = DISP(j,3);
					c_dz   = DISP(j,4);
					delta_L_x = c_dx*length_arrow/Max_Value;
					delta_L_y = c_dy*length_arrow/Max_Value;
					delta_L_z = c_dz*length_arrow/Max_Value;
					StartPoint = [x_node,    y_node,     z_node];
					EndPoint   = [x_node+delta_L_x,    y_node+delta_L_y,     z_node+delta_L_z];
					% plot3([StartPoint(1),EndPoint(1)],[StartPoint(2),EndPoint(2)], [StartPoint(3),EndPoint(3)],'LineWidth',1.0,'Color','black');
					h = Tools_mArrow3(StartPoint,EndPoint,'color','black','stemWidth',length_arrow/100.0,'tipWidth',length_arrow/30.0,'facealpha',1.0);
					% h = Tools_mArrow3(StartPoint,EndPoint,'color','black','stemWidth',0.02,'tipWidth',0.08,'facealpha',1.0);
				end
			end		
        end		
	end
end

%=======================================================================
%绘制增强节点的位移向量(增强自由度位移),2022-06-19. NEWFTU-2022061901.
%=======================================================================
if Key_PLOT(2,12)==4
	% length of displacement arrow
	% length_arrow = (c_X_Length+c_Y_Length+c_Z_Length)/15.0;  
	% length_arrow = (c_X_Length+c_Y_Length+c_Z_Length)/3.0;  
	length_arrow = (c_X_Length+c_Y_Length+c_Z_Length)/15.0;  
	% Max_Value    = max(max(abs(DISP_with_XFEM(:))));
	
	% 2023-09-23.
	Max_Value    = -1.0D8;
	if isempty(Post_Enriched_Nodes) ~= 1
		for i =1 :size(Post_Enriched_Nodes,2)
			%仅绘制给定的裂缝号. 2022-09-28. IMPROV-2022092801.
			if Crack_to_Plot >=1 
				if i~= Crack_to_Plot
					continue
				end
			end		
			for j =1:Num_Node
				if Post_Enriched_Nodes(j,i)~=0     %增强节点
					Num_Enri_Node = POS(j,i);
					
					x_node = New_Node_Coor(j,1);                                          
					y_node = New_Node_Coor(j,2);  
					z_node = New_Node_Coor(j,3);  				
					c_dx   = DISP_with_XFEM(Num_Enri_Node*3-2);
					c_dy   = DISP_with_XFEM(Num_Enri_Node*3-1);
					c_dz   = DISP_with_XFEM(Num_Enri_Node*3);
					if(c_dx > Max_Value) 
					    Max_Value=c_dx; 
					end
					if(c_dy > Max_Value) 
						Max_Value=c_dy;
					end
					if(c_dz > Max_Value) 
						Max_Value=c_dz; 
					end
					% delta_L_x = c_dx*length_arrow/Max_Value;
					% delta_L_y = c_dy*length_arrow/Max_Value;
					% delta_L_z = c_dz*length_arrow/Max_Value;
				end
			end		
		end	
    end	
    if isempty(Post_Enriched_Nodes) ~= 1
		disp(['      ----- Plotting XFEM displacement vector of enriched nodes......'])
		for i =1 :size(Post_Enriched_Nodes,2)
		    %仅绘制给定的裂缝号. 2022-09-28. IMPROV-2022092801.
		    if Crack_to_Plot >=1 
			    if i~= Crack_to_Plot
				    continue
				end
			end		
            for j =1:Num_Node
			    if Post_Enriched_Nodes(j,i)~=0     %增强节点
				    Num_Enri_Node = POS(j,i);
					
					x_node = New_Node_Coor(j,1);                                          
					y_node = New_Node_Coor(j,2);  
					z_node = New_Node_Coor(j,3);  				
					c_dx   = DISP_with_XFEM(Num_Enri_Node*3-2);
					c_dy   = DISP_with_XFEM(Num_Enri_Node*3-1);
					c_dz   = DISP_with_XFEM(Num_Enri_Node*3);
					delta_L_x = c_dx*length_arrow/Max_Value;
					delta_L_y = c_dy*length_arrow/Max_Value;
					delta_L_z = c_dz*length_arrow/Max_Value;
					% disp(['x,y,z:',num2str(delta_L_x),' ',num2str(delta_L_y),' ',num2str(delta_L_z)])
					StartPoint = [x_node,    y_node,     z_node];
					EndPoint   = [x_node+delta_L_x,    y_node+delta_L_y,     z_node+delta_L_z];
					% sqrt(delta_L_x^2+delta_L_y^2+delta_L_z^2)
					% plot3([StartPoint(1),EndPoint(1)],[StartPoint(2),EndPoint(2)], [StartPoint(3),EndPoint(3)],'LineWidth',1.0,'Color','black');
					% h = Tools_mArrow3(StartPoint,EndPoint,'color','black','stemWidth',length_arrow/55.0,'tipWidth',length_arrow/25.0,'facealpha',1.0);
					h = Tools_mArrow3(StartPoint,EndPoint,'color','black','stemWidth',length_arrow/100.0,'tipWidth',length_arrow/30.0,'facealpha',1.0);
					% h = Tools_mArrow3(StartPoint,EndPoint,'color','black','stemWidth',0.02,'tipWidth',0.08,'facealpha',1.0);
				end
			end		
        end		
	end
end

%============================================  					
%绘制裂缝面(模型之外的离散裂缝面节点不变形)
%============================================  	
if Key_PLOT(2,5) == 1 | Key_PLOT(2,5) == 3
    disp(['      ----- Plotting crack surface...'])
	if isempty(Crack_Node_in_Ele)
	    disp('             Warnning :: vector Crack_Node_in_Ele is empty, maybe *.cmse_i file is absent!') 
	else
		if isempty(Crack_X)==0
			for i = 1:num_Crack(isub)
				%仅绘制给定的裂缝号. 2022-09-28. IMPROV-2022092801.
				if Crack_to_Plot >=1 
					if i~= Crack_to_Plot
						continue
					end
				end		
			% for i = 2:2
				% nPt = size(Crack_X{i},2);
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
				nnode = size(Crack_node_X{i},2);
				for j=1:nnode
					c_node_x = [Crack_node_X{i}(j)];
					c_node_y = [Crack_node_Y{i}(j)];
					c_node_z = [Crack_node_Z{i}(j)];
					% 获得离散裂缝面节点所在模型单元号
					% i
					% j

					
					c_Ele = Crack_Node_in_Ele{i}(j);
					if c_Ele==0   %离散裂缝的节点在模型外
						plot3(c_node_x,c_node_y,c_node_z,'c.','MarkerSize',16.0);    % MarkerSize 表示点的大小,青色点
						% ts = text(c_node_x,c_node_y,c_node_z,num2str(j),'Color','blue','FontSize',12,'FontName','Consolas','FontAngle','italic');
						Crack_node_X_new{i}(j) = c_node_x;
						Crack_node_Y_new{i}(j) = c_node_y;
						Crack_node_Z_new{i}(j) = c_node_z;
					else          %离散裂缝的节点在模型内
						% Get the local coordinates of the points of the crack. 
						Kesi = Crack_node_local_X{i}(j); 
						Yita = Crack_node_local_Y{i}(j); 
						Zeta = Crack_node_local_Z{i}(j); 
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
						if isnan(dis_x(j)) ==1
							dis_x(j) = 0.0;
							% disp(['            WARNING :: dis_x of node ',num2str(j),' is NAN!']) 
						end
						if isnan(dis_y(j)) ==1
							dis_y(j) = 0.0;
							% disp(['            WARNING :: dis_y of node ',num2str(j),' is NAN!']) 
						end
						if isnan(dis_z(j)) ==1
							dis_z(j) = 0.0;	
							% disp(['            WARNING :: dis_z of node ',num2str(j),' is NAN!']) 						
						end						
						last_c_node_x = c_node_x +	dis_x(j)*scale;	
						last_c_node_y = c_node_y +	dis_y(j)*scale;
						last_c_node_z = c_node_z +	dis_z(j)*scale;	
						Crack_node_X_new{i}(j) = last_c_node_x;
						Crack_node_Y_new{i}(j) = last_c_node_y;
						Crack_node_Z_new{i}(j) = last_c_node_z;					
						%绘制离散裂缝点		
						if Key_PLOT(2,5) == 2					
							plot3(last_c_node_x,last_c_node_y,last_c_node_z,'c.','MarkerSize',16.0);    % MarkerSize 表示点的大小,青色点 
						end
						%显示离散裂缝点编号(测试用)
						% ts = text(c_node_x,c_node_y,c_node_z,num2str(j),'Color','blue','FontSize',17,'FontName','Consolas','FontAngle','italic');
						
						%绘制离散裂缝面边界节点的主应力方向(测试用)
						if Key_PLOT(2,11) == 1 && isempty(Crack3D_Vector_S1_X)==0
							length_arrow = (c_X_Length+c_Y_Length+c_Z_Length)/60.0;  
							StartPoint = [last_c_node_x last_c_node_y last_c_node_z];
							EndPoint   = [last_c_node_x+length_arrow*Crack3D_Vector_S1_X{i}(j) last_c_node_y+length_arrow*Crack3D_Vector_S1_Y{i}(j) last_c_node_z+length_arrow*Crack3D_Vector_S1_Z{i}(j)];
							h = Tools_mArrow3(StartPoint,EndPoint,'color','m','stemWidth',length_arrow/25.0,'tipWidth',length_arrow/10.0,'facealpha',1.0);
							EndPoint   = [last_c_node_x-length_arrow*Crack3D_Vector_S1_X{i}(j) last_c_node_y-length_arrow*Crack3D_Vector_S1_Y{i}(j) last_c_node_z-length_arrow*Crack3D_Vector_S1_Z{i}(j)];	
							h = Tools_mArrow3(StartPoint,EndPoint,'color','m','stemWidth',length_arrow/25.0,'tipWidth',length_arrow/10.0,'facealpha',1.0);		
						end					
					end
				end
				
				%绘制单元面
				nele = size(Crack_Ele_1{i},2);
				c_x =[];c_y =[];c_z =[];
				for j=1:nele
					c_x(j,1:3) = [Crack_node_X_new{i}(Crack_Ele_1{i}(j)),Crack_node_X_new{i}(Crack_Ele_2{i}(j)),Crack_node_X_new{i}(Crack_Ele_3{i}(j))];
					c_y(j,1:3) = [Crack_node_Y_new{i}(Crack_Ele_1{i}(j)),Crack_node_Y_new{i}(Crack_Ele_2{i}(j)),Crack_node_Y_new{i}(Crack_Ele_3{i}(j))];
					c_z(j,1:3) = [Crack_node_Z_new{i}(Crack_Ele_1{i}(j)),Crack_node_Z_new{i}(Crack_Ele_2{i}(j)),Crack_node_Z_new{i}(Crack_Ele_3{i}(j))];					
				end		
				% patch(c_x',c_y',c_z',[1,1,0],'FaceAlpha',0.5,'FaceLighting','gouraud')		
				%NEWFTU-2022053001.  不同裂缝面不同颜色(颜色随机).
				if Key_PLOT(2,5)==1
				    patch(c_x',c_y',c_z',myMap(i,1:3),'FaceAlpha',0.5,'FaceLighting','gouraud','LineWidth',0.2)		
					% patch(c_x',c_y',c_z','green','FaceAlpha',0.2,'FaceLighting','gouraud','LineWidth',0.2)						
				end
				
				% 通过颜色填充裂缝(fill3),且仅绘制裂缝边界线. 2024-02-27. NEWFTU-2024022701.
				if Key_PLOT(2,5) == 3
				    Crack_Fill = fill3(c_x,c_y,c_z,myMap(i,1:3),'FaceAlpha',0.6,'FaceLighting','gouraud');  %2022-07-14. IMPROV-2022071401.
					set(Crack_Fill,{'LineStyle'},{'none'}) %设置颜色和线宽
					% 绘制离散裂缝面边界线.
					c_node_x =[];c_node_y =[];c_node_z =[];     %BUGFIX-2022041901
					if isempty(Crack3D_Meshed_Outline)==0
						for j=1:size(Crack3D_Meshed_Outline{i},2)
							Crack_Node = Crack3D_Meshed_Outline{i}(j);	
							c_node_x(j) = [Crack_node_X_new{i}(Crack_Node)];
							c_node_y(j) = [Crack_node_Y_new{i}(Crack_Node)];
							c_node_z(j) = [Crack_node_Z_new{i}(Crack_Node)];			
						end
						Crack_Node = Crack3D_Meshed_Outline{i}(1);	
						c_node_x(j+1) =  [Crack_node_X_new{i}(Crack_Node)];
						c_node_y(j+1) =  [Crack_node_Y_new{i}(Crack_Node)];
						c_node_z(j+1) =  [Crack_node_Z_new{i}(Crack_Node)];		
						plot3(c_node_x,c_node_y,c_node_z,'LineWidth',0.1,'Color','black')	
					end
				end
				
				%ooooooooooooooooooooooooooooooooooooooooooooo
				%    绘制裂缝面编号，NEWFTU-2022050301.
				%ooooooooooooooooooooooooooo000000000000000000
				%若裂缝数目大于两个就绘制. 在第一个离散单元或流体单元的第一个节点处绘制.
				if num_Crack(isub) >=2  
					crack_num_string = "Crack "+string(i);
					c_crack_x = Crack_node_X_new{i}(Crack_Ele_1{i}(1));
					c_crack_y = Crack_node_Y_new{i}(Crack_Ele_1{i}(1));
					c_crack_z = Crack_node_Z_new{i}(Crack_Ele_1{i}(1));
					ts = text(c_crack_x,c_crack_y,c_crack_z,crack_num_string,'Color','black','FontSize',12,'FontName','Consolas','FontAngle','italic');
				end				
			end	
		end
	end
end		
			
%================================  				
%绘制裂缝体,2021-02-11.
%================================ 	
if Key_PLOT(2,5) == 2
    disp(['      ----- Plotting crack volume...'])
	if isempty(Crack_X)==0
		for i_C = 1:num_Crack(isub)
		    %仅绘制给定的裂缝号. 2022-09-28. IMPROV-2022092801.
		    if Crack_to_Plot >=1 
			    if i_C~= Crack_to_Plot
				    continue
				end
			end		
			if i_C==1
				c_clor = 'green';
			elseif i_C==2
				c_clor = 'red';
			elseif i_C==3
				c_clor = 'blue';
			elseif i_C==4	
				c_clor = 'cyan';
			elseif i_C==5	
				c_clor = 'magenta';
			elseif i_C==6	
				c_clor = 'yellow';
			end	
			if isempty(Crack3D_FluEl_Aperture)==0
				nfluid_Ele = Crack3D_Fluid_Ele_Num{i_C};
				for j=1:nfluid_Ele
					c_fluid_nodes = Crack3D_Fluid_Ele_Nodes(i_C,j,1:3);
					old_coor_x =Crack3D_CalP_X{i_C}(c_fluid_nodes);
					old_coor_y =Crack3D_CalP_Y{i_C}(c_fluid_nodes);
					old_coor_z =Crack3D_CalP_Z{i_C}(c_fluid_nodes);
					Up_dis_V_x  = Cracks_CalP_UpDis_3D_X{i_C}(c_fluid_nodes);
					Up_dis_V_y  = Cracks_CalP_UpDis_3D_Y{i_C}(c_fluid_nodes);
					Up_dis_V_z  = Cracks_CalP_UpDis_3D_Z{i_C}(c_fluid_nodes);
					new_coor_x = old_coor_x + scale*Up_dis_V_x;
					new_coor_y = old_coor_y + scale*Up_dis_V_y;
					new_coor_z = old_coor_z + scale*Up_dis_V_z;
					%填充上表面
                    fill3(new_coor_x,new_coor_y,new_coor_z,c_clor,'FaceAlpha',0.5,'FaceLighting','gouraud')				
					Low_dis_V_x  = Cracks_CalP_LowDis_3D_X{i_C}(c_fluid_nodes);
					Low_dis_V_y  = Cracks_CalP_LowDis_3D_Y{i_C}(c_fluid_nodes);
					Low_dis_V_z  = Cracks_CalP_LowDis_3D_Z{i_C}(c_fluid_nodes);
					new_coor_x = old_coor_x + scale*Low_dis_V_x;
					new_coor_y = old_coor_y + scale*Low_dis_V_y;
					new_coor_z = old_coor_z + scale*Low_dis_V_z;
					%填充下表面
                    fill3(new_coor_x,new_coor_y,new_coor_z,c_clor,'FaceAlpha',0.5,'FaceLighting','gouraud')						
				end
			end
		end	
	end
end

%======================================================  	
%绘制离散裂缝面边界节点的局部坐标系. 即顶点的坐标系.
%======================================================  	
if Key_PLOT(2,10) == 1
    for i = 1:num_Crack(isub)
		%仅绘制给定的裂缝号. 2022-09-28. IMPROV-2022092801.
		if Crack_to_Plot >=1 
			if i~= Crack_to_Plot
				continue
			end
		end	
		c_count = 0;
	    for j=1:size(Crack3D_Meshed_Outline{i},2)
		    Vector_x_x = Crack3D_Vertex_Vector_X_X{i}(j);
			Vector_x_y = Crack3D_Vertex_Vector_X_Y{i}(j);
			Vector_x_z = Crack3D_Vertex_Vector_X_Z{i}(j);
		    Vector_y_x = Crack3D_Vertex_Vector_Y_X{i}(j);
			Vector_y_y = Crack3D_Vertex_Vector_Y_Y{i}(j);
			Vector_y_z = Crack3D_Vertex_Vector_Y_Z{i}(j);
		    Vector_z_x = Crack3D_Vertex_Vector_Z_X{i}(j);
			Vector_z_y = Crack3D_Vertex_Vector_Z_Y{i}(j);
			Vector_z_z = Crack3D_Vertex_Vector_Z_Z{i}(j);	
            Crack_Node = Crack3D_Meshed_Outline{i}(j);	
			c_node_x = [Crack_node_X{i}(Crack_Node)];
			c_node_y = [Crack_node_Y{i}(Crack_Node)];
			c_node_z = [Crack_node_Z{i}(Crack_Node)];			
			% 获得离散裂缝面节点所在模型单元号
			c_Ele = Crack_Node_in_Ele{i}(Crack_Node);
			% 单元号不能为0
			if  c_Ele ~= 0
				% Get the local coordinates of the points of the crack. 
				Kesi = Crack_node_local_X{i}(Crack_Node); 
				Yita = Crack_node_local_Y{i}(Crack_Node); 
				Zeta = Crack_node_local_Z{i}(Crack_Node); 
				NN = [Elem_Node(c_Ele,1) Elem_Node(c_Ele,2) ...
					  Elem_Node(c_Ele,3) Elem_Node(c_Ele,4) ...
					  Elem_Node(c_Ele,5) Elem_Node(c_Ele,6) ...
					  Elem_Node(c_Ele,7) Elem_Node(c_Ele,8)]; 		
				% Calculates N, dNdkesi, J and the determinant of Jacobian matrix.
				[N]  = Cal_N_3D(Kesi,Yita,Zeta);
				c_dis_x =     DISP(NN(1),2)*N(1) + DISP(NN(2),2)*N(2) + DISP(NN(3),2)*N(3) + DISP(NN(4),2)*N(4) ...
							 + DISP(NN(5),2)*N(5) + DISP(NN(6),2)*N(6) + DISP(NN(7),2)*N(7) + DISP(NN(8),2)*N(8); 				
				c_dis_y =     DISP(NN(1),3)*N(1) + DISP(NN(2),3)*N(2) + DISP(NN(3),3)*N(3) + DISP(NN(4),3)*N(4) ...
							 + DISP(NN(5),3)*N(5) + DISP(NN(6),3)*N(6) + DISP(NN(7),3)*N(7) + DISP(NN(8),3)*N(8);	
				c_dis_z =     DISP(NN(1),4)*N(1) + DISP(NN(2),4)*N(2) + DISP(NN(3),4)*N(3) + DISP(NN(4),4)*N(4) ...
							 + DISP(NN(5),4)*N(5) + DISP(NN(6),4)*N(6) + DISP(NN(7),4)*N(7) + DISP(NN(8),4)*N(8); 
				last_c_node_x = c_node_x +	c_dis_x*scale;	
				last_c_node_y = c_node_y +	c_dis_y*scale;
				last_c_node_z = c_node_z +	c_dis_z*scale;	
				
				c_count = c_count +1;

				% 以下以彩色绘制
				length_arrow = (c_X_Length+c_Y_Length+c_Z_Length)/80.0;  

				arrow_x_to_be_plot_x(c_count,1:2) = [last_c_node_x last_c_node_x+length_arrow*Vector_x_x];
				arrow_x_to_be_plot_y(c_count,1:2) = [last_c_node_y last_c_node_y+length_arrow*Vector_x_y];
				arrow_x_to_be_plot_z(c_count,1:2) = [last_c_node_z last_c_node_z+length_arrow*Vector_x_z];		
				last_c_node_x_vector_label_x(c_count) = last_c_node_x+1.1*length_arrow*Vector_x_x;
				last_c_node_y_vector_label_x(c_count) = last_c_node_y+1.1*length_arrow*Vector_x_y;
				last_c_node_z_vector_label_x(c_count) = last_c_node_z+1.1*length_arrow*Vector_x_z;	
				
				arrow_y_to_be_plot_x(c_count,1:2) = [last_c_node_x last_c_node_x+length_arrow*Vector_y_x];
				arrow_y_to_be_plot_y(c_count,1:2) = [last_c_node_y last_c_node_y+length_arrow*Vector_y_y];
				arrow_y_to_be_plot_z(c_count,1:2) = [last_c_node_z last_c_node_z+length_arrow*Vector_y_z];	
				last_c_node_x_vector_label_y(c_count) = last_c_node_x+1.1*length_arrow*Vector_y_x;
				last_c_node_y_vector_label_y(c_count) = last_c_node_y+1.1*length_arrow*Vector_y_y;
				last_c_node_z_vector_label_y(c_count) = last_c_node_z+1.1*length_arrow*Vector_y_z;	
				
				arrow_z_to_be_plot_x(c_count,1:2) = [last_c_node_x last_c_node_x+length_arrow*Vector_z_x];
				arrow_z_to_be_plot_y(c_count,1:2) = [last_c_node_y last_c_node_y+length_arrow*Vector_z_y];
				arrow_z_to_be_plot_z(c_count,1:2) = [last_c_node_z last_c_node_z+length_arrow*Vector_z_z];				
				last_c_node_x_vector_label_z(c_count) = last_c_node_x+1.1*length_arrow*Vector_z_x;
				last_c_node_y_vector_label_z(c_count) = last_c_node_y+1.1*length_arrow*Vector_z_y;
				last_c_node_z_vector_label_z(c_count) = last_c_node_z+1.1*length_arrow*Vector_z_z;	
			end
		end

		plot3(arrow_x_to_be_plot_x',arrow_x_to_be_plot_y',arrow_x_to_be_plot_z','LineWidth',1,'Color','r')		
		plot3(arrow_y_to_be_plot_x',arrow_y_to_be_plot_y',arrow_y_to_be_plot_z','LineWidth',1,'Color','g')	
		plot3(arrow_z_to_be_plot_x',arrow_z_to_be_plot_y',arrow_z_to_be_plot_z','LineWidth',1,'Color','b')		
		ts = text(last_c_node_x_vector_label_x,last_c_node_y_vector_label_x,last_c_node_z_vector_label_x,"x",'Color','r','FontSize',12,'FontName','Consolas','FontAngle','italic');
		ts = text(last_c_node_x_vector_label_y,last_c_node_y_vector_label_y,last_c_node_z_vector_label_y,"y",'Color','g','FontSize',12,'FontName','Consolas','FontAngle','italic');
		ts = text(last_c_node_x_vector_label_z,last_c_node_y_vector_label_z,last_c_node_z_vector_label_z,"z",'Color','b','FontSize',12,'FontName','Consolas','FontAngle','italic');
	end
end	

%================================================================  	
%裂尖增强单元的基准线(baseline)和基准线的局部坐标系,2020-01-05
%================================================================
if Key_PLOT(2,10) == 2 |  Key_PLOT(2,10) == 3
	for iElem = 1:Num_Elem
	    if sum(abs(Tip_Enriched_Ele_BaseLine(iElem,1:6)))>1.0D-10
			Point_A = Tip_Enriched_Ele_BaseLine(iElem,1:3);
			Point_B = Tip_Enriched_Ele_BaseLine(iElem,4:6);
			plot3([Point_A(1),Point_B(1)],[Point_A(2),Point_B(2)],[Point_A(3),Point_B(3)],'LineWidth',1.5,'Color','m')	
			plot3(Point_A(1),Point_A(2),Point_A(3),'g.','MarkerSize',16.0);    % MarkerSize 表示点的大小,青色点 
			plot3(Point_B(1),Point_B(2),Point_B(3),'g.','MarkerSize',16.0);    % MarkerSize 表示点的大小,青色点 
			%基准线AB的中心点
			mid_point_x =  (Point_A(1)+Point_B(1))/2.0;
			mid_point_y =  (Point_A(2)+Point_B(2))/2.0;
			mid_point_z =  (Point_A(3)+Point_B(3))/2.0;
			plot3(mid_point_x,mid_point_y,mid_point_z,'*','MarkerSize',15.0,'Color','m');    % MarkerSize 表示点的大小,青色点
			%绘制基准线的局部坐标系
			Vector_x_x = Tip_Enriched_Ele_BaseLine_Vector_x(iElem,1);
			Vector_x_y = Tip_Enriched_Ele_BaseLine_Vector_x(iElem,2);
			Vector_x_z = Tip_Enriched_Ele_BaseLine_Vector_x(iElem,3);
			Vector_y_x = Tip_Enriched_Ele_BaseLine_Vector_y(iElem,1);
			Vector_y_y = Tip_Enriched_Ele_BaseLine_Vector_y(iElem,2);
			Vector_y_z = Tip_Enriched_Ele_BaseLine_Vector_y(iElem,3);
			Vector_z_x = Tip_Enriched_Ele_BaseLine_Vector_z(iElem,1);
			Vector_z_y = Tip_Enriched_Ele_BaseLine_Vector_z(iElem,2);
			Vector_z_z = Tip_Enriched_Ele_BaseLine_Vector_z(iElem,3);		
			
			if Key_PLOT(2,10) == 3
				length_arrow = (c_X_Length+c_Y_Length+c_Z_Length)/60.0;  %局部坐标系的大小
				StartPoint = [mid_point_x,mid_point_y,mid_point_z];
				EndPoint   = [mid_point_x+length_arrow*Vector_x_x mid_point_y+length_arrow*Vector_x_y mid_point_z+length_arrow*Vector_x_z];
				h = Tools_mArrow3(StartPoint,EndPoint,'color','r','stemWidth',length_arrow/25.0,'tipWidth',length_arrow/10.0,'facealpha',1.0);
				ts = text(mid_point_x+1.1*length_arrow*Vector_x_x,mid_point_y+1.1*length_arrow*Vector_x_y,mid_point_z+1.1*length_arrow*Vector_x_z,  ...
																"x",'Color','red','FontSize',12,'FontName','Consolas','FontAngle','italic');											
				EndPoint   = [mid_point_x+length_arrow*Vector_y_x mid_point_y+length_arrow*Vector_y_y mid_point_z+length_arrow*Vector_y_z];
				h = Tools_mArrow3(StartPoint,EndPoint,'color','g','stemWidth',length_arrow/25.0,'tipWidth',length_arrow/10.0,'facealpha',1.0);
				ts = text(mid_point_x+1.1*length_arrow*Vector_y_x,mid_point_y+1.1*length_arrow*Vector_y_y,mid_point_z+1.1*length_arrow*Vector_y_z,  ...
																"y",'Color','g','FontSize',12,'FontName','Consolas','FontAngle','italic');						
				EndPoint   = [mid_point_x+length_arrow*Vector_z_x mid_point_y+length_arrow*Vector_z_y mid_point_z+length_arrow*Vector_z_z];
				h = Tools_mArrow3(StartPoint,EndPoint,'color','b','stemWidth',length_arrow/25.0,'tipWidth',length_arrow/10.0,'facealpha',1.0);		
				ts = text(mid_point_x+1.1*length_arrow*Vector_z_x,mid_point_y+1.1*length_arrow*Vector_z_y,mid_point_z+1.1*length_arrow*Vector_z_z,  ...
																"z",'Color','b','FontSize',12,'FontName','Consolas','FontAngle','italic');		
			end	
        end		
	end
end	

%============================================  	
%裂尖增强节点对应的单元(参考单元),2020-02-10.
%============================================  	
if Key_PLOT(2,10) == 4 
    if sum(abs(Tip_Enriched_Node_Ref_Element))>1.0D-10
	    for i_Node=1:Num_Node
		    c_Elem  = Tip_Enriched_Node_Ref_Element(i_Node,1);
			c_Crack = Tip_Enriched_Node_Ref_Element(i_Node,2);
			if c_Elem >=1
				NN = [Elem_Node(c_Elem,1) Elem_Node(c_Elem,2) ...
					  Elem_Node(c_Elem,3) Elem_Node(c_Elem,4) ...
					  Elem_Node(c_Elem,5) Elem_Node(c_Elem,6) ...
					  Elem_Node(c_Elem,7) Elem_Node(c_Elem,8)];                             % Nodes for current element
				%b(bule) c(cyan) g(green) k(key) m(magenta) r(red) w(white) y(yellow)
				if c_Crack==1
				    c_clor = 'red';
				elseif c_Crack==2
				    c_clor = 'black';
				elseif c_Crack==3
				    c_clor = 'green';
                elseif c_Crack==4	
				    c_clor = 'cyan';
                elseif c_Crack==5	
				    c_clor = 'magenta';
                elseif c_Crack==6	
				    c_clor = 'yellow';
                end				
				for i=1:3
					plot3([Node_Coor(NN(i),1),Node_Coor(NN(i+1),1)],[Node_Coor(NN(i),2),Node_Coor(NN(i+1),2)],[Node_Coor(NN(i),3),Node_Coor(NN(i+1),3)],'LineWidth',Line_width,'Color',c_clor)	
				end
				for i=5:7
					plot3([Node_Coor(NN(i),1),Node_Coor(NN(i+1),1)],[Node_Coor(NN(i),2),Node_Coor(NN(i+1),2)],[Node_Coor(NN(i),3),Node_Coor(NN(i+1),3)],'LineWidth',Line_width,'Color',c_clor)	
				end
				for i=1:4
					plot3([Node_Coor(NN(i),1),Node_Coor(NN(i+4),1)],[Node_Coor(NN(i),2),Node_Coor(NN(i+4),2)],[Node_Coor(NN(i),3),Node_Coor(NN(i+4),3)],'LineWidth',Line_width,'Color',c_clor)	
				end	
				plot3([Node_Coor(NN(1),1),Node_Coor(NN(4),1)],[Node_Coor(NN(1),2),Node_Coor(NN(4),2)],[Node_Coor(NN(1),3),Node_Coor(NN(4),3)],'LineWidth',Line_width,'Color',c_clor)		
				plot3([Node_Coor(NN(5),1),Node_Coor(NN(8),1)],[Node_Coor(NN(5),2),Node_Coor(NN(8),2)],[Node_Coor(NN(5),3),Node_Coor(NN(8),3)],'LineWidth',Line_width,'Color',c_clor)
			end
		end
	end
end					

%============================================  	
%绘制裂缝边界离散点及编号.
%============================================  	
if (Key_PLOT(2,10) == 5 | Key_PLOT(2,10) == 1) & num_Crack(isub)>0
    text_dis_x = (c_X_Length+c_Y_Length+c_Z_Length)/1000.0;  %编号文字与点的间距.
	% text_dis_x = 0;
	if isempty(Crack_Node_in_Ele)
	    disp('             Warnning :: vector Crack_Node_in_Ele is empty, maybe *.cmse_i file is absent!') 
	else
		for i = 1:num_Crack(isub)
			last_c_node_x =[];last_c_node_y =[];last_c_node_z =[];
			c_count =0;
			for j=1:size(Crack3D_Meshed_Outline{i},2)
				Crack_Node = Crack3D_Meshed_Outline{i}(j);	
				c_node_x = [Crack_node_X{i}(Crack_Node)];
				c_node_y = [Crack_node_Y{i}(Crack_Node)];
				c_node_z = [Crack_node_Z{i}(Crack_Node)];			
				% 获得离散裂缝面节点所在模型单元号
				c_Ele = Crack_Node_in_Ele{i}(Crack_Node);
				% 单元号不能为0
				if  c_Ele ~= 0
					c_count = c_count +1;
					% Get the local coordinates of the points of the crack. 
					Kesi = Crack_node_local_X{i}(Crack_Node); 
					Yita = Crack_node_local_Y{i}(Crack_Node); 
					Zeta = Crack_node_local_Z{i}(Crack_Node); 
					NN = [Elem_Node(c_Ele,1) Elem_Node(c_Ele,2) ...
						  Elem_Node(c_Ele,3) Elem_Node(c_Ele,4) ...
						  Elem_Node(c_Ele,5) Elem_Node(c_Ele,6) ...
						  Elem_Node(c_Ele,7) Elem_Node(c_Ele,8)]; 		
					% Calculates N, dNdkesi, J and the determinant of Jacobian matrix.
					[N]  = Cal_N_3D(Kesi,Yita,Zeta);
					c_dis_x =     DISP(NN(1),2)*N(1) + DISP(NN(2),2)*N(2) + DISP(NN(3),2)*N(3) + DISP(NN(4),2)*N(4) ...
								 + DISP(NN(5),2)*N(5) + DISP(NN(6),2)*N(6) + DISP(NN(7),2)*N(7) + DISP(NN(8),2)*N(8); 				
					c_dis_y =     DISP(NN(1),3)*N(1) + DISP(NN(2),3)*N(2) + DISP(NN(3),3)*N(3) + DISP(NN(4),3)*N(4) ...
								 + DISP(NN(5),3)*N(5) + DISP(NN(6),3)*N(6) + DISP(NN(7),3)*N(7) + DISP(NN(8),3)*N(8);	
					c_dis_z =     DISP(NN(1),4)*N(1) + DISP(NN(2),4)*N(2) + DISP(NN(3),4)*N(3) + DISP(NN(4),4)*N(4) ...
								 + DISP(NN(5),4)*N(5) + DISP(NN(6),4)*N(6) + DISP(NN(7),4)*N(7) + DISP(NN(8),4)*N(8); 
					last_c_node_x(c_count) = c_node_x +	c_dis_x*scale;	
					last_c_node_y(c_count) = c_node_y +	c_dis_y*scale;
					last_c_node_z(c_count) = c_node_z +	c_dis_z*scale;	
				
				end
			end
			
			plot3(last_c_node_x,last_c_node_y,last_c_node_z,'.','MarkerSize',13.0,'Color',[160/255,32/255,240/255])   %紫色
			tem_string = 1:1:c_count;
			ts = text(last_c_node_x+text_dis_x,last_c_node_y,last_c_node_z,string(tem_string),'Color','black','FontSize',13,'FontName','Consolas','FontAngle','italic');		
		end
	end
end	

%============================================  	
%绘制破裂区. 2022-07-24. NEWFTU-2022072401.
%============================================  	
if Key_PLOT(2,15)==1 
	%如果定义了破裂区
	if Yes_has_FZ ==1
	    disp(['      ----- Plotting fracture zone......'])  
		FZ_Points(1,1:3) =[frac_zone_min_x,frac_zone_min_y,frac_zone_min_z];
		FZ_Points(2,1:3) =[frac_zone_max_x,frac_zone_min_y,frac_zone_min_z];
		FZ_Points(3,1:3) =[frac_zone_max_x,frac_zone_max_y,frac_zone_min_z];
		FZ_Points(4,1:3) =[frac_zone_min_x,frac_zone_max_y,frac_zone_min_z];
		FZ_Points(5,1:3) =[frac_zone_min_x,frac_zone_min_y,frac_zone_max_z];
		FZ_Points(6,1:3) =[frac_zone_max_x,frac_zone_min_y,frac_zone_max_z];
		FZ_Points(7,1:3) =[frac_zone_max_x,frac_zone_max_y,frac_zone_max_z];
		FZ_Points(8,1:3) =[frac_zone_min_x,frac_zone_max_y,frac_zone_max_z];
		FZ_Outlines(1,1:2)= [1,2];
		FZ_Outlines(2,1:2)= [2,3];
		FZ_Outlines(3,1:2)= [3,4];
		FZ_Outlines(4,1:2)= [4,1];
		FZ_Outlines(5,1:2)= [5,6];
		FZ_Outlines(6,1:2)= [6,7];
		FZ_Outlines(7,1:2)= [7,8];
		FZ_Outlines(8,1:2)= [8,5];
		FZ_Outlines(9,1:2) = [1,5];
		FZ_Outlines(10,1:2)= [2,6];
		FZ_Outlines(11,1:2)= [3,7];
		FZ_Outlines(12,1:2)= [4,8];		
		
		to_be_plot_count = 0;
		to_be_plot_x = [];to_be_plot_y = [];to_be_plot_z = []; 			
		for i=1:size(FZ_Outlines,1)
			to_be_plot_count = to_be_plot_count +1;
			to_be_plot_x(to_be_plot_count,1:2) = [FZ_Points(FZ_Outlines(i,1),1) FZ_Points(FZ_Outlines(i,2),1)];
			to_be_plot_y(to_be_plot_count,1:2) = [FZ_Points(FZ_Outlines(i,1),2) FZ_Points(FZ_Outlines(i,2),2)];
			to_be_plot_z(to_be_plot_count,1:2) = [FZ_Points(FZ_Outlines(i,1),3) FZ_Points(FZ_Outlines(i,2),3)];		
		end		
		plot3(to_be_plot_x',to_be_plot_y',to_be_plot_z','LineWidth',0.1,'Color',[0,255/255,128/255])	%绿色
	end
end

%============================================  	
% 绘制井筒, Plot wellbore, NEWFTU-2022041901.
%============================================  	
if (RESECH_CODE == 2023022301)   %2024-02-23.
	Wellbore_1(1:2,1) = [0.25,0.25];
	Wellbore_1(1:2,2) = [0.25,0.25];
	Wellbore_1(1:2,3) = [0.499,0.25];
end
		
if num_Wellbore >=1 
    disp(['      ----- Plotting wellbore......'])
	plot3(Wellbore_1(1:num_Points_WB_1,1),Wellbore_1(1:num_Points_WB_1,2),Wellbore_1(1:num_Points_WB_1,3),'LineWidth',2,'Color','blue')	
	% Wellbore_1(1:num_Points_WB_1,1)
	% Wellbore_1(1:num_Points_WB_1,2)
	% Wellbore_1(1:num_Points_WB_1,3)
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

%============================================  	
%绘制井筒分段点. NEWFTU-2022060701.
%============================================  	
if isempty(Frac_Stage_Points) ==0
    length_min = min(c_X_Length,min(c_Y_Length,c_Z_Length))/5.0; 
	%绘制透明圆球
	for i_Ball = 1:size(Frac_Stage_Points,1)
		r_ball = length_min/10;
		x_cor = Frac_Stage_Points(i_Ball,1);
		y_cor = Frac_Stage_Points(i_Ball,2);
		z_cor = Frac_Stage_Points(i_Ball,3);
		[x_ball,y_ball,z_ball]=sphere(30);	
		if RESECH_CODE ~= 2023022301 %2024-02-23.
			surf(r_ball*x_ball +x_cor,r_ball*y_ball +y_cor,r_ball*z_ball +z_cor,'FaceColor',[218/255,112/255,214/255],'LineStyle','none','FaceAlpha',0.5); %淡紫色
		end
	end
end

%============================================  	  
%  绘制给定的单元及其节点号. 2022-07-31.
%============================================
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
if (Key_PLOT(2,12)==5)
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
				  [Crack3D_NF_nfcz{i_NF}(i_side),Crack3D_NF_nfcz{i_NF}(i_side+1)],'LineWidth',0.5,'Color',[128/255, 138/255, 135/255])	%灰色
		end	
		plot3([Crack3D_NF_nfcx{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcx{i_NF}(1)], ...
			  [Crack3D_NF_nfcy{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcy{i_NF}(1)], ...
			  [Crack3D_NF_nfcz{i_NF}(size(Crack3D_NF_nfcx{i_NF},2)),Crack3D_NF_nfcz{i_NF}(1)],'LineWidth',0.5,'Color',[128/255, 138/255, 135/255])	%灰色
		%绘制天然裂缝编号.
		% ts = text(c_Center_x,c_Center_y,c_Center_z,string(i_NF),'Color','black','FontSize',8,'FontName','Consolas','FontAngle','italic');		
	end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         FOR TEST ONLY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot3(4.5161290000000003 ,       2.1962002123847628     ,   1.5000000001447558,'.','MarkerSize',13.0,'Color',[0/255,255/255,255/255])   %青色
% plot3(4.4208171988122480  ,      2.2580645000000001    ,    1.5000000000489881,'.','MarkerSize',13.0,'Color',[0/255,255/255,255/255])   %青色
% plot3(15.7749478669164,5.54931628403107,15.9996344796618,'.','MarkerSize',13.0,'Color',[0/255,255/255,255/255])   %青色


% plot3( 8.5000000000000000      ,   11.999900000000000      ,   8.5000000000000000,'.','MarkerSize',25.0,'Color','red')  
% plot3(  7.4683568895618357      ,   11.844504820251492      ,   8.5000000000000000    ,'.','MarkerSize',25.0,'Color','red')  
% plot3( 6.5283797967773225      ,   11.391835710105983      ,   8.5000000000000000       ,'.','MarkerSize',25.0,'Color','red')  
% plot3(  5.7635898113618955      ,   10.682214306505568      ,   8.5000000000000000       ,'.','MarkerSize',25.0,'Color','red')  
% plot3(  5.2419418797452852      ,   9.7786935852823831      ,   8.5000000000000000   ,'.','MarkerSize',25.0,'Color','red')  


% plot3( 8.5000000000000000      ,   11.799900000000001      ,   8.5000000000000000,'.','MarkerSize',25.0,'Color','blue')  
% plot3( 7.5272988673751415      ,   11.653387465593534      ,   8.5000000000000000       ,'.','MarkerSize',25.0,'Color','blue')  
% plot3( 6.6410438083900472      ,   11.226587955242785      ,   8.5000000000000000      ,'.','MarkerSize',25.0,'Color','blue')  
% plot3(  5.9199561078555014      ,   10.557516346133822      ,   8.5000000000000000     ,'.','MarkerSize',25.0,'Color','blue')  
% plot3( 5.4281166294741263      ,   9.7056253804091046      ,   8.5000000000000000  ,'.','MarkerSize',25.0,'Color','blue')  

% plot3(6.5707106782011158    ,    6.5441726103784257     ,   10.944684237026967 ,'.','MarkerSize',25.0,'Color','blue')  
% plot3(11.579703363752619     ,   6.4361464615415533     ,   9.4062206305374279,'.','MarkerSize',25.0,'Color','red')  

% plot3( -508.62068999999997    ,   -8.6206895000000188    ,   -462.06896595812674,'.','MarkerSize',25.0,'Color','blue')  

% plot3(11.600256295982739     ,   6.3952456892473304    ,    9.3989015295630036,'.','MarkerSize',25.0,'Color','blue')  

% plot3( 2405.0000000000000  ,  1000.0000000000000 ,277.0000000000,'.','MarkerSize',25.0,'Color','blue')  

% Active Figure control widget (2021-08-01)
% Ref: https://ww2.mathworks.cn/matlabcentral/fileexchange/38019-figure-control-widget
% Press q to exit.
% Press r (or double-click) to reset to the initial.

% plot3(93.393448135230727,116.74739295112963,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(92.453075778975460,122.98635588326867,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(89.715514920819089,128.67095957964929,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(85.424009856596754,133.29610205537566,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(79.959879644224387,136.45081910437602,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(73.808636232011736,137.85480027259896,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(67.516844591421005,137.38329567197798,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(61.643558020791509,135.07820055544215,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(56.710643806417274,131.14433273983894,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(53.156413023982921,125.93123364407928,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(51.296674675992605,119.90211000012998,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(51.296674675992605,113.59267590212927,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(53.156413023982914,107.56355225817998,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(56.710643806417281,102.35045316242031,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(61.643558020791524,98.416585346817101,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(67.516844591421005,96.111490230281277,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(73.808636232011736,95.639985629660302,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(79.959879644224387,97.043966797883229,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(85.424009856596754,100.19868384688360,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(89.715514920819089,104.82382632260995,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  
% plot3(92.453075778975460,110.50843001899058,173.43338884387248,'.','MarkerSize',25.0,'Color','blue')  

if Key_Figure_Control_Widget==1
    fcw(gca);
end

% Save pictures.
Save_Picture(c_figure,Full_Pathname,'defm')
