% premenna X obsahuje maticu dennych vynosov aktiv
X = xlsread('aktiva.xlsx', 6, 'B1731:AX2932' );

%averzia k riziku - cim vyssia, tym je investor viac rizikovo averzny
lambda = linspace(0,130,1300);
%vsetky premenne su prenasobene 252 (pocet prac.dni v roku)
%kovariancna matica
V = 252*cov(X);
%ocakavany vynos
r = (252*mean(X))'; 
%ocakavane volatility
sigma = sqrt(252)*std(X); 
%velkost
[m, n] = size(X);
%preddefinujeme si matice a vektory
w = zeros(n, length(lambda));
r_p = zeros(130,1);
V_p = zeros(130,1);
sigma_p = zeros(130,1);

k = 1;
for i=lambda
w(:,k) = quadprog(2 * i * V, -r, [], [], ones(1, n), 1, zeros(n, 1));
r_p(k) = w(:,k)' * r;
V_p(k) = w(:,k)' * V * w(:,k);
sigma_p(k) = sqrt(V_p(k));
k = k+1;
end

figure
newDefaultColors = rand(n,3);
set(gca, 'ColorOrder', newDefaultColors, 'NextPlot', 'replacechildren');
opengl software
plot(lambda,w,'LineWidth',2)
xlabel( 'averznos k riziku' , 'FontSize', 13)
ylabel( 'váhy jednotlivých aktív', 'FontSize', 13 )
title( 'Vývoj váh pri zvyšovaní averznosti k riziku' , 'FontSize', 13)
%pomenovanie
legend( 'Altria', 'Amazon.com', 'Apple', 'Arista Networks', 'AUTOGRILL S.P.A. LI 1300', 'Best Buy', 'Boeing', 'CETV', 'China Biologic Products', 'China Mobile (Hong Kong) Ltd', 'China Telecom Corporation Ltd', 'Exxon Mobil Corporation', 'Forward Industries', 'Gazprom OAO', 'Geberit', 'Google Inc.', 'Home Depot Inc.', 'Honda Motor Corporation', 'HP Incorporation', 'Industria de Diseno Textil SA (Inditex SA)', 'Infosys Technologies Ltd', 'Intel Corporation', 'iRadimed', 'Kühne+Nagel', 'Lancaster Colony', 'LOréal', 'McDonalds Corporation (EUR)', 'McDonalds Corporation (EUR)', 'Microsoft Corporation Shares USD', 'NIKE', 'NVIDIA', 'Österreichische Post', 'Rao Gazprom', 'Roche Holding AG', 'Ross Stores', 'Segro REIT', 'Starbucks', 'Taiwan Semiconductor Manufacturing Co Ltd', 'TELECOM ARGENTINA S.A. ADR', 'Texas Instruments', 'Trinity Mirror PLC', 'Valero Energy', 'Verizon Communications Inc.' ,'Vertex Pharmaceuticals', 'Visa', 'Vonovia', 'Wal-Mart Stores Inc', 'ABN Amro-Nasdaq 130 STO Indexzertifikat 29.08.2000', 'Unlimited Indexzertifikat auf ATX', 'Location','northeast', 'NumColumns',2, 'FontSize', 13) 
legend boxoff

