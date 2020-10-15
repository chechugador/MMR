%Intento de simular la pata con Robotics System Toolbox
%% 
figure;
% Start with a blank rigid body tree model.
robot = robotics.RigidBodyTree;
%%
% Specify arm lengths for the robot arm.
L1 = Lhk*1000;
L2 = Lkf*1000;
%%
% Add |'link1'| body with |'joint1'| joint.
body = robotics.RigidBody('link1');
joint1 = robotics.Joint('joint1', 'revolute');
setFixedTransform(joint1,trvec2tform([0 0 0]));
joint1.JointAxis = [0 1 0];
body.Joint = joint1;
addVisual(body,'Mesh',"MMR_muelle.stl");
addBody(robot, body, 'base');
%%
% Add |'link2'| body with |'joint2'| joint.
body = robotics.RigidBody('link2');
joint2 = robotics.Joint('joint2','revolute');
setFixedTransform(joint2, trvec2tform([0,0,L1]));
joint2.JointAxis = [0 1 0];
body.Joint = joint2;
addVisual(body,"Mesh",'MMR_femur.stl');
addBody(robot, body, 'link1');
%%
% Add |'tool'| end effector with |'fix1'| fixed joint.
body = robotics.RigidBody('tool');
joint3 = robotics.Joint('joint3','prismatic');
setFixedTransform(joint3, trvec2tform([0, 0, 0]));
body.Joint = joint3;
addBody(robot, body, 'link2');
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
for i=1:min(length(y),length(alfa))
    
    jointStr = strcat('joint1',int2str(i));
    joint_vec = robotics.Joint(strcat('joint1',int2str(i)), 'revolute');
    
    z = -L1 + y(i)*1000;   %Pasamos de metros a milimetros
    xtrans = xM(i)*1000;
    %setFixedTransform(joint_vec,trvec2tform([xtrans 0 z]));
%     if z < -4*Lkf/5*1000
%         z = -4*Lkf/5*1000;
%     end
    setFixedTransform(joint_vec,trvec2tform([0 0 z]));
    
    joint_vec.JointAxis = [0 1 0];
    body = robotics.RigidBody('link1');
    replaceJoint(robot, 'link1', joint_vec);
    config = homeConfiguration(robot);
    
    config(1).JointPosition = alfa(i)-beta(i);
    config(2).JointPosition = beta(i);
    %config(1).JointPosition = pi/6;
    %config(2).JointPosition = pi/6;
    config(3).JointPosition = 0;
    %config(1).JointPosition = 0.3;
    %config(2).JointPosition = 0.3;
    
    %showdetails(robot);
    show(robot,config);
    view(2)
    ax = gca;
    ax.Projection = 'orthographic';
    ax.ZLim = [0 2000];
    ax.XLim = [-1400 1400];
    %ax.XLim = [xtrans-1000 xtrans+1000];
    %campos([xtrans 10000 300]);
    campos([100 15000 1000]);
    %camtarget([xtrans 0 300]);
    camtarget([0 0 1000]);
	waitfor(r);
    
    %return
    
end

%Fase aerial
for i=1:min(length(yair),length(alfaAir_t.Time))
%for i=1:min(length(yair),length(alfaAir))
    
    jointStr = strcat('joint1',int2str(i));
    joint_vec = robotics.Joint(strcat('joint1',int2str(i)), 'revolute');

    z = -L1-L2 + yMair(i)*1000;   %Pasamos de metros a milimetros
    xtrans = 0 + xMair(i)*1000;
    setFixedTransform(joint_vec,trvec2tform([xtrans 0 z]));
    %setFixedTransform(joint_vec,trvec2tform([0 0 z]));
    
    joint_vec.JointAxis = [0 1 0];
    body = robotics.RigidBody('link1');
    replaceJoint(robot, 'link1', joint_vec);
    config = homeConfiguration(robot);

    config(1).JointPosition = alfaAir_t.Data(i) - betaAir_t.Data(i);
    %config(1).JointPosition = alfaAir(i) - betaAir(i);
    config(2).JointPosition = betaAir_t.Data(i);
    %config(2).JointPosition = betaAir(i);
    config(3).JointPosition = 0;
    
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
    
    if i > 45
        disp(i);
        return
    end
    
end
