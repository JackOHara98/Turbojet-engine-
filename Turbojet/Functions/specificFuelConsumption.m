function SFC = specificFuelConsumption(Fs, engine, eff)
% Calculates specific fuel consumption (kg/N·h)

x = 0.01868; % From temperature rise chart
f = x / eff.CE;

SFC = (f / Fs) * 3600; % kg/N·h
end
