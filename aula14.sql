select * from departamento;
select * from localdep;
select numerodepto, nome, localizacao from departamento, localdep where numerodepto = numero;

select numero, nome, salario from funcionario where numerodepto = 1;
select * from funcionario where salario > 5000;
select * from funcionario where nome = 'Funcionario 10';
select * from funcionario where estado = 'SP' and salario > 3000;
select * from dependente where numerofunc = 3;
select * from dependente where parentesco = 'filho';
select * from departamento where numero = 5;
select localizacao from localdep where numerodepto = 1;
select numero, nome, localizacao from departamento, localdep where numero = numerodepto;

select f.numero, f.nome, d.* from funcionario f, dependente d where f.numero = d.numerofunc;
select f.numero, f.nome, p.numero, p.nome from funcionario f, projeto p, participafp where numerofunc = f.numero and numeroproj = p.numero;
select f.numero, f.nome, p.numero, p.nome from funcionario f, projeto p, participafp where numerofunc = f.numero and numeroproj = p.numero and horas = '05:50:50';
select p.*, d.nome from projeto p, departamento d where numerodepto = d.numero;
select d.*, f.nome from departamento d, funcionario f where numerofuncger = f.numero;
