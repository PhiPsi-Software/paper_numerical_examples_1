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

function Plot_Element_3D_Slice(isub)
% 绘制单元渗透率等切片. 2022-11-28. NEWFTU-2022112802.

global Node_Coor Elem_Node Key_POST_HF
global Num_Node Num_Elem
global Min_X_Coor Max_X_Coor Min_Y_Coor Max_Y_Coor Min_Z_Coor Max_Z_Coor
global Key_PLOT aveg_area_ele
global Size_Font Elem_Fontcolor Elem_Fontsize Node_Fontcolor Node_Fontsize
global num_Crack num_of_Material
global Color_Crack Width_Crack Full_Pathname
global Elem_Material Num_Step_to_Plot DISP Num_Foc_z
global Num_Foc_x Num_Foc_y Foc_x Foc_y Num_Foc_z Foc_z FORCE_Matrix
global Key_Data_Format
global Crack_node_X Crack_node_Y Crack_node_Z
global Crack_Ele_1 Crack_Ele_2 Crack_Ele_3
global Model_Outline Model_OutArea
global Num_Bou_x Num_Bou_y Num_Bou_z Bou_x Bou_y Bou_z
global Crack_node_local_X Crack_node_local_Y Crack_node_local_Z
global Crack_Node_in_Ele
global Crack3D_Meshed_Outline
global Num_Accuracy_Contour Key_Contour_Metd
global volume_ele max_volume_ele min_volume_ele aveg_volume_ele 
global Num_Contourlevel Key_Flipped_Gray Color_Contourlevel
global Color_Mesh
global Max_Aperture_of_each_Crack
global Title_Font Key_Figure_Control_Widget
global Ele_Permeability_3D
global Key_Axis_NE G_X_NODES G_Y_NODES G_Z_NODES
global Ave_Elem_L
global Max_kxx_of_each_Crack Min_kxx_of_each_Crack 
global Max_kyy_of_each_Crack Min_kyy_of_each_Crack 
global Max_kzz_of_each_Crack Min_kzz_of_each_Crack 
global Max_kxy_of_each_Crack Min_kxy_of_each_Crack 
global Max_kyz_of_each_Crack Min_kyz_of_each_Crack 
global Max_kxz_of_each_Crack Min_kxz_of_each_Crack 

% 用到的外部工具：Tools_plane_line_intersect
% Inputs: 
%       n: normal vector of the Plane 
%       V0: any point that belongs to the Plane 
%       P0: end point 1 of the segment P0P1
%       P1:  end point 2 of the segment P0P1
%
%Outputs:
%      I    is the point of interection 
%     Check is an indicator:
%      0 => disjoint (no intersection)
%      1 => the plane intersects P0P1 in the unique point I
%      2 => the segment lies in the plane
%      3=>the intersection lies outside the segment P0P1
%
% Example:
% Determine the intersection of following the plane x+y+z+3=0 with the segment P0P1:
% The plane is represented by the normal vector n=[1 1 1]
% and an arbitrary point that lies on the plane, ex: V0=[1 1 -5]
% The segment is represented by the following two points
% P0=[-5 1 -1]
%P1=[1 2 3]   
% [I,check]=Tools_plane_line_intersect([1 1 1],[1 1 -5],[-5 1 -1],[1 2 3]);

Slice_Type    = Key_PLOT(7,2);
Location_Plot = Key_PLOT(7,3);

%========================================================================= 
% Get the maximum and minimum value of the new coordinates of all nodes.
%========================================================================= 
Min_X_Coor = min(min(Node_Coor(1:Num_Node,1)));
Max_X_Coor = max(max(Node_Coor(1:Num_Node,1)));
Min_Y_Coor = min(min(Node_Coor(1:Num_Node,2)));
Max_Y_Coor = max(max(Node_Coor(1:Num_Node,2)));
Min_Z_Coor = min(min(Node_Coor(1:Num_Node,3)));
Max_Z_Coor = max(max(Node_Coor(1:Num_Node,3)));

