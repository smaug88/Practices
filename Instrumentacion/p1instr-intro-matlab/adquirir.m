function [tiempo, out] = adquirir(numiter)
    out = [];
    tiempo = 0:(numiter-1);
    tiempo = tiempo * 50;
    for i = 1:numiter
        [voltage overVoltage errorcode idnum] = eanalogin(-1, 0, 0, 0);
        out = [out [voltage]];
        % pause(deltaT)
    end
end