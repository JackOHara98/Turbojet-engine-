function [choked, P04Pc] = nozzleChokeCheck(engine, eff, T1, P01)
% Determines if the nozzle is choked and calculates critical pressure

% Critical pressure ratio for choked flow
g = engine.gammaGas;
P04Pc = 1 / (1 - (1/eff.Npn)*(g/(g+1)))^(g/(g-1));

choked = P04Pc < P01; % Boolean flag
end
