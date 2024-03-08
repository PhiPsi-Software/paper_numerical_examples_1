function [x,y,z] = Cal_Coor_by_KesiYita_3D(kesi,yita,zeta,X_NODES,Y_NODES,Z_NODES)

% 根据局部坐标系坐标计算整体坐标系坐标.
% 2022-07-16.

[N] = Cal_N_3D(kesi,yita,zeta);
      
      
x  = N(1)*X_NODES(1)+N(2)*X_NODES(2)+N(3)*X_NODES(3)+N(4)*X_NODES(4)+N(5)*X_NODES(5)+N(6)*X_NODES(6)+N(7)*X_NODES(7)+N(8)*X_NODES(8);
y  = N(1)*Y_NODES(1)+N(2)*Y_NODES(2)+N(3)*Y_NODES(3)+N(4)*Y_NODES(4)+N(5)*Y_NODES(5)+N(6)*Y_NODES(6)+N(7)*Y_NODES(7)+N(8)*Y_NODES(8);
z  = N(1)*Z_NODES(1)+N(2)*Z_NODES(2)+N(3)*Z_NODES(3)+N(4)*Z_NODES(4)+N(5)*Z_NODES(5)+N(6)*Z_NODES(6)+N(7)*Z_NODES(7)+N(8)*Z_NODES(8);
                             
