function H=Ric_model(sigma,K_dB,L)
% Rician Channel Model
%   Input:
%       K_dB   : K factor [dB]
%       L      : # of channel realization
%   Output:
%       h      : channel vector

%MIMO-OFDM Wireless Communications with MATLAB¢ç   Yong Soo Cho, Jaekwon Kim, Won Young Yang and Chung G. Kang
%2010 John Wiley & Sons (Asia) Pte Ltd

K=10^(K_dB/10);
H = sqrt(K*2*sigma) + Ray_model(sigma,L);