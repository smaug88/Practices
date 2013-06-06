function [voltaje distancia] = tomarMedida(polcal)
    [voltaje overVoltage errorcode idnum] = eanalogin(-1, 1, 8, 0);
    distancia = polyval(polcal, voltaje);
end