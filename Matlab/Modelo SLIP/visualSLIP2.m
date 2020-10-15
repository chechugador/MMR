%Intento de simular la pata con Robotics System Toolbox
%% 
figure;
% Start with a blank rigid body tree model.
robot = robotics.RigidBodyTree;
%%
% Specify arm lengths for the robot arm.
L1 = 280 * 2;
%%
% Add |'link1'| body with |'joint1'| joint.
body = robotics.RigidBody('link1');
joint1 = robotics.Joint('joint1', 'revolute');
setFixedTransform(joint1,trvec2tform([0 0 0]));
joint1.JointAxis = [0 1 0];
body.Joint = joint1;
addVisual(body,'Mesh',"SLIP.stl");
addBody(robot, body, 'base');
%%
% Add |'link2'| body with |'joint2'| joint.
body = robotics.RigidBody('link2');
joint2 = robotics.Joint('joint2','revolute');
setFixedTransform(joint2, trvec2tform([0,0,-L1]));
joint2.JointAxis = [0 1 0];
body.Joint = joint2;
%addVisual(body,"Mesh",'SLIP.stl');
addBody(robot, body, 'link1');
%%
%Animacion de la pata
config = homeConfiguration(robot);
config(1).JointPosition = pi/6;
show(robot,config);
view(2)
ax = gca;
ax.Projection = 'orthographic';
ax.ZLim = [0 1500];
%ax.XLim = [-500 500];
ax.XLim = [-1000 1000];
campos([0 10000 300]);
camtarget([0 0 300]);
%Fase ground
