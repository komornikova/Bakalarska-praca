A = [0, 1; -1, -3; 2, -1;2, 1; -1, 0; 0 -1];
b = [6; -3; 6; 10; 0 ; 0];

%skalarizacna metoda
%upravime ucelovu funkciu na lambda1(F_1) + lambda2(F_2)= lambda1(F_1) +
%(1-lambda1)(F_2)
%nova ucelova funkcia x1 (4 lambda1 -1) + x2 (3 lambda1 +4)

% lambda1 = 1  lambda2 = 0
lambda_1 = 1;
[x1, fval1, exitflag1] = linprog([4 * lambda_1 - 1, 3 * lambda_1 + 4],A,b);

% lambda1 = 0  lambda2 = 1
lambda_2 = 0;
[x2, fval2, exitflag2] = linprog([4 * lambda_2 - 1, 3 * lambda_2 + 4],A,b);

k = 1;
x = zeros(2, length(linspace(0,1)));
fval = zeros(length(linspace(0,1)), 1);
exitflag = zeros(length(linspace(0,1)), 1);
for lambda1 = linspace (0,1)
[x(:,k), fval(k), exitflag(k)] = linprog([4 * lambda1 - 1, 3 * lambda1 + 4],A,b); 
k = k +1;
end

%lexikograficka metoda
%poradie 1.kriterium, 2.kriterium
[fmin1, fval1, exitflag1] = linprog([3 1],A, b);
[fmin2, fval2, exitflag2] = linprog([-1 4],[A; 3 1], [b; 1]);

%poradie 2.kriterium, 1.kriterium
[fmin3, fval3, exitflag3] = linprog([-1 4],A, b);
[fmin4, fval4, exitflag4] = linprog([3 1],[A; -1 4], [b; -3]);