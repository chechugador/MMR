%Intento de simular la pata con Robotics System Toolbox
%% 
figure;
% Start with a blank rigid body tree model.
robot = robotics.RigidBodyTree;
%%
% Specify arm lengths for the robot arm.
L1 = (Lhk + Lkf)*1000;
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
show(robot);
%figure;
%framesPerSecond = size(alfa,2) / tc;
framesPerSecond = 1000;
%framesPerSecond = 3;
r = robotics.Rate(framesPerSecond);
r.OverrunAction = 'slip';

config(1).JointPosition = 0;
z=0;
reset(r)
xtrans = 0;

%Fase ground
for i=1:min(length(ySlip),length(alfa))
    
    jointStr = strcat('joint1',int2str(i));
    joint_vec = robotics.Joint(strcat('joint1',int2str(i)), 'revolute');

    z = -L1 + ySlip(i)*1000;   %Pasamos de metros a milimetros
    xtrans =  xSlip(i)*1000;
    %setFixedTransform(joint_vec,trvec2tform([xtrans 0 z]));
    setFixedTransform(joint_vec,trvec2tform([0 0 z]));
    
    joint_vec.JointAxis = [0 1 0];
    body = robotics.RigidBody('link1');
    replaceJoint(robot, 'link1', joint_vec);
    config = homeConfiguration(robot);
    
    config(1).JointPosition = alfa(i);
    %config(1).JointPosition = pi/6 - i*pi/3/size(alfa,2);
    config(2).JointPosition = 0;
    %config(1).JointPosition = alfa0;
    
    %showdetails(robot);
    show(robot,config);
    view(2)
    ax = gca;
    ax.Projection = 'orthographic';
    ax.ZLim = [0 2000];
    %ax.XLim = [-500 500];
    ax.XLim = [-1400 1400];
    campos([100 15000 1000]);
    camtarget([0 0 1000]);
	waitfor(r);
    
    %return
    
end

%Fase aerial
for i=1:min(length(yairSlip),length(alfaAir.Time))
    
    jointStr = strcat('joint1',int2str(i));
    joint_vec = robotics.Joint(strcat('joint1',int2str(i)), 'revolute');

    z = -L1 + yairSlip(i)*1000;   %Pasamos de metros a milimetros
    xtrans = 0 + xairSlip(i)*1000;
    setFixedTransform(joint_vec,trvec2tform([xtrans 0 z]));
    
    joint_vec.JointAxis = [0 1 0];
    body = robotics.RigidBody('link1');
    replaceJoint(robot, 'link1', joint_vec);
    config = homeConfiguration(robot);
 
    config(1).JointPosition = alfaAir.Data(i);
    %config(1).JointPosition = pi/6 - i*pi/3/size(alfa,2);
    config(2).JointPosition = 0;
    %config(1).JointPosition = alfa0;
    
    %showdetails(robot);
    show(robot,config);
    view(2)
    ax = gca;
    ax.Projection = 'orthographic';
    ax.ZLim = [0 2000];
    %ax.XLim = [-500 500];
    ax.XLim = [xtrans-1400 xtrans+1400];
    campos([xtrans+100 15000 1000]);
    camtarget([xtrans 0 1000]);
	waitfor(r);
    
end

    
    