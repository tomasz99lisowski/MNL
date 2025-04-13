function [impedance_delta] = impedance_difference(frequency)

R = 525
C = 7e-5
L = 3
M = 75

if frequency < 0
    error('Frequency must be a positive number')
end

module = 1/sqrt((1/(R^2)) + (2*pi*frequency*C - 1/(2*pi*frequency*L))^2);
impedance_delta = module - M
end