DROP TABLE IF EXISTS Pessoa;
CREATE TABLE Pessoa (
    idPessoa INTEGER PRIMARY KEY, 
    primeiroNome VARCHAR (75) NOT NULL, 
    segundoNome VARCHAR (75), 
    idade INTEGER (75) NOT NULL, 
    pais VARCHAR (75) NOT NULL
);

DROP TABLE IF EXISTS Arbitro;
CREATE TABLE Arbitro (
    idArbitro INTEGER PRIMARY KEY REFERENCES Pessoa (idPessoa) ON DELETE CASCADE ON UPDATE CASCADE, 
    distrito VARCHAR (75) NOT NULL
);

DROP TABLE IF EXISTS Equipa;
CREATE TABLE Equipa (
    nome VARCHAR (150) PRIMARY KEY, 
    email VARCHAR (150) UNIQUE NOT NULL, 
    telefone VARCHAR (150) UNIQUE NOT NULL, 
    morada VARCHAR (150) NOT NULL UNIQUE, 
    pontuacaoTotal INTEGER DEFAULT (0), 
    golosMarcados INTEGER DEFAULT (0), 
    golosSofridos INTEGER DEFAULT (0), 
    diferencaGolos INTEGER AS (golosMarcados - golosSofridos), 
    jogosGanhos INTEGER DEFAULT (0), 
    jogosEmpatados INTEGER DEFAULT (0)
);

DROP TABLE IF EXISTS Pavilhao;
CREATE TABLE Pavilhao (
    idPavilhao INTEGER PRIMARY KEY, 
    nome VARCHAR (75) NOT NULL, 
    cidade VARCHAR (75) NOT NULL, 
    lotacao INTEGER NOT NULL, 
    equipa VARCHAR (75) REFERENCES Equipa (nome) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Treinador;
CREATE TABLE Treinador (
    idTreinador INTEGER PRIMARY KEY REFERENCES Pessoa (idPessoa) ON DELETE CASCADE ON UPDATE CASCADE, 
    equipa VARCHAR (75) REFERENCES Equipa (nome) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Jogador;
CREATE TABLE Jogador (
    idJogador INTEGER PRIMARY KEY REFERENCES Pessoa (idPessoa) ON DELETE CASCADE ON UPDATE CASCADE, 
    numeroCamisola INTEGER CHECK (1 < numeroCamisola < 99) NOT NULL, 
    posicao VARCHAR (75) NOT NULL, 
    equipa VARCHAR (75) REFERENCES Equipa (nome) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL
);

DROP TABLE IF EXISTS Jornada;
CREATE TABLE Jornada (
    numero INTEGER PRIMARY KEY, 
    dataInicio VARCHAR (75) UNIQUE NOT NULL, 
    dataFim VARCHAR (75) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS Playoff;
CREATE TABLE Playoff (
    fase VARCHAR (75) PRIMARY KEY CHECK (fase = "QUARTOS-DE-FINAL" or fase = "MEIAS-FINAIS" or fase = "FINAL") NOT NULL, 
    dataInicio VARCHAR (75) UNIQUE NOT NULL, 
    dataFim VARCHAR (75) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS Jogo;
CREATE TABLE Jogo (
    idJogo INTEGER PRIMARY KEY, 
    data VARCHAR (75) NOT NULL, 
    golosMarcadosVisitante INTEGER CHECK (golosMarcadosVisitante >= 0 ) NOT NULL, 
    golosMarcadosVisitado INTEGER CHECK (golosMarcadosVisitado >= 0) NOT NULL, 
    nomeEquipaVisitada VARCHAR (75) REFERENCES Equipa (nome) ON DELETE CASCADE ON UPDATE CASCADE, 
    nomeEquipaVisitante VARCHAR (75) REFERENCES Equipa (nome) ON DELETE CASCADE ON UPDATE CASCADE, 
    arbitro INTEGER REFERENCES Pessoa (idPessoa) ON DELETE CASCADE ON UPDATE CASCADE, 
    numeroJornada INTEGER REFERENCES Jornada (numero) ON DELETE CASCADE ON UPDATE CASCADE, 
    fasePlayOff VARCHAR (75) REFERENCES Playoff (fase) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS GoloMarcado;
CREATE TABLE GoloMarcado (
    idGolo INTEGER PRIMARY KEY, 
    minuto INTEGER NOT NULL, 
    idJogador INTEGER REFERENCES Jogador (idJogador) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL, 
    idJogo INTEGER REFERENCES Jogo (idJogo) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL
);