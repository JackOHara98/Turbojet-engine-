function ca = freestreamVelocity(ambient)
% Calculates freestream velocity from Mach number
ca = ambient.M * ambient.SOS; % m/s
end
