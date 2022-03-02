% The program is running a bit slow because it has a difficult operation.
% Please wait 15-20 seconds after running the program.
% You have to press "Enter" to see the graphics.

rand("seed",219)

disp("Deneysel Ayarlamalar")
R1 = randi([10 30])
R2 = randi ([0 50]) % Rheostat
R3 = randi([10 30])
Rx = randi([10 30]) % unknown resistance
Vs = 30 
VG = ((R2/(R1+R2))-(Rx/(R3+Rx)))*Vs;
fprintf("Value measured in galvanometer: %g\n" ,VG) 
disp("")

% Let's make it functional
disp("VG(R1,R2,R3,Rx,Vs) Function : ")
function f=VG(R1,R2,R3,Rx,Vs)
  f=((R2/(R1+R2))-(Rx/(R3+Rx)))*Vs;
endfunction
vg = VG(23,10,13,20,19);
fprintf("VG(23,10,13,20,19): %g\n" ,vg);
disp("")
 
% Let's try to make the VG value zero by playing with the rheostat
x0 = 0;
step_size = 1E-5;  % sensitivity value
a = ((x0/(x0+R1))-(Rx/(R3+Rx)))*Vs;
for i=1:5000000
    x1 = x0 + step_size;
    b = ((x1/(x1+R1))-(Rx/(R3+Rx)))*Vs;
    if((a/b) < 0)
        root = (x0 + x1) /2;
        VG = ((root/(root+R1))-(Rx/(R3+Rx)))*Vs;
        fprintf("R2: %g\nVG: %g\n" ,root,VG);
        break;
    endif
    x0 = x1;
    a = b;
endfor
R2 = root; % We assigned the root we found as R2
disp("")

%% Let's check it out
disp("Check")
% If VG=0 then R2=(Rx*R1)/R3
A = (Rx*R1)/R3;
B = ((A/(A+R1))-(Rx/(R3+Rx)))*Vs;
fprintf("R2: %g\nVG: %g\n" ,A,B);
disp("")

disp("Finding Currents and Rx Resistance")
% Finding the I3 current
i1 = Vs / (R1+R2);
fprintf("I1 current : %g\n" ,i1);
i3 = (i1*R1) / R3;
fprintf("I3 current : %g\n" ,i3);
% Finding the Rx value obtained experimentally
Rx_= (i1*R2) / i3; 
fprintf("Rx : %g\n" ,Rx_);
fprintf("Rx at the beginning: %g\n" ,Rx);
disp("")
%Comparison of experimentally obtained Rx value and theoretically calculated Rx value
error=((abs(Rx-Rx_))/Rx)*100;
fprintf("The accuracy of the Rx value found (percent) : %g\n" ,error);
disp("")

% When changing the rheostat from 10 to 30
disp("VG Graph with R2 = 10 - 30 Ohms")
R2 = linspace(10,30,100); 
VG = ((R2./(R2.+R1))-(Rx/(R3+Rx)))*Vs;
plot(R2,VG) 
xlabel ("R2");
ylabel ("VG");
title("R2 - VG Chart")
pause
disp("")

%%Bonus
disp("VG Graph with R1 and R2 Rheostat Enabled")
R1 = R2 =  linspace(10,50,100);
[r1,r2] = meshgrid(R1,R2); % We blended the R1 and R2 values
VG = ((r2./(r1.+(r2.*1)))-(Rx/(R3+Rx)))*Vs;
mesh(R1,R2,VG)
xlabel ("R1");
ylabel ("R2");
zlabel ("VG");
title ("R1 - R2 - VG Chart");