figure
AxesH = axes('Xlim', [0,130], 'XTick', [0.1 1 13 25 50 75 130], 'NextPlot', 'add');
newDefaultColors = rand(n,3);
set(gca, 'ColorOrder', newDefaultColors, 'NextPlot', 'replacechildren');
x = [0.1 1 13 25 50 75 130];
y = w(:,[2 11 131 251 501 750 1300]);
% bar(x,y', 2, 'stacked')
bar(w', 'stacked')
% xticks([0.1 1 13 25 50 75 130])
xlabel( 'averznos k riziku' , 'FontSize', 13 )
ylabel( 'váhy jednotlivých aktív' , 'FontSize', 13)
title( 'Vývoj zloženia portfólia pri zvyšovaní averznosti k riziku' , 'FontSize', 13)
%pomenovanie
legend( 'Altria', 'Amazon.com', 'Apple', 'Arista Networks', 'AUTOGRILL S.P.A. LI 1300', 'Best Buy', 'Boeing', 'CETV', 'China Biologic Products', 'China Mobile (Hong Kong) Ltd', 'China Telecom Corporation Ltd', 'Exxon Mobil Corporation', 'Forward Industries', 'Gazprom OAO', 'Geberit', 'Google Inc.', 'Home Depot Inc.', 'Honda Motor Corporation', 'HP Incorporation', 'Industria de Diseno Textil SA (Inditex SA)', 'Infosys Technologies Ltd', 'Intel Corporation', 'iRadimed', 'Kühne+Nagel', 'Lancaster Colony', 'LOréal', 'McDonalds Corporation (EUR)', 'McDonalds Corporation (EUR)', 'Microsoft Corporation Shares USD', 'NIKE', 'NVIDIA', 'Österreichische Post', 'Rao Gazprom', 'Roche Holding AG', 'Ross Stores', 'Segro REIT', 'Starbucks', 'Taiwan Semiconductor Manufacturing Co Ltd', 'TELECOM ARGENTINA S.A. ADR', 'Texas Instruments', 'Trinity Mirror PLC', 'Valero Energy', 'Verizon Communications Inc.' ,'Vertex Pharmaceuticals', 'Visa', 'Vonovia', 'Wal-Mart Stores Inc', 'ABN Amro-Nasdaq 130 STO Indexzertifikat 29.08.2000', 'Unlimited Indexzertifikat auf ATX', 'Location','bestoutside', 'NumColumns',2, 'FontSize', 13) 
legend boxoff

%limitny pripad, nezalezi na vynose, lambda = inf
w_lim = quadprog(2 * V, [], [], [], ones(1, n), 1, zeros(n, 1));
r_p_lim = w_lim' * r;
V_p_lim = w_lim' * V * w_lim;
sigma_p_lim = sqrt(V_p_lim);

% vahy = zeros(49,1);
% 
% for i = 1:49
%     if w_lim(i) > 0.0005
%        vahy(i) = w_lim(i);
%        else
%        vahy(i) = 0;
%     end
% end
% 
% l = 1;
% for i = 1:49
%     if vahy(i) ~ 0
%         vahy_graf (l) = vahy(i);
%         l = l + 1;
%     end
% end
% 
% labels = { 'Altria', 'China Biologic Products', 'China Mobile (Hong Kong) Ltd', 'Forward Industries', 'Geberit', 'Honda Motor Corporation', 'iRadimed', 'Kühne+Nagel', 'Lancaster Colony', 'McDonalds Corporation (EUR)', 'McDonalds Corporation (EUR)', 'Österreichische Post', 'Rao Gazprom', 'Roche Holding AG','Segro REIT', 'TELECOM ARGENTINA S.A. ADR', 'Trinity Mirror PLC', 'Verizon Communications Inc.' ,'Vonovia', 'Wal-Mart Stores Inc', 'Unlimited Indexzertifikat auf ATX'};
% pie(vahy_graf, labels)
% title( 'Portfólio extrémne rizikovo averzného investora', 'FontSize', 13 )
% xlabel( 'aktíva', 'FontSize', 13 )
% ylabel( 'váhy jednotlivých aktív' , 'FontSize', 13)
% 
% %limitny pripad, nezalezi na riziku, lambda = 0
% w_lim_2 = linprog(-r, [], [], ones(1, n), 1, zeros(n, 1));
% r_p_lim_2 = w_lim_2' * r;
% V_p_lim_2 = w_lim_2' * V * w_lim_2;
% sigma_p_lim_2 = sqrt(V_p_lim_2);
% 
% bar(w_lim_2, 'stacked')
% title( 'Portfólio extrémne riziko vyh¾adávajúceho investora' )
% legend( 'NVIDIA', 'Location','bestoutside', 'FontSize', 13) 
% legend boxoff
% xticks()
% xlabel( 'aktíva', 'FontSize', 13 )
% ylabel( 'váhy jednotlivých aktív' , 'FontSize', 13)

[PortRisk,PortReturn,PortWts] = portopt(r,V,13000);
portopt(r,V,13000)

figure
newDefaultColors = rand(n,3);
set(gca, 'ColorOrder', newDefaultColors, 'NextPlot', 'replacechildren');
bar(PortWts, 'stacked')
title( 'Zloženie portfólii na efektívnej hranici' )
%pomenovanie
legend( 'Altria', 'Amazon.com', 'Apple', 'Arista Networks', 'AUTOGRILL S.P.A. LI 1300', 'Best Buy', 'Boeing', 'CETV', 'China Biologic Products', 'China Mobile (Hong Kong) Ltd', 'China Telecom Corporation Ltd', 'Exxon Mobil Corporation', 'Forward Industries', 'Gazprom OAO', 'Geberit', 'Google Inc.', 'Home Depot Inc.', 'Honda Motor Corporation', 'HP Incorporation', 'Industria de Diseno Textil SA (Inditex SA)', 'Infosys Technologies Ltd', 'Intel Corporation', 'iRadimed', 'Kühne+Nagel', 'Lancaster Colony', 'LOréal', 'McDonalds Corporation (EUR)', 'McDonalds Corporation (EUR)', 'Microsoft Corporation Shares USD', 'NIKE', 'NVIDIA', 'Österreichische Post', 'Rao Gazprom', 'Roche Holding AG', 'Ross Stores', 'Segro REIT', 'Starbucks', 'Taiwan Semiconductor Manufacturing Co Ltd', 'TELECOM ARGENTINA S.A. ADR', 'Texas Instruments', 'Trinity Mirror PLC', 'Valero Energy', 'Verizon Communications Inc.' ,'Vertex Pharmaceuticals', 'Visa', 'Vonovia', 'Wal-Mart Stores Inc', 'ABN Amro-Nasdaq 130 STO Indexzertifikat 29.08.2000', 'Unlimited Indexzertifikat auf ATX', 'Location','bestoutside', 'NumColumns',2, 'FontSize', 13) 
legend boxoff
xticks()
xlabel( '' )
ylabel( 'váhy jednotlivých aktív' , 'FontSize', 13)
