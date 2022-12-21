.mode columns
.header on
.nullvalue NULL

--Quantos jogos cada equipa ganhou, perdeu e empatou na fase Regular do campeonato

select e.nome as equipa, 
       sum(case when j.golosMarcadosVisitante > j.golosMarcadosVisitado and e.nome = j.nomeEquipaVisitante then 1 else 0 end) as jogosGanhosRegular,
       sum(case when j.golosMarcadosVisitante < j.golosMarcadosVisitado and e.nome = j.nomeEquipaVisitante then 1 else 0 end) as jogosPerdidosRegular,
       sum(case when j.golosMarcadosVisitante = j.golosMarcadosVisitado and e.nome = j.nomeEquipaVisitante then 1 else 0 end) as jogosEmpatadosRegular
from Equipa e
join Jogo j on e.nome in (j.nomeEquipaVisitante, j.nomeEquipaVisitada)
where j.fasePlayOff is null
group by e.nome;
