function [score] = pingpong_GA_NN(neural_network, iter_num, chromosome_id)
global Vx Vy w Step count h D ball_center_x ball_center_y patch_center_x patch_center_y
global Vx_ori Vy_ori nn
% close all;clc
nn = neural_network;
% Vx=.001;Vy=.002;w=600;Step=0.001;count=0;D=1;
Vx_ori = 0.001; Vy_ori = 0.002;
Vx=Vx_ori;Vy = Vy_ori;w=600;Step=0.001;count=0;D=1;
s=get(0,'screensize');
h.f=figure('menubar','none','numbertitle','off','name','PingPong','position',[s(3)/2-300,s(4)/2-300,w,w]);
h.a=axes('xlim',[0 1],'ylim',[0 1],'xtick',[],'ytick',[],'box','on','position',[0 0 1 1]);axis square

% The patch
h.p=patch([.99 .96 .96 .99],[.3 .3 .4 .4],[1 0 0 ]); 
patch_center_x = 0.975;
patch_center_y = 0.35;
h.p1 = patch([patch_center_x patch_center_x + 0.01], [patch_center_y patch_center_y + 0.01], [0 0 1]);

% The ball
h.b=patch(.5+.02*sin([0:.01:1]*2*pi),.5+.02*cos([0:.01:1]*2*pi),[0 0 1]); 
ball_center_x = 0.5;
ball_center_y = 0.5002;
h.b1 = patch([ball_center_x ball_center_x + 0.01], [ball_center_y ball_center_y + 0.01], [0 0 1]);


h.timer=timer('TimerFcn',@Beat,'ExecutionMode','fixedDelay','Period',.001);
% h.timer=timer('TimerFcn',@Beat,'period', 5, 'ExecutionMode','fixedRate','taskstoexecute',10);
% h.t=text(0.01,.97,'hi','color',[.5 .8 0],'fontweight','bold','fontsize',20);
h.t=text(0.01,.97, sprintf('Iteration %d chromosome number %d', ...
    iter_num, chromosome_id),'color',[.5 .8 0],'fontweight','bold','fontsize',20);
set(h.f,'keypressFcn',{@Down,h});
start(h.timer);
fprintf('The game has ended. Score: %d \n', count);
score = count;
close all
%--------------------------------------------------------------------------
function Down(~,evnt,h)
global Step D patch_center_y patch_center_x ball_center_x ball_center_y nn
% if strcmpi(evnt.Key,'downarrow')
%     if D
%         % Moving up, now turning down
%         Step=-0.001;
%         D=~D;
%         disp('');
%     else
%         % Go down even more quickly
%         Step=Step-0.0005;
%         disp('');
%     end
% elseif strcmpi(evnt.Key,'uparrow')
%     if D
%         % Go up even more quickly
%         Step=Step+0.0005;
%         disp('');
%     else
%         % Moving down, now turning up
%         Step=0.001;
%         D=~D;
%         disp('');
%     end
% else
%     return;
% end
strcmpi(evnt.Key,'downarrow')

fprintf('%d %d\n',ball_center_x-patch_center_x, ball_center_y-patch_center_y);
nn_output = neural_network_decision(nn, [(ball_center_x-patch_center_x); (ball_center_y-patch_center_y)]);
decision = logsig(nn_output);
if decision >= 0.5
    decision = 'uparrow';
else
    decision = 'downarrow';
end
if strcmpi(decision,'downarrow')
    if D
        % Moving up, now turning down
        Step=-0.001;
        D=~D;
        disp('');
    else
        % Go down even more quickly
        Step=Step-0.0005;
        disp('');
    end
elseif strcmpi(decision,'uparrow')
    if D
        % Go up even more quickly
        Step=Step+0.0005;
        disp('');
    else
        % Moving down, now turning up
        Step=0.001;
        D=~D;
        disp('');
    end
else
    return;
end

set(h.p,'ydata',get(h.p,'ydata')+Step);
patch_center_y = patch_center_y + Step;
while 1
    drawnow;
    break;
end
%--------------------------------------------------------------------------

function Beat(varargin)
global Vx Vy w Step count h D ball_center_x ball_center_y patch_center_y
global Vx_ori Vy_ori nn patch_center_x
Bx=unique(get(h.b,'xdata'));
Bx=Bx([1,end]);
By=unique(get(h.b,'ydata'));
By=By([1,end]);
Rx=unique(get(h.p,'xdata'));
Rx=Rx([1,end]);
Ry=unique(get(h.p,'ydata'));
Ry=Ry([1,end]);

if (Bx(2)>=Rx(1) && By(2)>=Ry(1) && By(1)<=Ry(2))
    % Collision
    % Vx=-0.001;
    Vx = -Vx_ori;
    Vy=Vy+Step;
    count=count+1;
    set(h.t,'string',num2str(count));drawnow
end
if By(1)<=0
    % Ball touches the bottom
    % Vy=0.001;
    Vy = Vy_ori;
    D=~D;
elseif By(2)>=1
    % Ball touches the top 
    % Vy=-0.001;
    Vy = -Vy_ori;
    D=~D;
end
if Bx(1)<=0
    % Ball touches the left side
    % Vx=0.001;
    Vx = Vx_ori;
elseif Bx(2)>=1
    % Ball touches the right side. The end
    set(h.t,'string','Game Over !');drawnow
    stop(h.timer);
end
Py=unique(get(h.p,'ydata'));Py=Py([1,end]);
if Py(1)<=0
    Step=0.001;
elseif Py(2)>=1
    Step=-0.001;
end

set(h.b,'xdata',get(h.b,'xdata')+Vx);
set(h.b,'ydata',get(h.b,'ydata')+Vy);
ball_center_x = ball_center_x + Vx;
ball_center_y = ball_center_y + Vy;

set(h.p,'ydata',get(h.p,'ydata')+Step);
patch_center_y = patch_center_y + Step;
while 1
    drawnow;
    break;
end
nn_output = neural_network_decision(nn, [(ball_center_x-patch_center_x); (ball_center_y-patch_center_y)]);
decision = logsig(nn_output);
if decision >= 0.5
    decision = 'uparrow';
else
    decision = 'downarrow';
end
if strcmpi(decision,'downarrow')
    if D
        % Moving up, now turning down
        Step=-0.001;
        D=~D;
        disp('');
    else
        % Go down even more quickly
        Step=Step-0.0005;
        disp('');
    end
elseif strcmpi(decision,'uparrow')
    if D
        % Go up even more quickly
        Step=Step+0.0005;
        disp('');
    else
        % Moving down, now turning up
        Step=0.001;
        D=~D;
        disp('');
    end
else
    return;
end

set(h.p,'ydata',get(h.p,'ydata')+Step);
patch_center_y = patch_center_y + Step;
while 1
    drawnow;
    break;
end
%--------------------------------------------------------------------------