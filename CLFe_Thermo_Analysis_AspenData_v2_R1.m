clear

Sheet='Sheet'
n=5;

Sheetnumber='Sheet1';
data=xlsread('CLFE_Thermo_Analysis_AspenData_recovered_v2_R1',Sheetnumber);
figure(3)
plot(data(:,1),data(:,6),'k-.',data(:,1),data(:,7),'k--',data(:,1),data(:,8),'k',data(:,1),data(:,9),'b-.',data(:,1),data(:,10),'b--','LineWidth',2)
set(gca,'FontSize',16,'TickLabelInterpreter','latex')
l=[legend('$\mathrm{CO}$','$\mathrm{CO}_{2}$','$\mathrm{CH}_{4}$','$\mathrm{H}_{2}$','$\mathrm{H}_{2}\mathrm{O}$') xlabel('$\mathrm{Fe}_{2}\mathrm{O}_{3}$ to $\mathrm{CH_{4}}$ feed ratio') ylabel('Molar flow rate /$\mathrm{mol}$ $\mathrm{s}^{-1}$')]
set(l,'Interpreter','latex')

figure(4)
plot(data(:,1),data(:,2),'b',data(:,1),data(:,4),'r--',data(:,1),data(:,3),'r:',data(:,1),data(:,5),'r.-',data(:,1),data(:,11),'k','LineWidth',2)
set(gca,'FontSize',16)
l=[legend('$\mathrm{Fe}$','$\mathrm{Fe_{w}O}$','$\mathrm{Fe_{3}O_{4}}$','$\mathrm{Fe_{2}O_{3}}$','$\mathrm{C}$') xlabel('$\mathrm{Fe_{2}O_{3}}$ to $\mathrm{CH_{4}}$ feed ratio') ylabel('Molar flow rate /$\mathrm{mol}$ $\mathrm{s}^{-1}$')]
set(l,'Interpreter','latex')



data=[];
for k=1:1:n
number=num2str(k);
Sheetnumber=strcat(Sheet,number);
dataread=xlsread('CLFE_Thermo_Analysis_AspenData_recovered_v2_R1',Sheetnumber);
data(:,:,k)=dataread;
end







X1gas=1-data(:,8).*(3-2*data(:,8))

xH2O=data(:,10);
xH2=data(:,9);
xCO=data(:,6);
xCO2=data(:,7);

xFe=data(:,2);
xFe3O4=data(:,3);
xFeO=data(:,4);
xFe2O3=data(:,5);


x=(2*xCO2+xCO)./(2*(xCO2+xCO));
y=xH2O./(xH2+xH2O);


X1gas=(x+y)/2;
X1gas(1)=0;
w=0.947;
xy=(3*xFe2O3+4*xFe3O4+xFeO)./(2*xFe2O3+3*xFe3O4+w*xFeO+xFe);
X1solid=(2/3-xy)/(2/3);

nH2O=data(:,10);
nH2=data(:,9);
nCO=data(:,6);
nCO2=data(:,7);

nFe=data(:,2);
nFe3O4=data(:,3);
nFeO=data(:,4);
nFe2O3=data(:,5);
inletflow=data(:,1);

nH2O=data(:,10,:);
nH2=data(:,9,:);
nCO=data(:,6,:);
nCO2=data(:,7,:);

nFe=data(:,2,:);
nFe3O4=data(:,3,:);
nFeO=data(:,4,:);
nFe2O3=data(:,5,:);
inletflow=data(:,1,:);

w=0.947;
for k=1:1:n
x=(2*nCO2+nCO)./(2*(nCO2+nCO));
y=xH2O./(nH2+nH2O);
X1gas=(x+y)/2;
X1solid=(3/2-(3*nFe2O3+4*nFe3O4+w*nFeO)./(2*nFe2O3+3*nFe3O4+nFeO+nFe))./(3/2)
figure(10)
plot(data(:,1),X1solid(:,:,k),'LineWidth',2)
set(gca,'FontSize',16,'TickLabelInterpreter','latex')
l=[legend('1000 C','950 C','900 C','850 C','800 C') xlabel('Solid to gas feed ratio') ylabel('Conversion')]
set(l,'Interpreter','latex')
hold on
end
hold off


