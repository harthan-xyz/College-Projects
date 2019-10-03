%clear all
%close all

To = 5;
%--------------------------------
% Segment 1 
%--------------------------------
t1=0:1/100:3;
y11=3*sin(2*pi*(1/6)*t1);
y12=0.5*sin(2*pi*8*t1);
y13 = y11+y12;
h=plot(t1,y13,'g'); hold on
set(h,'LineWidth',3.0)
h=plot(t1-To,y13,'g'); hold on
set(h,'LineWidth',3.0)
h=plot(t1+To,y13,'g'); hold on
set(h,'LineWidth',3.0)
plot(t1,y11,'g:')
plot(t1-To,y11,'g:')
plot(t1+To,y11,'g:')

%--------------------------------
% Segment 2
%--------------------------------
t2 = 3:1/100:4;
a = log(1)-log(4);
b = log(4) - 3*a;
y2 = exp(a*t2+b);
h=plot(t2,y2,'g');
set(h,'LineWidth',3.0)
h=plot(t2-To,y2,'g');
set(h,'LineWidth',3.0)
h=plot(t2+To,y2,'g');
set(h,'LineWidth',3.0)

%--------------------------------
% Segment 3
%--------------------------------
t4 = 4:1/100:5;
y4 = ones(size(t4))*3;
h=plot(t4,y4,'g');
set(h,'LineWidth',3.0)
h=plot(t4-To,y4,'g');
set(h,'LineWidth',3.0)
h=plot(t4+To,y4,'g');
set(h,'LineWidth',3.0)

%--------------------------------
% Dotted Lines
%--------------------------------
for kv=-1:1
    offset = kv*To;
    plot([0 5]+offset,[-1 -1],'g:')
    plot([0 5]+offset,[0 0],'g:')
    plot([0 5]+offset,[1 1],'g:')
    plot([0 5]+offset,[2 2],'g:')
    plot([0 5]+offset,[3 3],'g:')
    plot([0 5]+offset,[4 4],'g:')
    plot([1 1]+offset,[-2 5],'g:')
    plot([2 2]+offset,[-2 5],'g:')
    plot([3 3]+offset,[-2 5],'g:')
    plot([4 4]+offset,[-2 5],'g:')
    plot([3 3]+offset,[0 4],'g')
    plot([4 4]+offset,[1 3],'g')
    plot([5 5]+offset,[0 3],'g')
end

axis([-To 2*To -0.5 4.5])

%h=title('Waveform Template (T_o = 5 seconds)')
%set(h,'FontSize',18)
h=xlabel('Time (seconds)');
set(h,'FontSize',18)

set(gca,'FontSize',18)

