f1 = figure('Name', 'Gr�fica para +90� (x=R2)');
ezplot('abs((2.45)/(x+2.45) - 10.88/(x + 10.88))', [0 50])
grid on
%axis([0 2 0 0.25])
axis([0 50 0 0.25])

f2 = figure('Name', 'Gr�fica para -90� (x=R2)');
ezplot('abs((18.37)/(x+18.37) - 10.88/(x + 10.88))', [0 50])
grid on
%axis([0 5 0 0.25])
axis([0 50 0 0.25])

f3 = figure('Name', 'Gr�fica para 0� (x=R2)');
ezplot('abs((10.88)/(x+10.88) - 10.88/(x + 10.88))', [0 50])
grid on
%axis([0 5 0 0.25])
axis([0 50 0 0.25])

f4 = figure;
ezsurfc('abs((y)/(x+y)-10.88/(x + 10.88))', [0,50,2.45,18.37])
%ezsurf('(y)/(x+y) - 10.88/(x + 10.88)', [0, 50, 2.45, 18.37])
grid on
%axis([0 5 0 0.25])
axis([0 50 0 50 0 0.25])