figure(2)
plot(data(:,1),X1solid(:,:,1),'LineWidth',2)

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

figure(5)
plot(T1,xFe2O3p,'k--',T1,xFe3O4p,'k--',T1([15:100]),xFeOp([15:100]),'k--',T1,xFe2O3COp,'k',T1([17:100]),xFe3O4COp([17:100]),'k',T1,xFeOCOp,'k','LineWidth',2)
set(gca,'FontSize',16,'Yscale','log')
l=[legend('xFe2O3','xFe3O4','xFeO') xlabel('Temperature /K') ylabel('$p_{CO_{2}}/P$')]
xlim([700,1400])
set(l,'Interpreter','latex')

figure(6)
plot(T1,xFe2O3COp,'k',T1([17:100]),xFe3O4COp([17:100]),'k',T1,xFeOCOp,'k','LineWidth',2)
set(gca,'FontSize',16,'Yscale','log')
l=[legend('xFe2O3','xFe3O4','xFeO') xlabel('Temperature /K') ylabel('$p_{CO_{2}}/P$')]
xlim([700,1400])
set(l,'Interpreter','latex')

figure(7)
plot(T1,xFe2O3p,'k--',T1,xFe3O4p,'k--',T1([15:100]),xFeOp([15:100]),'k--','LineWidth',2)
set(gca,'FontSize',16,'Yscale','log')
l=[legend('xFe2O3','xFe3O4','xFeO') xlabel('Temperature /K') ylabel('$p_{H_{2}O}/P$')]
xlim([700,1400])
set(l,'Interpreter','latex')

%plot(T,xFe2O3,'o',T,xFe3O4,'o',T,xFeO,'o',T,xFe2O3CO,'o',T,xFe3O4CO,'o',T,xFeOCO,'o','LineWidth',2)


PTdata=100*[0.9901541	0.982034655	0.973143525	0.964477663	0.95495661	0.942879102	0.895036426	0.730847593	0.109883143;
0.990108789	0.98189809	0.972728525	0.963159186	0.950444707	0.926232465	0.856670939	0.38315323	0;
0.989734259	0.98086822	0.969743364	0.953971225	0.920549476	0.831417446	0.46658084	0.098627604	0;
0.988316795	0.977107456	0.959176257	0.923161949	0.834207529	0.580083618	0.234798252	0	0;
0.985917481	0.978260788	0.942269432	0.878181825	0.734908185	0.351459303	0.172911613	0	0;
0.982555953	0.962304096	0.920077886	0.825656042	0.644391999	0.266080786	0.114953569	0	0;
0.978260788	0.951599972	0.893837314	0.771080669	0.479275978	0.220121997	0.068755145	0	0;
0.973068771	0.93899002	0.864800183	0.718089525	0.383764546	0.19086163	0.034929656	0	0];

T_PTdata=[1000 950 900 850 800 750 700 650 600];
P_PTdata=[1;2;5;10;15;20;25;30];

figure(10)
plot(T_PTdata,PTdata(1,:),'k-.x',T_PTdata,PTdata(2,:),'k--x',T_PTdata,PTdata(3,:),'k:x',T_PTdata,PTdata(4,:),'k-.o',T_PTdata,PTdata(6,:),'k--o',T_PTdata,PTdata(8,:),'k:o','LineWidth',2)
set(gca,'FontSize',16,'TickLabelInterpreter','latex')
l=[legend('1 bar','2 bar','5 bar','10 bar','20 bar','30 bar') xlabel('Temperature /C') ylabel('Metallization %')]
set(l,'Interpreter','latex')