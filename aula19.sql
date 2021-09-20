-- a) Crie a tabela Livro escolhendo os domínios apropriados para cada atributo.
create table livro(
	codigo integer,
	titulo varchar(30),
	genero varchar(30),
	edicao integer,
	ano_edicao char(4),
	data_aquisicao date,
	valor_diaria_emprestimo double,
	cpf_venda varchar(11),
	valor_venda double,
	data_venda date,
	primary key(codigo),
	foreign key(cpf_venda) references cliente(cpf));

-- b) Altere o domínio do atributo gênero da tabela Livro para Varchar(40).
alter table livro modify genero varchar(40);

-- c) Inclua o atributo editora na tabela Livro.
alter table livro add editora varchar(30);

-- d) Exclua o atributo edição da tabela Livro.
alter table livro drop edicao;

-- e) Considerando o esquema original, insira um registro de valores na tabela Livro sem os dados de venda do livro.
insert into livro(codigo, titulo, genero, ano_edicao, data_aquisicao, valor_diaria_emprestimo, edicao) values(1, 'A Seleção', 'romance', '2011', '2021-03-25', 6.00, 'adaptada para o português');

-- f) Atualize os dados do livro que você acabou de inserir com os dados de venda para um cliente fictício usando apenas um comando.
update livro set cpf_venda = '12365498701', valor_venda = 32.90, data_venda = '2021-05-08' where codigo = 1;

-- g) Remova esse mesmo registro da tabela Livro.
delete from livro where codigo = 1;

-- h) Selecione todos os dados dos clientes da cidade de Paquetá em ordem descendente de nome e ascendente de CPF.
select * from cliente where cidade like 'Paquetá' order by nome desc cpf asc;

-- i) Selecione o CPF e o nome de todos os clientes que possuam “ALVES” em seu nome.
select cpf, nome from cliente where nome like '%ALVES%';

-- j) Selecione todos os dados de todos os livros cujo gênero seja romance e que sejam da editora Abril.
select * from livro where genero like 'romance' and editora like 'Abril';

-- k) Selecione todos os dados do livro de código 71234 e seus respectivos autores.
select l.*, a.*
from livro l, autor a
where l.codigo = a.codigo and l.codigo = 71234;

-- l) Selecione o CPF e o nome dos clientes, o código, o título e o gênero dos livros que foram emprestados no dia 20/11/2019.
select c.cpf, c.nome, l.codigo, l.titulo, l.genero, e.data_emprestimo
from cliente c, livro l, emprestimo e
where l.codigo = e.codigo and c.cpf = e.cpf and e.data_emprestimo = '2019-11-20';

-- m) Selecione todos os dados de todos os livros cadastrados no sebo e para aqueles que já foram vendidos mostre também o CPF e o nome dos clientes que realizaram a
-- compra. 
select l.*, c.cpf, c.nome
from (livro l left join cliente c 
	on c.cpf = l.cpf_venda);

-- n) Selecione todos os dados dos livros que nunca foram emprestados.
select l.* from livro l where not exists (
	select e.codigo from emprestimo e where l.codigo = e.codigo);
-- ou
select l.* from livro l where l.codigo not in (
	select distinct codigo from emprestimo);

-- o) Selecione todos os dados do livro mais barato para empréstimo.
select * from livro where valor_diaria_emprestimo = (select min(valor_diaria_emprestimo) from livro);

-- p) Selecione todos os dados dos livros já vendidos que possuíam valor da diária de aluguel entre R$20,00 e R$40,00 (inclusive).
select * from livro where cpf_venda is not null and valor_venda is not null and data_venda is not null and valor_diaria_emprestimo between 20 and 40;

-- q) Selecione todos os dados dos livros que possuem o valor de diária de empréstimo maior do que todos os valores das diárias dos livros que já foram emprestados.
select * from livro where valor_diaria_emprestimo > all (
	select distinct valor_diaria_emprestimo from livro l, emprestimo e where l.codigo = e.codigo);
-- ou
select * from livro where valor_diaria_emprestimo > (
	select max(l.valor_diaria_emprestimo) from livro l, emprestimo e where l.codigo = e.codigo);

-- r) Mostre o valor médio das diárias de empréstimo dos livros que estão disponíveis para empréstimo separados por gênero. (Disponível = não vendido)
select genero, avg(valor_diaria_emprestimo) from livro where cpf_venda is null and valor_venda is null and data_venda is null group by genero;

-- s) Mostre o ano de edição e a quantidade de livros cadastrados por ano de edição para os anos que possuírem no mínimo 5 livros cadastrados.
select ano_edicao, count(*) as quantidade from livro group by ano_edicao having quantidade >= 5;

-- t) Selecione todos os dados dos clientes que nunca emprestaram livros e dos livros que nunca foram emprestados.
select e.*, l.codigo from (
	livro l left join emprestimo e on l.codigo = e.codigo) where e.data_emprestimo is null
union select e.*, c.cpf from (
	emprestimo e right join cliente c on c.cpf = e.cpf) where e.data_emprestimo is null;