c_X_Length = Max_X_Coor-Min_X_Coor;
c_Y_Length = Max_Y_Coor-Min_Y_Coor;
c_Z_Length = Max_Z_Coor-Min_Z_Coor;


Location_Plot_min = Location_Plot-Ave_Elem_L*0.01;
Location_Plot_max = Location_Plot+Ave_Elem_L*0.01;
% 根据切片类型不同进行设置待绘制的坐标
% if Slice_Type==1   %x轴切片
   % Ploted_Nodes = find(Node_Coor(1:Num_Node,1)==Location_Plot);%根据坐标找到节点号
   % num_of_Ploted_Nodes = size(Ploted_Nodes,1);
   % [row,Ploted_Elements,value] =find(G_X_NODES(1:8,1:Num_Elem)==Location_Plot);
   % num_of_Ploted_Elements = size(Ploted_Elements,1);
% elseif Slice_Type==2   %y轴切片
   % Ploted_Nodes = find(Node_Coor(1:Num_Node,2)==Location_Plot);%根据坐标找到节点号
   % num_of_Ploted_Nodes = size(Ploted_Nodes,1);
   % [row,Ploted_Elements,value] =find(G_Y_NODES(1:8,1:Num_Elem)==Location_Plot);
   % num_of_Ploted_Elements = size(Ploted_Elements,1);
% elseif Slice_Type==3   %z轴切片
   % Ploted_Nodes = find(Node_Coor(1:Num_Node,3)==Location_Plot);%根据坐标找到节点号
   % num_of_Ploted_Nodes = size(Ploted_Nodes,1); 
   % [row,Ploted_Elements,value] =find(G_Z_NODES(1:8,1:Num_Elem)==Location_Plot);
   % num_of_Ploted_Elements = size(Ploted_Elements,1);
% end

% if Slice_Type==1   %x轴切片
   % Ploted_Nodes = find(Node_Coor(1:Num_Node,1)>=Location_Plot_min & Node_Coor(1:Num_Node,1)<=Location_Plot_max);%根据坐标找到节点号
   % num_of_Ploted_Nodes = size(Ploted_Nodes,1);
   % [row,Ploted_Elements,value] =find(G_X_NODES(1:8,1:Num_Elem)>=Location_Plot_min & G_X_NODES(1:8,1:Num_Elem)<=Location_Plot_max);
   % num_of_Ploted_Elements = size(Ploted_Elements,1);
% elseif Slice_Type==2   %y轴切片
   % Ploted_Nodes = find(Node_Coor(1:Num_Node,2)>=Location_Plot_min & Node_Coor(1:Num_Node,2)<=Location_Plot_max);%根据坐标找到节点号
   % num_of_Ploted_Nodes = size(Ploted_Nodes,1);
   % [row,Ploted_Elements,value] =find(G_Y_NODES(1:8,1:Num_Elem)>=Location_Plot_min & G_Y_NODES(1:8,1:Num_Elem)<=Location_Plot_max);
   % num_of_Ploted_Elements = size(Ploted_Elements,1);
% elseif Slice_Type==3   %z轴切片
   % Ploted_Nodes = find((Node_Coor(1:Num_Node,3)>=Location_Plot_min) & (Node_Coor(1:Num_Node,3)<=Location_Plot_max));%根据坐标找到节点号
   % num_of_Ploted_Nodes = size(Ploted_Nodes,1); 
   % [row,Ploted_Elements,value] =find(G_Z_NODES(1:8,1:Num_Elem)>=Location_Plot_min & G_Z_NODES(1:8,1:Num_Elem)<=Location_Plot_max);
   % num_of_Ploted_Elements = size(Ploted_Elements,1);
% end

