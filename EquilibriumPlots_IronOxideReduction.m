%This script uses data from "Thermochemical properties of inorganic
%substances by Barin Ihsan BarinOttmar KnackeOswald Kubaschewski" to
%calculate the position of equilibrium for the reduction of iron oxide.

clear
w=0.947;
T=transpose([700 800 900 1000.00 1100.00 1200.00 1300.00 1400.00 1500.00 1600.00 1700.00])
G_Hematite=transpose([-635.651 -610.301 -585.344 -560.690 -535.980 -511.164 -486.330 -461.638 -437.069 -412.606 -388.196])
G_Magnetite=transpose([-882.629 -851.723 -821.789 -792.184 -762.355 -732.346 -702.253 -672.301 -642.460 -612.713 -582.996])
G_Wustite=transpose([-218.458 -212.110 -205.790 -199.443 -192.981 -186.454 -179.910 -173.432 -167.014 -160.652 -155.276])
G_Water=transpose([-208.898 -203.595 -198.193 -192.713 -187.168 -181.572 -175.934 -170.260 -164.559 -158.834 -153.090])
G_CO=transpose([-173.522 -182.494 -191.408 -200.261 -209.056 -217.796 -226.482 -235.118 -243.707 -252.250 -260.751])
G_CO2=transpose([-395.347 -395.527 -395.680 -395.81 -395.91 -396.007 -396.079 -396.136 -396.179 -396.210 -396.229])

G_reduction=(4*G_Magnetite-6*G_Hematite)*10^3;
xO2=exp(-G_reduction./(8.3145.*T));

G_redFe2O3=(2.*G_Magnetite+G_Water-3.*G_Hematite)*10^3;
G_redFe3O4=((3/w).*G_Wustite+((4*w-3)/w).*G_Water-G_Magnetite)*10^3;
G_redFeO=(G_Water-G_Wustite)*10^3;

G_redFe2O3CO=(2.*G_Magnetite+G_CO2-3.*G_Hematite-G_CO)*10^3;
G_redFe3O4CO=((3/w).*G_Wustite+((4*w-3)/w).*G_CO2-G_Magnetite-((4*w-3)/w).*G_CO)*10^3;
G_redFeOCO=(G_CO2-G_Wustite-G_CO)*10^3;

%G_redFeO=G_redFeO([2:10]);
xFe2O3=exp(-G_redFe2O3./(8.3145.*T));
p=polyfit(T,xFe2O3,12);
T1=linspace(700,1700)
xFe2O3p=polyval(p,T1)

xFe3O4=exp(-G_redFe3O4./(8.3145.*T));
p=polyfit(T,xFe3O4,12);
xFe3O4p=polyval(p,T1)

xFeO=exp(-G_redFeO./(8.3145.*T));
p=polyfit(T,xFeO,12);
xFeOp=polyval(p,T1)

xFe2O3CO=exp(-G_redFe2O3CO./(8.3145.*T));
p=polyfit(T,xFe2O3CO,12);
xFe2O3COp=polyval(p,T1)

xFe3O4CO=exp(-G_redFe3O4CO./(8.3145.*T));
p=polyfit(T,xFe3O4CO,12);
xFe3O4COp=polyval(p,T1)

xFeOCO=exp(-G_redFeOCO./(8.3145.*T));
p=polyfit(T,xFeOCO,12);
xFeOCOp=polyval(p,T1)

figure(1)
plot(T1,xFe2O3COp,T1([17:100]),xFe3O4COp([17:100]),T1,xFeOCOp,'LineWidth',2)
set(gca,'FontSize',16,'Yscale','log')
l=[legend('Reaction 1','Reaction 2','Reaction 3') xlabel('Temperature /K') ylabel('$p_{CO_{2}}/p_{CO}$')]
xlim([700,1400])
set(l,'Interpreter','latex')

figure(2)
plot(T1,xFe2O3p,'--',T1,xFe3O4p,'--',T1([15:100]),xFeOp([15:100]),'--','LineWidth',2)
set(gca,'FontSize',16,'Yscale','log')
l=[legend('Reaction 1','Reaction 2','Reaction 3') xlabel('Temperature /K') ylabel('$p_{H_{2}O}/p_{H_{2}}$')]
xlim([700,1400])
set(l,'Interpreter','latex')


K1=[xFe2O3COp(37) xFe2O3COp(43) xFe2O3COp(48) xFe2O3COp(53) xFe2O3COp(58)]
K2=[xFe3O4COp(37) xFe3O4COp(43) xFe3O4COp(48) xFe3O4COp(53) xFe3O4COp(58)]
K3=[xFeOCOp(37) xFeOCOp(43) xFeOCOp(48) xFeOCOp(53) xFeOCOp(58)]

K1=[xFe2O3p(37) xFe2O3p(43) xFe2O3p(48) xFe2O3p(53) xFe2O3p(58)]
K2=[xFe3O4p(37) xFe3O4p(43) xFe3O4p(48) xFe3O4p(53) xFe3O4p(58)]
K3=[xFeOp(37) xFeOp(43) xFeOp(48) xFeOp(53) xFeOp(58)]
%{ 
%this one just plots both the previous plots together
figure(3)
plot(T1,xFe2O3p,'k--',T1,xFe3O4p,'k--',T1([15:100]),xFeOp([15:100]),'k--',T1,xFe2O3COp,'k',T1([17:100]),xFe3O4COp([17:100]),'k',T1,xFeOCOp,'k','LineWidth',2)
set(gca,'FontSize',16,'Yscale','log')
l=[legend('xFe2O3','xFe3O4','xFeO') xlabel('Temperature /K') ylabel('$p_{CO_{2}}/P$')]
xlim([700,1400])
set(l,'Interpreter','latex')
%}


