function Fs = specificThrust(engine, eff, ambient, T01, P01, choked, P04Pc)
% Calculates specific thrust (Ns/kg) for a simple turbojet

% Nozzle exit temperature
Tc = engine.Ti * 0.95; % Approximate expansion in turbine, can refine

% Nozzle exit velocity
if choked
    % Choked nozzle
    Cs = sqrt(engine.gammaGas * engine.R * Tc) * sqrt((2/(engine.gammaGas+1))^( (engine.gammaGas+1)/(engine.gammaGas-1) ));
else
    % Unchoked nozzle (approximation)
    Cs = sqrt(2 * engine.cpGas * 1000 * (engine.Ti - Tc)); % J/kg
end

% Specific thrust
Fs = Cs - ambient.M * ambient.SOS; % Ns/kg

% Ensure positive
if Fs < 0
    Fs = abs(Fs);
end
end
