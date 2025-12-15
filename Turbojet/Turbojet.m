%% Turbojet Engine Performance Analysis
clear; clc;

%% Ambient Conditions
ambient.M   = 0.85;         % Mach
ambient.alt = 9000;         % m
ambient.Pa  = 0.3074e5;     % Pa (converted from bar)
ambient.Ta  = 229.65;       % K
ambient.SOS = 303.8;        % m/s

%% Engine Parameters
engine.pr        = 7;       % Compressor pressure ratio
engine.Ti        = 1200;    % Turbine inlet temperature (K)
engine.cpAir     = 1.005;   % kJ/kg·K
engine.cpGas     = 1.148;   % kJ/kg·K
engine.gammaAir  = 1.4;
engine.gammaGas  = 1.333;
engine.R         = 287;     % J/kg·K

%% Efficiencies
eff.Nc  = 0.9;    % Compressor
eff.Nt  = 0.92;   % Turbine
eff.Ni  = 0.9;    % Intake
eff.Npn = 0.9;    % Nozzle
eff.MTE = 1;      % Mechanical
eff.CE  = 0.95;   % Combustion efficiency

%% Calculate freestream velocity
ca = freestreamVelocity(ambient);

%% Stagnation properties at compressor inlet
[T01, P01] = stagnationProperties(ca, ambient, engine, eff);

%% Nozzle choking
[choked, P04Pc] = nozzleChokeCheck(engine, eff, T01, P01);

%% Calculate specific thrust
Fs = specificThrust(engine, eff, ambient, T01, P01, choked, P04Pc);
fprintf('Specific thrust: %.2f Ns/kg\n', Fs);

%% Calculate specific fuel consumption
SFC = specificFuelConsumption(Fs, engine, eff);
fprintf('Specific fuel consumption: %.4f kg/Nh\n', SFC);

%% Mach sweep
M_vec = 0.5:0.05:1.0;
Fs_vec = zeros(size(M_vec));
SFC_vec = zeros(size(M_vec));

for i = 1:length(M_vec)
    ambient.M = M_vec(i);
    ca = freestreamVelocity(ambient);
    [T01, P01] = stagnationProperties(ca, ambient, engine, eff);
    [choked, P04Pc] = nozzleChokeCheck(engine, eff, T01, P01);
    Fs_vec(i) = specificThrust(engine, eff, ambient, T01, P01, choked, P04Pc);
    SFC_vec(i) = specificFuelConsumption(Fs_vec(i), engine, eff);
end

%% Plotting
figure;
yyaxis left
plot(M_vec, Fs_vec,'-o','LineWidth',2,'MarkerSize',6)
xlabel('Mach Number')
ylabel('Specific Thrust (Ns/kg)')
grid on
title('Turbojet Performance vs Mach Number')

yyaxis right
plot(M_vec, SFC_vec,'-s','LineWidth',2,'MarkerSize',6)
ylabel('Specific Fuel Consumption (kg/N·h)')
legend('Specific Thrust','SFC','Location','best')