Ploted_Elements = [];
num_of_Ploted_Elements=0;
if Slice_Type==1   %x轴切片
   for iElem = 1:Num_Elem
	   c_x_min = min(G_X_NODES(1:8,iElem));
	   c_x_max = max(G_X_NODES(1:8,iElem));
	   if (c_x_max>=Location_Plot & c_x_min<=Location_Plot)
		   num_of_Ploted_Elements = num_of_Ploted_Elements +1;
		   Ploted_Elements(num_of_Ploted_Elements) = iElem;
	   end
   end
elseif Slice_Type==2   %y轴切片
   for iElem = 1:Num_Elem
	   c_y_min = min(G_Y_NODES(1:8,iElem));
	   c_y_max = max(G_Y_NODES(1:8,iElem));
	   if (c_y_max>=Location_Plot & c_y_min<=Location_Plot)
		   num_of_Ploted_Elements = num_of_Ploted_Elements +1;
		   Ploted_Elements(num_of_Ploted_Elements) = iElem;
	   end
   end
elseif Slice_Type==3   %z轴切片
   for iElem = 1:Num_Elem
	   c_z_min = min(G_Z_NODES(1:8,iElem));
	   c_z_max = max(G_Z_NODES(1:8,iElem));
	   if (c_z_max>=Location_Plot & c_z_min<=Location_Plot)
		   num_of_Ploted_Elements = num_of_Ploted_Elements +1;
		   Ploted_Elements(num_of_Ploted_Elements) = iElem;
	   end
   end
end


if num_of_Ploted_Elements==0
    disp('    > Cannot find elements to be ploted!') 
	return
else
    % disp(['    > num_of_Ploted_Nodes: ',num2str(num_of_Ploted_Nodes)]) 
	disp(['    > num_of_Ploted_Elements: ',num2str(num_of_Ploted_Elements)]) 
end
 
% [I,check]=Tools_plane_line_intersect([1 1 1],[1 1 -5],[-5 1 -1],[1 2 3]);

