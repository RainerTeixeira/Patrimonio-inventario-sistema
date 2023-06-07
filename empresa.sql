-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 07/06/2023 às 13:06
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `documentacao`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `topicos`
--

CREATE TABLE `topicos` (
  `id` int(11) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `conteudo` text DEFAULT NULL,
  `imagem_url` varchar(255) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `setor_permitido` varchar(50) DEFAULT NULL,
  `topico_pai_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `topicos`
--

INSERT INTO `topicos` (`id`, `titulo`, `descricao`, `conteudo`, `imagem_url`, `video_url`, `setor_permitido`, `topico_pai_id`) VALUES
(1, '1. Recrutamento e Seleção', 'Processo de Recrutamento', 'O processo de recrutamento envolve a divulgação de vagas, triagem de currículos, entrevistas e seleção dos candidatos adequados.', '', '', 'RH', NULL),
(2, '1.1 Subtópico', 'Descrição do Subtópico', 'Conteúdo do Subtópico', 'url_imagem2.jpg', 'url_video2.mp4', 'RH', 1),
(3, '1.2 Subtópico', 'Descrição do Subtópico', 'Conteúdo do Subtópico', 'url_imagem3.jpg', 'url_video3.mp4', 'RH', 1),
(4, '2. Segurança da Informação', 'Políticas de Segurança', 'As políticas de segurança da informação visam proteger os dados e informações da empresa, abrangendo medidas como senhas seguras, controle de acesso e criptografia.', '', '', 'TI', NULL),
(5, '2.1 Subtópico', 'Descrição do Subtópico', 'Conteúdo do Subtópico', 'url_imagem5.jpg', 'url_video5.mp4', 'TI', 4),
(6, '3. Fornecedores', 'Seleção de Fornecedores', 'A seleção de fornecedores envolve a análise de qualidade, prazos de entrega, preços competitivos e histórico de fornecimento.', '', '', 'Compras', NULL),
(7, '3.1 Negociação com Fornecedores', 'Estratégias de Negociação', 'As estratégias de negociação com fornecedores visam obter condições comerciais favoráveis, como descontos, prazos de pagamento e contratos vantajosos.', '', '', 'Compras', 6),
(8, '3.1.1 Estabelecimento de Parcerias', 'Critérios para Parcerias', 'Os critérios para estabelecer parcerias com fornecedores incluem a avaliação de reputação, capacidade de entrega e alinhamento com os valores da empresa.', '', '', 'Compras', 7),
(9, '3.1.2 Avaliação de Desempenho', 'Monitoramento de Fornecedores', 'O monitoramento de desempenho dos fornecedores é realizado para garantir a qualidade dos produtos ou serviços, cumprimento de prazos e atendimento às expectativas da empresa.', '', '', 'Compras', 7),
(10, '3.1.2.1 Indicadores de Desempenho', 'Métricas de Avaliação', 'Os indicadores de desempenho permitem medir e acompanhar o desempenho dos fornecedores, utilizando métricas como qualidade, tempo de entrega e índice de satisfação.', '', '', 'Compras', 9),
(11, '3.1.2.2 Planos de Melhoria', 'Ações de Aprimoramento', 'Os planos de melhoria são elaborados com base nos resultados da avaliação de desempenho, visando aprimorar a performance dos fornecedores por meio de ações corretivas e preventivas.', '', '', 'Compras', 9),
(12, '4. Controle de Estoque', 'Inventário de Estoque', 'O inventário de estoque consiste na contagem física dos produtos disponíveis, verificação de validade e identificação de possíveis divergências com o sistema de gestão.', '', '', 'Estoque', NULL),
(13, '5. Faturamento Eletrônico', 'Emissão de Notas Fiscais Eletrônicas', 'A emissão de notas fiscais eletrônicas é realizada por meio de sistemas informatizados, seguindo as exigências legais e garantindo a correta emissão e envio aos clientes.', '', '', 'Faturamento', NULL),
(14, '6. Abordagem de Vendas por Telefone', 'Técnicas de Abordagem', 'As técnicas de abordagem de vendas por telefone incluem a identificação do cliente, argumentação persuasiva e tratamento de objeções para conquistar a venda.', '', '', 'Televendas', NULL),
(15, '7. Negociação de Vendas', 'Técnicas de Negociação', 'As técnicas de negociação de vendas envolvem o entendimento das necessidades do cliente, apresentação de propostas personalizadas e fechamento de acordos vantajosos.', '', '', 'Vendedores', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `setor` varchar(50) DEFAULT NULL,
  `nivel_permissao` enum('Administrador','Usuário') NOT NULL,
  `senha` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `setor`, `nivel_permissao`, `senha`) VALUES
(1, 'João', 'TI', 'Administrador', 'senha1'),
(2, 'Maria', 'RH', 'Usuário', 'senha2'),
(3, 'Pedro', 'Compras', 'Usuário', 'senha3'),
(4, 'Ana', 'Estoque', 'Usuário', 'senha4'),
(5, 'Carlos', 'Faturamento', 'Usuário', 'senha5'),
(6, 'Fernanda', 'Televendas', 'Usuário', 'senha6'),
(7, 'Luis', 'Vendedores', 'Usuário', 'senha7');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `topicos`
--
ALTER TABLE `topicos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `topico_pai_id` (`topico_pai_id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `topicos`
--
ALTER TABLE `topicos`
  ADD CONSTRAINT `topicos_ibfk_1` FOREIGN KEY (`topico_pai_id`) REFERENCES `topicos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
