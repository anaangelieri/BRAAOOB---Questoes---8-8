drop schema AOOB;
create schema AOOB;
use AOOB;
CREATE TABLE Usuario (
  id_usuario INT PRIMARY KEY,
  nome VARCHAR(300),
  email VARCHAR(245),
  senha VARCHAR(40),
  INDEX(nome)
);

CREATE TABLE Jogo (
  id_jogo INT PRIMARY KEY,
  vidas INT,
  feito TINYINT
);

CREATE TABLE Questao (
  id_questao INT PRIMARY KEY,
  textoPergunta TEXT(500),
  id_usuario INT,
  id_jogo INT,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_jogo) REFERENCES Jogo(id_jogo)
);

CREATE TABLE Andar (
  numero INT,
  concluido TINYINT,
  Usuario_nome VARCHAR(300),
  Jogo_id_jogo INT,
  PRIMARY KEY (numero, Jogo_id_jogo),
  FOREIGN KEY (Usuario_nome) REFERENCES Usuario(nome),
  FOREIGN KEY (Jogo_id_jogo) REFERENCES Jogo(id_jogo)
);

CREATE TABLE Alternativa_Correta (
  idAlternativa_Correta INT PRIMARY KEY,
  textoAlternativa TEXT(500)
);

CREATE TABLE Alternativa (
  id_alternativa INT PRIMARY KEY,
  textoAlternativa TEXT(500),
  Questao_id_questao INT,
  FOREIGN KEY (Questao_id_questao) REFERENCES Questao(id_questao)
);

INSERT INTO Usuario (id_usuario, nome, email, senha) VALUES (1, 'Teste Usuário', 'teste@exemplo.com', 'senha123');

-- Inserir um jogo
INSERT INTO Jogo (id_jogo, vidas, feito) VALUES (1, 3, 0);

-- Inserir uma nova pergunta, substitua os IDs e dados conforme necessário
INSERT INTO Questao (id_questao, textoPergunta, id_usuario, id_jogo) VALUES (1, 'Qual é o número de emergência que você deve ligar em caso de incêndio?', 1, 1);

-- Inserir alternativas para a nova pergunta
INSERT INTO Alternativa (id_alternativa, textoAlternativa, Questao_id_questao) VALUES 
(1, '190', 1),
(2, '193', 1),
(3, '192', 1),
(4, '194', 1);

-- Inserir a alternativa correta
INSERT INTO Alternativa_Correta (idAlternativa_Correta, textoAlternativa) VALUES (1, '193');
