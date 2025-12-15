function [T01, P01] = stagnationProperties(ca, ambient, engine, eff)
% Calculates stagnation temperature and pressure at compressor inlet

T01 = ambient.Ta + (ca^2)/(2*engine.cpAir*1000); % Convert kJ to J for velocity term
P01 = ambient.Pa * (1 + (eff.Ni*(ca^2)/(2*engine.cpAir*1000*ambient.Ta)))^(engine.gammaAir/(engine.gammaAir-1));
end
