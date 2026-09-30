DROP DATABASE IF EXISTS agroindustria_db;
GO

CREATE DATABASE agroindustria_db;
GO

USE agroindustria_db;
GO

CREATE TABLE setor (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(40) NOT NULL,
    descricao TEXT
);
GO

CREATE TABLE medidas (
    id INT PRIMARY KEY IDENTITY(1,1),
    id_setor INT NOT NULL,
    data_hora DATETIME NOT NULL,
    variavel VARCHAR(20) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_setor) REFERENCES setor(id)
);
GO

INSERT INTO setor (nome, descricao)
VALUES
('Moagem',
 'Responsável pela extração do caldo da cana-de-açúcar.'),

('Clarificação',
 'Remove impurezas do caldo e ajusta pH.'),

('Evaporação',
 'Concentra o caldo por remoção de água.'),

('Fermentação',
 'Converte açúcares em etanol através de leveduras.'),

('Destilação',
 'Separa o etanol produzido na fermentação.'),

('Caldeira',
 'Gera vapor para os processos industriais.');
GO

INSERT INTO medidas (id_setor, data_hora, variavel, valor)
VALUES
(1, '2025-10-09 08:00:00', 'VAZÃO', 210.50),
(1, '2025-10-09 08:10:00', 'TEMP', 32.80),
(2, '2025-10-09 08:20:00', 'PH', 6.45),
(2, '2025-10-09 08:30:00', 'BRIX', 13.20),
(3, '2025-10-09 08:40:00', 'TEMP', 78.50),
(3, '2025-10-09 08:50:00', 'BRIX', 36.70),
(4, '2025-10-09 09:00:00', 'PH', 4.60),
(4, '2025-10-09 09:10:00', 'TEMP', 33.90),
(5, '2025-10-09 09:20:00', 'ETOH', 92.10),
(6, '2025-10-09 09:30:00', 'PRESSÃO', 17.80);
GO

SELECT *
FROM setor;
GO

SELECT *
FROM medidas;
GO

SELECT
    id,
    variavel,
    valor,
    data_hora
FROM medidas
ORDER BY data_hora DESC;
GO

SELECT
    id,
    id_setor,
    data_hora,
    variavel,
    valor
FROM medidas
WHERE variavel = 'TEMP'
ORDER BY valor ASC;
GO

SELECT
    id,
    id_setor,
    data_hora,
    variavel,
    valor
FROM medidas
WHERE variavel = 'BRIX'
  AND valor BETWEEN 30 AND 80
ORDER BY valor ASC;
GO

SELECT
    variavel,
    COUNT(*) AS quantidade_medidas
FROM medidas
WHERE variavel IN ('VAZÃO', 'TEMP', 'PH', 'BRIX', 'ETOH')
GROUP BY variavel
ORDER BY quantidade_medidas DESC;
GO

SELECT
    variavel,
    AVG(valor) AS valor_medio
FROM medidas
WHERE variavel IN ('VAZÃO', 'TEMP', 'PH', 'BRIX', 'ETOH')
GROUP BY variavel
ORDER BY valor_medio DESC;
GO

SELECT
    variavel,
    MIN(valor) AS valor_minimo,
    MAX(valor) AS valor_maximo
FROM medidas
WHERE variavel IN ('VAZÃO', 'TEMP', 'PH', 'BRIX', 'ETOH')
GROUP BY variavel
ORDER BY variavel ASC;
GO

SELECT
    s.nome AS setor,
    AVG(m.valor) AS media_temp
FROM setor AS s
INNER JOIN medidas AS m
    ON s.id = m.id_setor
WHERE m.variavel = 'TEMP'
GROUP BY s.nome
ORDER BY media_temp DESC;
GO

SELECT
    s.nome AS setor,
    MIN(m.valor) AS menor_etoh,
    MAX(m.valor) AS maior_etoh
FROM setor AS s
INNER JOIN medidas AS m
    ON s.id = m.id_setor
WHERE m.variavel = 'ETOH'
GROUP BY s.nome
ORDER BY s.nome ASC;
GO

SELECT
    s.nome AS setor,
    COUNT(m.id) AS total_medicoes
FROM setor AS s
LEFT JOIN medidas AS m
    ON s.id = m.id_setor
GROUP BY s.nome
ORDER BY total_medicoes DESC;
GO