%============================================ 
% 绘制切片渗透率云图.
%============================================ 
if Key_PLOT(7,1)==1
    disp('    > Plotting slice of permeability of elements....') 
	%************************
	%  各分量图循化
	%************************
	for i_Plot=1:3
	    disp(['    > Plotting slice ',num2str(i_Plot),'....']) 
		% New figure.
		Tools_New_Figure
		hold on;
		xi =[];yi =[];profile=[];
		% for iElem = 1:Num_Elem
		check_count(1:Num_Elem) = 0;
		for iElem = 1:num_of_Ploted_Elements
		    c_Elem = Ploted_Elements(iElem);
			Edge  = zeros(12,2,3);
			% check_count = 0;
			NN = [Elem_Node(c_Elem,1) Elem_Node(c_Elem,2) ...
				  Elem_Node(c_Elem,3) Elem_Node(c_Elem,4) ...
				  Elem_Node(c_Elem,5) Elem_Node(c_Elem,6) ...
				  Elem_Node(c_Elem,7) Elem_Node(c_Elem,8)];                             % Nodes for current element
		    %单元的12条棱边
			% Edge_1(1,1:3) = Node_Coor(NN(1),1:3);Edge_2(1,1:3) = Node_Coor(NN(2),1:3);
            % Edge_1(2,1:3) = Node_Coor(NN(2),1:3);Edge_2(2,1:3) = Node_Coor(NN(3),1:3);	
			% Edge_1(3,1:3) = Node_Coor(NN(3),1:3);Edge_2(3,1:3) = Node_Coor(NN(4),1:3);	
            % Edge_1(4,1:3) = Node_Coor(NN(4),1:3);Edge_2(4,1:3) = Node_Coor(NN(1),1:3);	
			% Edge_1(5,1:3) = Node_Coor(NN(1),1:3);Edge_2(5,1:3) = Node_Coor(NN(5),1:3);	
            % Edge_1(6,1:3) = Node_Coor(NN(2),1:3);Edge_2(6,1:3) = Node_Coor(NN(6),1:3);	
			% Edge_1(7,1:3) = Node_Coor(NN(3),1:3);Edge_2(7,1:3) = Node_Coor(NN(7),1:3);	
            % Edge_1(8,1:3) = Node_Coor(NN(4),1:3);Edge_2(8,1:3) = Node_Coor(NN(8),1:3);	
			% Edge_1(9,1:3) = Node_Coor(NN(5),1:3);Edge_2(9,1:3) = Node_Coor(NN(6),1:3);	
            % Edge_1(10,1:3) = Node_Coor(NN(6),1:3);Edge_2(10,1:3) = Node_Coor(NN(7),1:3);	
			% Edge_1(11,1:3) = Node_Coor(NN(7),1:3);Edge_2(11,1:3) = Node_Coor(NN(8),1:3);	
            % Edge_1(12,1:3) = Node_Coor(NN(8),1:3);Edge_2(12,1:3) = Node_Coor(NN(5),1:3);	

			Edge_1(1,1:3) = Node_Coor(NN(1),1:3);Edge_2(1,1:3) = Node_Coor(NN(5),1:3);
            Edge_1(2,1:3) = Node_Coor(NN(2),1:3);Edge_2(2,1:3) = Node_Coor(NN(6),1:3);	
			Edge_1(3,1:3) = Node_Coor(NN(3),1:3);Edge_2(3,1:3) = Node_Coor(NN(7),1:3);	
            Edge_1(4,1:3) = Node_Coor(NN(4),1:3);Edge_2(4,1:3) = Node_Coor(NN(8),1:3);	
			
			Edge_1(5,1:3) = Node_Coor(NN(1),1:3);Edge_2(5,1:3) = Node_Coor(NN(2),1:3);	
            Edge_1(6,1:3) = Node_Coor(NN(4),1:3);Edge_2(6,1:3) = Node_Coor(NN(3),1:3);	
			Edge_1(7,1:3) = Node_Coor(NN(5),1:3);Edge_2(7,1:3) = Node_Coor(NN(6),1:3);	
            Edge_1(8,1:3) = Node_Coor(NN(8),1:3);Edge_2(8,1:3) = Node_Coor(NN(7),1:3);	
			
			Edge_1(9,1:3)  = Node_Coor(NN(1),1:3);Edge_2(9,1:3) = Node_Coor(NN(4),1:3);	
            Edge_1(10,1:3) = Node_Coor(NN(2),1:3);Edge_2(10,1:3) = Node_Coor(NN(3),1:3);	
			Edge_1(11,1:3) = Node_Coor(NN(6),1:3);Edge_2(11,1:3) = Node_Coor(NN(7),1:3);	
            Edge_1(12,1:3) = Node_Coor(NN(5),1:3);Edge_2(12,1:3) = Node_Coor(NN(8),1:3);	
			
			for i_Edge=1:12
			    % if check_count>=4 
				    % continue
				% end
				if Slice_Type==1       %x轴切片
				    %计算棱边与切片所在面的交点.
					[c_Inter,check]=Tools_plane_line_intersect([1,0,0],[Location_Plot,0,0],Edge_1(i_Edge,1:3),Edge_2(i_Edge,1:3));
					if check==1 
					    check_count(c_Elem) =  check_count(c_Elem) +1;
						xi(check_count(c_Elem),c_Elem) = c_Inter(2);                                         
						yi(check_count(c_Elem),c_Elem) = c_Inter(3);   
						if i_Plot==1
							profile(check_count(c_Elem),c_Elem) = Ele_Permeability_3D(c_Elem,2) ; %kyy	
                        elseif i_Plot==2
						    profile(check_count(c_Elem),c_Elem) = Ele_Permeability_3D(c_Elem,3) ; %kzz	
                        elseif i_Plot==3
						    profile(check_count(c_Elem),c_Elem) = Ele_Permeability_3D(c_Elem,5) ; %kyz						
                        end	
					end
				elseif Slice_Type==2   %y轴切片
				    %计算棱边与切片所在面的交点.
					[c_Inter,check]=Tools_plane_line_intersect([0,1,0],[0,Location_Plot,0],Edge_1(i_Edge,1:3),Edge_2(i_Edge,1:3));
					if check==1
					    check_count(c_Elem) =  check_count(c_Elem) +1;
						xi(check_count(c_Elem),c_Elem) = c_Inter(1);                                         
						yi(check_count(c_Elem),c_Elem) = c_Inter(3);   
						if i_Plot==1
							profile(check_count(c_Elem),c_Elem) = Ele_Permeability_3D(c_Elem,1) ; %kxx	
                        elseif i_Plot==2
						    profile(check_count(c_Elem),c_Elem) = Ele_Permeability_3D(c_Elem,3) ; %kzz	
                        elseif i_Plot==3
						    profile(check_count(c_Elem),c_Elem) = Ele_Permeability_3D(c_Elem,6) ; %kxz						
                        end
					end
				elseif Slice_Type==3   %z轴切片
				    %计算棱边与切片所在面的交点.
					[c_Inter,check]=Tools_plane_line_intersect([0,0,1],[0,0,Location_Plot],Edge_1(i_Edge,1:3),Edge_2(i_Edge,1:3));
					if check==1
					    check_count(c_Elem) =  check_count(c_Elem) +1;
						xi(check_count(c_Elem),c_Elem) = c_Inter(1);                                         
						yi(check_count(c_Elem),c_Elem) = c_Inter(2);  
                        						
						if i_Plot==1
							profile(check_count(c_Elem),c_Elem) = Ele_Permeability_3D(c_Elem,1) ; %kxx	
                        elseif i_Plot==2
						    profile(check_count(c_Elem),c_Elem) = Ele_Permeability_3D(c_Elem,2) ; %kyy	
                        elseif i_Plot==3
						    profile(check_count(c_Elem),c_Elem) = Ele_Permeability_3D(c_Elem,4) ; %kxy						
                        end
					end
				end 
			end
			
			% 8888
			% check_count
			% c_Elem
			% xi(1:check_count,c_Elem)
			% yi(1:check_count,c_Elem)
			
			%****************************
			%  对交叉点进行顺时针排序.
			%****************************
			if check_count(c_Elem) >=3
			    % check_count
			    % -----------------------------------------
			    % OPTION 1: 需要matlab Mapping Toolbox
				% -----------------------------------------
			    % [xi(1:check_count,c_Elem),yi(1:check_count,c_Elem)] = poly2cw(xi(1:check_count,c_Elem),yi(1:check_count,c_Elem))
				
				% -------------------------------------------------------------------------------------------------
				% OPTION 2: 
				% Ref: https://stackoverflow.com/questions/13935324/sorting-clockwise-polygon-points-in-matlab
				% -------------------------------------------------------------------------------------------------
				cx = mean(xi(1:check_count(c_Elem),c_Elem)); % Step 1: Find the unweighted mean of the vertices
				cy = mean(yi(1:check_count(c_Elem),c_Elem));
				a = atan2(yi(1:check_count(c_Elem),c_Elem) - cy, xi(1:check_count(c_Elem),c_Elem) - cx); % Step 2: Find the angles
				[~, order] = sort(a); % Step 3: Find the correct sorted order
				xi(1:check_count(c_Elem),c_Elem) = xi(order,c_Elem); % Step 4: Reorder the coordinates
				yi(1:check_count(c_Elem),c_Elem) = yi(order,c_Elem);


				% 9999
				% check_count
				% c_Elem
				% xi(1:check_count,c_Elem)
				% yi(1:check_count,c_Elem)
			
			    % if check_count >=5
						
						% c_0 = find(xi(1:check_count,c_Elem)==0.0);
						% num_c_0 = size(c_0,1);
						% if num_c_0>=1
							% 8888
							% check_count
							% c_Elem
							% i_Edge						
						    % xi(1:check_count,c_Elem)
							
							% c_0 = find(yi(1:check_count,c_Elem)==0.0);
							% num_c_0 = size(c_0,1);
							% if num_c_0>=1
								% check_count
								% c_Elem
								% i_Edge
								% yi(1:check_count,c_Elem)
							% end							
						% end
			    % end
			end
		end 
		
		
		%补全. 2022-12-04.
		max_check_count = max(check_count);
		for iElem = 1:num_of_Ploted_Elements
		    c_Elem = Ploted_Elements(iElem);
			c_check_count = check_count(c_Elem);
			if c_check_count<max_check_count
			    xi(c_check_count+1:max_check_count,c_Elem) = xi(c_check_count,c_Elem);
				yi(c_check_count+1:max_check_count,c_Elem) = yi(c_check_count,c_Elem);
				profile(c_check_count+1:max_check_count,c_Elem) = profile(c_check_count,c_Elem);
			end
		end
		
		% Log图. 2022-11-30.
		if Key_PLOT(7,6)==1
		    % 0元素改为1,否则计算log10得到-inf
			profile(profile==0) = 1;
			% profile(profile>=1.0e-10 & profile<=1.0e-10) = 1;
		    profile = sign(profile).*log10(abs(profile));
		end
		
		% if Key_PLOT(7,4)==0
			% patch(xi,yi,profile,'edgecolor','none') 
		% elseif Key_PLOT(7,4)==1
			% patch(xi,yi,profile,'edgecolor','black','LineWidth',0.1) 
		% end

		
		if Key_PLOT(7,4)==0
			patch(xi(1:max_check_count,:),yi(1:max_check_count,:),profile(1:max_check_count,:),'edgecolor','none') 
		elseif Key_PLOT(7,4)==1
			patch(xi(1:max_check_count,:),yi(1:max_check_count,:),profile(1:max_check_count,:),'edgecolor','black','LineWidth',0.1) 
		end
		
		if  Slice_Type==1
			if i_Plot==1
				title(['Permeability kyy of x-axis slice (x= ',num2str(Location_Plot), ' m)'],'FontName',Title_Font,'FontSize',Size_Font) 					
			elseif i_Plot==2
				title(['Permeability kzz of x-axis slice (x= ',num2str(Location_Plot), ' m)'],'FontName',Title_Font,'FontSize',Size_Font) 	
			elseif i_Plot==3
				title(['Permeability kyz of x-axis slice (x= ',num2str(Location_Plot), ' m)'],'FontName',Title_Font,'FontSize',Size_Font) 							
			end				
		elseif  Slice_Type==2
			if i_Plot==1
				title(['Permeability kxx of y-axis slice (y= ',num2str(Location_Plot), ' m)'],'FontName',Title_Font,'FontSize',Size_Font) 					
			elseif i_Plot==2
				title(['Permeability kzz of y-axis slice (y= ',num2str(Location_Plot), ' m)'],'FontName',Title_Font,'FontSize',Size_Font) 	
			elseif i_Plot==3
				title(['Permeability kxz of y-axis slice (y= ',num2str(Location_Plot), ' m)'],'FontName',Title_Font,'FontSize',Size_Font) 							
			end		
		elseif Slice_Type==3 
			if i_Plot==1
				title(['Permeability kxx of z-axis slice (z= ',num2str(Location_Plot), ' m)'],'FontName',Title_Font,'FontSize',Size_Font) 					
			elseif i_Plot==2
				title(['Permeability kyy of z-axis slice (z= ',num2str(Location_Plot), ' m)'],'FontName',Title_Font,'FontSize',Size_Font) 	
			elseif i_Plot==3
				title(['Permeability kxy of z-axis slice (z= ',num2str(Location_Plot), ' m)'],'FontName',Title_Font,'FontSize',Size_Font) 							
			end				
		end	


		%============================================  	
		%绘制坐标轴.
		%============================================  	
		if Key_PLOT(7,5)==1 
			Arrow_length = (c_X_Length+c_Y_Length+c_Z_Length)/15;
			if Slice_Type==1       %x轴切片 
				h = Tools_mArrow3([0 0 0],[Arrow_length 0 0],'color','red','stemWidth',Arrow_length/25.0,'tipWidth',Arrow_length/10.0,'facealpha',1.0);
				ts = text((c_X_Length+c_Y_Length+c_Z_Length)/14, 0, 0,"Y",'Color','red','FontSize',15,'FontName','Consolas','FontAngle','italic');
				h = Tools_mArrow3([0 0 0],[0 Arrow_length 0],'color','green','stemWidth',Arrow_length/25.0,'tipWidth',Arrow_length/10.0,'facealpha',1.0);
				ts = text(0,(c_X_Length+c_Y_Length+c_Z_Length)/14,0,"Z",'Color','green','FontSize',15,'FontName','Consolas','FontAngle','italic');	
			elseif Slice_Type==2   %y轴切片 
				h = Tools_mArrow3([0 0 0],[Arrow_length 0 0],'color','red','stemWidth',Arrow_length/25.0,'tipWidth',Arrow_length/10.0,'facealpha',1.0);
				ts = text((c_X_Length+c_Y_Length+c_Z_Length)/14, 0, 0,"X",'Color','red','FontSize',15,'FontName','Consolas','FontAngle','italic');
				h = Tools_mArrow3([0 0 0],[0 Arrow_length 0],'color','green','stemWidth',Arrow_length/25.0,'tipWidth',Arrow_length/10.0,'facealpha',1.0);
				ts = text(0,(c_X_Length+c_Y_Length+c_Z_Length)/14,0,"Z",'Color','green','FontSize',15,'FontName','Consolas','FontAngle','italic');	
			elseif Slice_Type==3   %z轴切片
				h = Tools_mArrow3([0 0 0],[Arrow_length 0 0],'color','red','stemWidth',Arrow_length/25.0,'tipWidth',Arrow_length/10.0,'facealpha',1.0);
				ts = text((c_X_Length+c_Y_Length+c_Z_Length)/14, 0, 0,"X",'Color','red','FontSize',15,'FontName','Consolas','FontAngle','italic');
				h = Tools_mArrow3([0 0 0],[0 Arrow_length 0],'color','green','stemWidth',Arrow_length/25.0,'tipWidth',Arrow_length/10.0,'facealpha',1.0);
				ts = text(0,(c_X_Length+c_Y_Length+c_Z_Length)/14,0,"Y",'Color','green','FontSize',15,'FontName','Consolas','FontAngle','italic');	
			end 
        end		
		%============================================ 
		% The range of the plot.
		%============================================ 
		min_x = Min_X_Coor; max_x = Max_X_Coor;
		min_y = Min_Y_Coor; max_y = Max_Y_Coor;	
		min_z = Min_Z_Coor; max_z = Max_Z_Coor;

		delta = Ave_Elem_L;
		if Slice_Type==1       %x轴切片
			axis([min_y-delta max_y+delta min_z-delta max_z+delta]);	      
		elseif Slice_Type==2   %y轴切片
			axis([min_x-delta max_x+delta min_z-delta max_z+delta]);	 
		elseif Slice_Type==3   %z轴切片
			axis([min_x-delta max_x+delta min_y-delta max_y+delta]);	
		end     

		axis equal; 
		%colorbar('FontAngle','italic','FontName',Title_Font,'FontSize',Size_Font);
		% colorbar('FontName',Title_Font,'FontSize',Size_Font);
		set(gca,'XTick',[],'YTick',[],'XColor','w','YColor','w')

		%===================================
		% Set colormap.
		%===================================
		if Key_Flipped_Gray==0
			colormap(Color_Contourlevel)
		elseif Key_Flipped_Gray==1
			colormap(flipud(gray))
		end				
							
		%===================================
		% Set colorbar.
		%===================================
		cbar = colorbar;
		brighten(0.5); 
		if Key_PLOT(7,1)==1
			set(get(cbar,'title'),'string','mDarcy');
			% Log图. 2022-11-30.
			if Key_PLOT(7,6)==1
				set(get(cbar,'title'),'string','log(mDarcy)');
			end
		end
		% clim = caxis;
		
		if  Slice_Type==1
			if i_Plot==1
				clim(1)=min(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),2));		
				clim(2)=max(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),2));						
			elseif i_Plot==2
				clim(1)=min(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),3));		
				clim(2)=max(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),3));	
			elseif i_Plot==3
				clim(1)=min(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),5));		
				clim(2)=max(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),5));						
			end				
		elseif  Slice_Type==2
			if i_Plot==1
				clim(1)=min(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),1));		
				clim(2)=max(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),1));						
			elseif i_Plot==2
				clim(1)=min(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),3));		
				clim(2)=max(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),3));	
			elseif i_Plot==3
				clim(1)=min(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),6));		
				clim(2)=max(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),6));						
			end	
		elseif Slice_Type==3 
			if i_Plot==1
				clim(1)=min(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),1));		
				clim(2)=max(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),1));						
			elseif i_Plot==2
				clim(1)=min(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),2));		
				clim(2)=max(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),2));	
			elseif i_Plot==3
				clim(1)=min(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),4));		
				clim(2)=max(Ele_Permeability_3D(Ploted_Elements(1:num_of_Ploted_Elements),4));						
			end			
		end	
		% clim
		% Log图. 2022-11-30.
	    if Key_PLOT(7,6)==1
		    if(clim(1)==0.0)
			    clim(1) = 1.0;
			end
		    if(clim(2)==0.0)
			    clim(2) = 1.0;
			end			
		    % clim = log10(clim);
			clim = sign(clim).*log10(abs(clim));
		end
		% clim
	    % if Key_PLOT(7,6)==0
			if(clim(1)>=clim(2))
				clim(2) = clim(1) +1e-8;
			end
		% elseif Key_PLOT(7,6)==1
			% if(clim(1)==clim(2))
				% clim(2) = clim(1) +0.0001;
			% end
		% end
        % clim

		ylim(cbar,[clim(1) clim(2)]);
		numpts = 10 ;    % Number of points to be displayed on colorbar
		kssv = linspace(clim(1),clim(2),numpts);
		set(cbar,'YtickMode','manual','YTick',kssv); % Set the tickmode to manual
		for i = 1:numpts
			imep = num2str(kssv(i),'%+3.2E');
			vasu(i) = {imep} ;
		end
		set(cbar,'YTickLabel',vasu(1:numpts),'FontName',Title_Font,'FontSize',Size_Font);

		% Active Figure control widget (2021-08-01)
		% Ref: https://ww2.mathworks.cn/matlabcentral/fileexchange/38019-figure-control-widget
		% Press q to exit.
		% Press r (or double-click) to reset to the initial.
		if Key_Figure_Control_Widget==1
			fcw(gca);
		end


		% Save pictures.
		
		if  Slice_Type==1
			if i_Plot==1
                Save_Picture(c_figure,Full_Pathname,'ekyy')					
			elseif i_Plot==2
				Save_Picture(c_figure,Full_Pathname,'ekzz')	
			elseif i_Plot==3
				Save_Picture(c_figure,Full_Pathname,'ekyz')						
			end				
		elseif  Slice_Type==2
			if i_Plot==1
                Save_Picture(c_figure,Full_Pathname,'ekxx')						
			elseif i_Plot==2
                Save_Picture(c_figure,Full_Pathname,'ekzz')	
			elseif i_Plot==3
                Save_Picture(c_figure,Full_Pathname,'ekxz')					
			end	
		elseif Slice_Type==3 
			if i_Plot==1
                Save_Picture(c_figure,Full_Pathname,'ekxx')					
			elseif i_Plot==2
                Save_Picture(c_figure,Full_Pathname,'ekyy')	
			elseif i_Plot==3
                Save_Picture(c_figure,Full_Pathname,'ekxy')						
			end			
		end	
	end
end

