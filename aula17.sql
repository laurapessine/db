select f.numero, f.nome, f.salario
from funcionario f
where f.salario > (select min(salario) from (select f.salario from funcionario f, departamento d where d.numerofuncger = f.numero) as temp);

select f.numero, f.nome, f.salario
from funcionario f
where f.salario > any(select f.salario from funcionario f, departamento d where d.numerofuncger = f.numero);

select f.numero, f.nome, f.salario
from funcionario f
where f.salario > some(select f.salario from funcionario f, departamento d where d.numerofuncger = f.numero);

select f.numero, f.nome, f.salario
from funcionario f
where f.salario > all(select f.salario from funcionario f, departamento d where d.numerofuncger = f.numero);

select s.numero nsuper, s.nome nomesuper, f.numero nfunc, f.nome nomefunc
from funcionario s, funcionario f
where f.numerosuper = s.numero
order by s.numero, f.nome;

select f.numero, f.nome, f.salario
from (funcionario f inner join participafp fp on f.numero = fp.numerofunc)
order by f.numero;

select f.nome, fp.numeroproj, p.nome
from (funcionario f left join participafp fp on f.numero = fp.numerofunc) left join projeto p on fp.numeroproj = p.numero;

update participafp set numeroproj = 3 where numeroproj = 1;

select p.numero, p.nome, fp.numerofunc, f.nome
from (funcionario f right join participafp fp on f.numero = fp.numerofunc) right join projeto p on fp.numeroproj = p.numero;

select p.numero, p.nome, fp.numerofunc, f.nome
from (projeto p right join participafp fp on p.numero = fp.numeroproj) left join funcionario f on fp.numerofunc = f.numero;

select d.numero, d.nome, round(avg(salario), 2) as media_salarial_depto
from departamento d, funcionario f
where d.numero = f.numerodepto
group by f.numerodepto;

select d.numero, d.nome, round(sum(salario), 2) as soma_salarial_depto
from departamento d, funcionario f
where d.numero = f.numerodepto
group by f.numerodepto
having soma_salarial_depto > 10000;
