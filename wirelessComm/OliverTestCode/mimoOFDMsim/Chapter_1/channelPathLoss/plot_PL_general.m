% plot_PL_general.m
%plot_PL_general.m

%MIMO-OFDM Wireless Communications with MATLAB¢ç   Yong Soo Cho, Jaekwon Kim, Won Young Yang and Chung G. Kang
%2010 John Wiley & Sons (Asia) Pte Ltd

clear all, clf, clc, close all
fc=1.5e9;  d0=100;  sigma=3;
distance=[1:2:31].^2;
Gt=[1 1 0.5]; Gr=[1 0.5 0.5]; Exp=[2 3 6]; 
for k=1:3
   y_Free(k,:)= PL_free(fc,distance,Gt(k),Gr(k));
   y_logdist(k,:)= PL_logdist_or_norm(fc,distance,d0,Exp(k));
   y_lognorm(k,:)= PL_logdist_or_norm(fc,distance,d0,Exp(1),sigma); % ??
end
subplot(131)
semilogx(distance,y_Free(1,:),'k-o',distance,y_Free(2,:),'b-^',distance,y_Free(3,:),'r-s')
grid on, axis([1 1000 40 110]), title(['Free PL Models, f_c=',num2str(fc/1e6),'MHz'])
xlabel('Distance[m]'), ylabel('Path loss[dB]')
legend('G_t=1, G_r=1','G_t=1, G_r=0.5','G_t=0.5, G_r=0.5','location','northwest')
subplot(132)
semilogx(distance,y_logdist(1,:),'k-o',distance,y_logdist(2,:),'b-^',distance,y_logdist(3,:),'r-s')
grid on, axis([1 1000 40 110]),
title(['Log-distance PL model, f_c=',num2str(fc/1e6),'MHz'])
xlabel('Distance[m]'), ylabel('Path loss[dB]'), legend('n=2','n=3','n=6','location','northwest')
subplot(133)
semilogx(distance,y_lognorm(1,:),'k-o',distance,y_lognorm(2,:),'b-^',distance,y_lognorm(3,:),'r-s')
grid on, axis([1 1000 40 110]),
title(['Log-normal PL model, f_c=',num2str(fc/1e6),'MHz, ','\sigma=', num2str(sigma), 'dB'])
xlabel('Distance[m]'), ylabel('Path loss[dB]'), legend('path 1','path 2','path 2','location','northwest')


function PL=PL_free(fc,d,Gt,Gr)
% Free Space Path Loss Model
% Inputs: fc : Carrier frequency[Hz]
% d : Distance between base station and mobile station[m]
% Gt/Gr : Transmitter/Receiver gain
% Output: PL : Path loss[dB]
lamda = 3e8/fc; tmp = lamda./(4*pi*d);
if nargin>2, tmp = tmp*sqrt(Gt); end
if nargin>3, tmp = tmp*sqrt(Gr); end
PL = -20*log10(tmp); % Eq.(1.2)/(1.3)
end

function PL=PL_logdist_or_norm(fc,d,d0,n,sigma)
% Log-distance or Log-normal shadowing path loss model
% Inputs: fc : Carrier frequency[Hz]
% d : Distance between base station and mobile station[m]
% d0 : Reference distance[m]
% n : Path loss exponent
% sigma : Variance[dB]
lamda=3e8/fc; PL= -20*log10(lamda/(4*pi*d0))+10*n*log10(d/d0); % Eq.(1.4)
if nargin>4, PL = PL + sigma*randn(size(d)); end % Eq.(1.5)
end