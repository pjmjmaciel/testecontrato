-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Tempo de geração: 18-Abr-2023 às 19:27
-- Versão do servidor: 8.0.32
-- versão do PHP: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `testeLogica`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `Tb_banco`
--

CREATE TABLE `Tb_banco` (
  `codigo` int NOT NULL,
  `nome` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `Tb_banco`
--

INSERT INTO `Tb_banco` (`codigo`, `nome`) VALUES
(1, 'banco 1'),
(2, 'banco 2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `Tb_contrato`
--

CREATE TABLE `Tb_contrato` (
  `codigo` int NOT NULL,
  `prazo` date NOT NULL,
  `valor` float NOT NULL,
  `data_inclusao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `convenio_servico` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `Tb_contrato`
--

INSERT INTO `Tb_contrato` (`codigo`, `prazo`, `valor`, `data_inclusao`, `convenio_servico`) VALUES
(1, '2023-04-19', 5, '2023-04-17 14:33:09', 321),
(2, '2023-04-29', 1, '2023-04-16 14:39:53', 123),
(3, '2023-04-29', 2, '2023-04-15 14:33:09', 124),
(4, '2023-04-29', 3, '2023-04-15 14:33:09', 322),
(5, '2023-04-29', 4, '2023-04-13 14:33:09', 324),
(6, '2023-04-29', 5, '2023-04-14 14:33:09', 325);

-- --------------------------------------------------------

--
-- Estrutura da tabela `Tb_convenio`
--

CREATE TABLE `Tb_convenio` (
  `codigo` int NOT NULL,
  `convenio` varchar(256) NOT NULL,
  `verba` float NOT NULL,
  `banco` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `Tb_convenio`
--

INSERT INTO `Tb_convenio` (`codigo`, `convenio`, `verba`, `banco`) VALUES
(1, 'convenio 1', 5000, 1),
(2, 'conveio 2', 3500, 2),
(3, 'convenio 3', 3500, 1),
(4, 'conveio 4', 5000, 2),
(5, 'convenio 6 bc 1', 5000, 1),
(6, 'convenio 7 bc 1', 5000, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `Tb_convenio_servico`
--

CREATE TABLE `Tb_convenio_servico` (
  `codigo` int NOT NULL,
  `convenio` int NOT NULL,
  `servico` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `Tb_convenio_servico`
--

INSERT INTO `Tb_convenio_servico` (`codigo`, `convenio`, `servico`) VALUES
(123, 2, 'serviço testes convenio 2'),
(124, 3, 'serviço testes convenio 3'),
(321, 1, 'servico testes convenio 3'),
(322, 4, 'servico testes convenio 4'),
(324, 5, 'servico testes convenio 4'),
(325, 6, 'servico testes convenio 7');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `Tb_banco`
--
ALTER TABLE `Tb_banco`
  ADD PRIMARY KEY (`codigo`);

--
-- Índices para tabela `Tb_contrato`
--
ALTER TABLE `Tb_contrato`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_contrato` (`convenio_servico`);

--
-- Índices para tabela `Tb_convenio`
--
ALTER TABLE `Tb_convenio`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_banco` (`banco`);

--
-- Índices para tabela `Tb_convenio_servico`
--
ALTER TABLE `Tb_convenio_servico`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_convenio_servico` (`convenio`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `Tb_banco`
--
ALTER TABLE `Tb_banco`
  MODIFY `codigo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `Tb_contrato`
--
ALTER TABLE `Tb_contrato`
  MODIFY `codigo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `Tb_convenio`
--
ALTER TABLE `Tb_convenio`
  MODIFY `codigo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `Tb_contrato`
--
ALTER TABLE `Tb_contrato`
  ADD CONSTRAINT `fk_contrato` FOREIGN KEY (`convenio_servico`) REFERENCES `Tb_convenio_servico` (`codigo`);

--
-- Limitadores para a tabela `Tb_convenio`
--
ALTER TABLE `Tb_convenio`
  ADD CONSTRAINT `fk_banco` FOREIGN KEY (`banco`) REFERENCES `Tb_banco` (`codigo`);

--
-- Limitadores para a tabela `Tb_convenio_servico`
--
ALTER TABLE `Tb_convenio_servico`
  ADD CONSTRAINT `fk_convenio_servico` FOREIGN KEY (`convenio`) REFERENCES `Tb_convenio` (`codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
