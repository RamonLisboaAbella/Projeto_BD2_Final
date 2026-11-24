-- Pergunta 1 - Quais os tipos de equipamentos que mais chegam na nossa assistencia técnica?

CREATE OR ALTER PROC pr_qtd_tipo_equipamento
AS
BEGIN
    WITH contagem_cte AS (
        SELECT
            T.nome,
            COUNT(E.id_equipamento) AS qtd
        FROM tipo_equipamento T
        INNER JOIN equipamento E
            ON T.id_tipo_equipamento = E.id_tipo_equipamento
        GROUP BY T.nome
    )

    SELECT
        *,
        DENSE_RANK() OVER (
            ORDER BY qtd DESC
        ) AS ranking
    FROM contagem_cte
    ORDER BY ranking;
END;
GO

-- Execução da procedure

EXEC pr_qtd_tipo_equipamento;)

-- Trigger para atualizar a data de conclusão de uma ordem de serviço após a conclusão do pagamento

create or alter trigger tu_pagamento on pagamento for update as
begin
	if exists (
	select *
	from inserted I inner join deleted D on I.id_pagamento = D.id_pagamento
	where I.status != D.status
	)
	begin
		 if exists (
		 select *
		 from inserted
		 where status = 2
		 )
		 begin
			update ordem_servico set dt_conclusao = getdate()
			where id_ordem_servico in (select id_ordem_servico
									   from inserted)									   
		 end
	end
end

-- Execução da trigger

update pagamento set status = 2 where id_pagamento = 9
select * from ordem_servico

-- Tempo de duração da ordem de serviço, desde a data de início até a data de conclusão

create or alter function fn_tempo_servico (@id int) returns int as
begin
	declare @tempo int

	if exists (
		select *
		from ordem_servico
		where id_ordem_servico = @id and dt_conclusao is not null
	)
	begin
		select @tempo = datediff(day,dt_abertura,dt_conclusao) from ordem_servico where id_ordem_servico = @id
	end

	return @tempo
end

-- Execução da function

SELECT dbo.fn_tempo_servico(10) as dias
