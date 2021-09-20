select f.numero num_func, f.nome nome_func, p.numero num_proj, p.nome nome_proj
from funcionario f, projeto p, participafp fp
where fp.numerofunc = f.numero and fp.numeroproj = p.numero;

select nome from funcionario where salario is null;
update funcionario set salario = null where numero = 1;
select nome, salario from funcionario where salario is not null;
select round(((select salario from funcionario where numero = 2) + (select salario from funcionario where numero = 3)), 2);
select sum(salario) from funcionario;
select sum(salario) / 12 from funcionario;
select avg(salario) from funcionario;
select max(salario) from funcionario;
select min(salario) from funcionario;
select round(min(salario), 2) from funcionario;
select round(sum(salario), 2) from funcionario;
select count(*) as total_func from funcionario where salario > 3000;
select * from funcionario where salario = (select min(salario) from funcionario);
select max(horas) from participafp;
select f.numero, f.nome, f.salario from funcionario f, participafp fp, where f.numero = fp.numerofunc;
select f.numero, f.nome, f.salario from funcionario f where f.numero in (select numerofunc from participafp);
select distinct numerofunc from participafp;
select f.numero, f.nome, fp.horas from funcionario f, participafp fp where f.numero = fp.numerofunc and fp.horas in ('05:50:50', '11:30:11');
select numero, nome from funcionario f where exists (select * from participafp p where f.numero = p.numerofunc);
