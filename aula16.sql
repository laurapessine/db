/* 1. Liste todos os dados dos departamentos em ordem alfabética de nome; */

select * from departamento order by nome asc;

/* 2. Liste todos os funcionários com salários entre 5 e 10 mil reais em ordem
decrescente de salario; */

select * from funcionario where salario between 5000 and 10000 order by salario desc;

/* 3. Liste o numero do funcionário, o nome do funcionário, o número do projeto,
o nome do projeto, a quantidade de horas trabalhadas para aqueles
funcionários que trabalharam entre 7 e 10 horas em projetos; */

select f.numero, f.nome, p.numero, p.nome, horas
from funcionario f, projeto p, participafp fp
where fp.numerofunc = f.numero and fp.numeroproj = p.numero and fp.horas between '07:00:00' and '10:00:00';

/* 4. Liste o nome do funcionário, os nomes de seus dependentes e suas
respectivas datas de nascimento ordenados por nome do funcionário
(alfabética) e datas de nascimento de seus dependentes, do mais novo para
o mais velho; */

select f.nome, d.nome, d.dataniver
from funcionario f, dependente d
where f.numero = d.numerofunc order by f.nome asc, d.dataniver desc;

/* 5. Selecione todos os dados do projeto e do departamento que o controla,
para os projetos controlados pelos departamentos 2, 3 e 4. */

select p.*, d.*
from projeto p, departamento d
where p.numerodepto = d.numero and p.numerodepto in (2, 3, 4);

/* 6. Liste todos os funcionários cujo nome comece com “Func” e trabalhem no
departamento 3; */

select * from funcionario where nome like 'Func%' and numerodepto = 3;

/* 7. Liste todos os departamentos que tenham “mento” em qualquer parte de seu nome
que tenham gerentes atuando; */

select * from departamento where nome like '%mento%' and numerofuncger is not null;

/* 8. Liste todos os funcionários que trabalham em departamentos cujas localizações
comecem com “São”; */

select f.*, l.localizacao
from funcionario f, localdep l
where f.numerodepto = l.numerodepto and localizacao like 'Sao%'; 

/* 9. Liste todos os funcionários que tenham “on” ou “er” em seus nomes e que
participem de projetos cujo nome termine com o dígito 4; */

select f.nome
from funcionario f, projeto p, participafp fp
where f.numero = fp.numerofunc and p.numero = fp.numeroproj and (f.nome like '%on%' or f.nome like '%er%') and p.nome like '%4';

/* 10. Liste todos os projetos cujos departamentos que os controlam tenham “mento 2” em
seu nome. */

select p.*, d.*
from projeto p, departamento d
where p.numerodepto = d.numero and d.nome like '%mento 2';

/* 11. Liste o número, o nome e o endereço completo dos funcionários que contenham o
número 2 na ultima posição do número de seu endereço e que trabalhem em
departamento que ainda não tem gerente; */

select f.numero, f.nome, f.rua, f.nro, f.cep, f.estado, d.*
from funcionario f, departamento d
where f.numerodepto = d.numero and d.numerofuncger is null and f.nro % 10 = 2;

/* 12. Liste todos os dependentes e os nomes de seus pais para aqueles que tiverem grau
de parentesco filha; */

select d.*, f.numero, f.nome
from dependente d, funcionario f
where d.numerofunc = f.numero and d.parentesco like 'filha';

/* 13. Liste o menor salário da empresa; */

select min(salario) from funcionario;

/* 14. Liste os dados do funcionário e o nome do departamento do funcionário que
recebe o menor salário da empresa; */

select f.*, d.nome
from funcionario f, departamento d
where f.numerodepto = d.numero and f.salario = (select min(salario) from funcionario);

/* 15. Liste os dados do dependente mais velho; */

select * from dependente where dataniver = (select min(dataniver) from dependente);

/* 16. Liste os dados do dependente mais novo; */

select * from dependente where dataniver = (select max(dataniver) from dependente);

/* 17. Liste os dados do funcionário que trabalhou a maior quantidade de horas em
um único projeto; */

select f.*, fp.horas
from funcionario f, participafp fp
where fp.numerofunc = f.numero and fp.horas = (select max(horas) from participafp);

/* 18. Liste o número e o nome do funcionário, o número e o nome do projeto, e a
quantidade de horas trabalhadas no projeto para o funcionário que trabalhou
a menor quantidade de horas em um único projeto; */

select f.numero, f.nome, p.numero, p.nome, fp.horas
from funcionario f, projeto p, participafp fp
where f.numero = fp.numerofunc and p.numero = fp.numeroproj and fp.horas = (select min(horas) from participafp);

/* 19. Liste a quantidade de departamentos da empresa; */

select count(*) as quantidade_departamentos from departamento;

/* 20. Liste a quantidade de funcionários do estado de São Paulo. */

select count(*) as func_sp from funcionario where estado = 'SP';

/* 21. Liste os valores distintos de salários pagos aos funcionários. */

select distinct salario from funcionario;

/* 22. Liste o número e nome dos funcionários da empresa que possuem dependentes
“filho” ou “filha” que tenham nascido no ano de 2007. */

select f.numero, f.nome, d.*
from funcionario f, dependente d
where f.numero = d.numerofunc and d.parentesco like 'filh%' and year(d.dataniver) = 2007;

/* 23. Liste a quantidade de funcionários que trabalham no departamento de nome
“Departamento 2”. */

select count(*) as quant_func_depto2
from funcionario f, departamento d
where f.numerodepto = d.numero and d.nome like 'Departamento 2';

/* 24. Liste o número e o nome dos funcionários que não são gerentes de
departamento. */

select numero, nome
from funcionario
where numero not in (select numerofuncger from departamento where numerofuncger is not null);

/* 25. Liste todos os dados de todos os funcionários que ganham mais do que algum
gerente de qualquer departamento. */

select f.*
from funcionario f
where f.salario > (select min(salario) from funcionario f, departamento d where f.numero = d.numerofuncger);

/* 26. Liste todos os dados de todos os funcionários que ganham mais do que todos
gerente de qualquer departamento. */

select f.*
from funcionario f
where f.salario > (select max(salario) from funcionario f, departamento d where f.numero = d.numerofuncger);
