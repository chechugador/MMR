%Intento de simular la pata con Robotics System Toolbox
%% 
% Start with a blank rigid body tree model.
robot = robotics.RigidBodyTree;
%%
% Specify arm lengths for the robot arm.
L1 = 280;
L2 = 280;
%%
% Add |'link1'| body with |'joint1'| joint.
body = robotics.RigidBody('link1');
joint = robotics.Joint('joint1', 'revolute');
setFixedTransform(joint,trvec2tform([0 0 L1+L2-60]));
joint.JointAxis = [0 1 0];
body.Joint = joint;
addVisual(body,'Mesh',"Femur_Invertido.stl");
addBody(robot, body, 'base');
%%
% Add |'link2'| body with |'joint2'| joint.
body = robotics.RigidBody('link2');
joint = robotics.Joint('joint2','revolute');
setFixedTransform(joint, trvec2tform([0,0,-L1]));
joint.JointAxis = [0 1 0];
body.Joint = joint;
%addVisual(body,"Mesh",'Muelle_invertido.stl');
addBody(robot, body, 'link1');
%%
% Add |'tool'| end effector with |'fix1'| fixed joint.
% body = robotics.RigidBody('tool');
% joint = robotics.Joint('fix1','fixed');
% setFixedTransform(joint, trvec2tform([0, 0, -L2]));
% body.Joint = joint;
% addBody(robot, body, 'link2');
%%
% Add |'tool'| end effector with |'fix1'| fixed joint.
body = robotics.RigidBody('tool');
joint = robotics.Joint('joint3','prismatic');
setFixedTransform(joint, trvec2tform([0, 0, 0]));
body.Joint = joint;
addVisual(body,"Mesh",'Muelle_invertido.stl');
addBody(robot, body, 'link2');
%%
config = homeConfiguration(robot);
show(robot);
%figure;
framesPerSecond = 10;
r = robotics.Rate(framesPerSecond);

for i=1:size(alfa,2)
    config(1).JointPosition = alfa(i);
    config(2).JointPosition = beta(i);
    if i > 6
        if i < 12
           % config(3).JointPosition = config(3).JointPosition + 13;
        elseif i < 25
           % config(3).JointPosition = config(3).JointPosition - 8;
        end
    end
    show(robot,config);
    view(2)
    ax = gca;
    ax.Projection = 'orthographic';
    ax.ZLim = [0 700];
    ax.XLim = [-500 500];
    campos([0 5000 300]);
    camtarget([0 0 300]);
    waitfor(r);
end
