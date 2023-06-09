-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 09-Jun-2023 às 06:11
-- Versão do servidor: 10.4.28-MariaDB
-- versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `empresa`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `alarmes`
--

CREATE TABLE `alarmes` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `localizacao_fisica` varchar(50) DEFAULT NULL,
  `descricao` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `alarmes`
--

INSERT INTO `alarmes` (`id`, `nome`, `localizacao_fisica`, `descricao`) VALUES
(1, 'Central', 'Escritorio', 'Alarme Central Possui 04 sensores.');

-- --------------------------------------------------------

--
-- Estrutura da tabela `banco_dados`
--

CREATE TABLE `banco_dados` (
  `id` int(11) NOT NULL,
  `software_licenciado` enum('Nao','Sim') NOT NULL,
  `banco_nome` varchar(45) DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `versao` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `banco_dados`
--

INSERT INTO `banco_dados` (`id`, `software_licenciado`, `banco_nome`, `tipo`, `versao`) VALUES
(1, 'Nao', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `cameras`
--

CREATE TABLE `cameras` (
  `id` int(11) NOT NULL,
  `marca_modelo` varchar(45) DEFAULT NULL,
  `localizacao_fisica` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `cameras`
--

INSERT INTO `cameras` (`id`, `marca_modelo`, `localizacao_fisica`) VALUES
(1, 'Intelbras', 'cozinha'),
(2, 'Sony', 'Entrada'),
(3, 'Philco', 'Portaria'),
(4, 'LG', 'Escritorio');

-- --------------------------------------------------------

--
-- Estrutura da tabela `chave_alarme`
--

CREATE TABLE `chave_alarme` (
  `id` int(11) NOT NULL,
  `senha` enum('Nao','Sim') NOT NULL,
  `chave` enum('Nao','Sim') NOT NULL,
  `local_chave` varchar(45) NOT NULL,
  `funcionarios_id` int(11) NOT NULL,
  `alarmes_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `chave_alarme`
--

INSERT INTO `chave_alarme` (`id`, `senha`, `chave`, `local_chave`, `funcionarios_id`, `alarmes_id`) VALUES
(1, 'Sim', 'Nao', 'Portaria', 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `coletor`
--

CREATE TABLE `coletor` (
  `id` int(11) NOT NULL,
  `observacao` varchar(45) DEFAULT NULL,
  `SNID` varchar(20) DEFAULT NULL,
  `modelo` varchar(45) DEFAULT NULL,
  `data_compra` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `coletor`
--

INSERT INTO `coletor` (`id`, `observacao`, `SNID`, `modelo`, `data_compra`) VALUES
(1, 'defeito', '3434343', '3020', '2010-10-10');

-- --------------------------------------------------------

--
-- Estrutura da tabela `componentes_rede`
--

CREATE TABLE `componentes_rede` (
  `id` int(11) NOT NULL,
  `computador_id` int(11) DEFAULT NULL,
  `impressora_id` int(11) DEFAULT NULL,
  `cameras_id` int(11) DEFAULT NULL,
  `roteador_switches_id` int(11) DEFAULT NULL,
  `servidores_id` int(11) DEFAULT NULL,
  `descricao_componente` varchar(50) NOT NULL,
  `endereco_ip` varchar(15) NOT NULL,
  `localizacao_fisica` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `componentes_rede`
--

INSERT INTO `componentes_rede` (`id`, `computador_id`, `impressora_id`, `cameras_id`, `roteador_switches_id`, `servidores_id`, `descricao_componente`, `endereco_ip`, `localizacao_fisica`) VALUES
(1, 1, NULL, NULL, NULL, NULL, 'Roteador Cisco Firewall', '192.168.1.25', 'Mesa TI');

-- --------------------------------------------------------

--
-- Estrutura da tabela `computador`
--

CREATE TABLE `computador` (
  `id` int(11) NOT NULL,
  `funcionarios_id` int(11) DEFAULT NULL,
  `marca_modelo` varchar(50) DEFAULT NULL,
  `placa_mae` varchar(50) DEFAULT NULL,
  `processador` varchar(50) DEFAULT NULL,
  `soquete` varchar(50) DEFAULT NULL,
  `hd` varchar(50) DEFAULT NULL,
  `Possui_ssd` enum('Não','Sim') DEFAULT NULL,
  `memoria` varchar(50) DEFAULT NULL,
  `SNID` varchar(50) DEFAULT NULL,
  `software_licenciado` enum('Nao','Sim') NOT NULL DEFAULT 'Nao',
  `host_name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `computador`
--

INSERT INTO `computador` (`id`, `funcionarios_id`, `marca_modelo`, `placa_mae`, `processador`, `soquete`, `hd`, `Possui_ssd`, `memoria`, `SNID`, `software_licenciado`, `host_name`) VALUES
(1, 1, 'DELL', 'ATX 1050', 'Core I5', '2214', '500 GB', 'Sim', '4 GB', '5645654', 'Nao', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `dispositivos_moveis`
--

CREATE TABLE `dispositivos_moveis` (
  `id` int(11) NOT NULL,
  `funcionarios_id` int(11) DEFAULT NULL,
  `pacote_serviços_id` int(11) DEFAULT NULL,
  `data_obeteve` date DEFAULT NULL,
  `data_entregou` date NOT NULL,
  `marca_modelo` varchar(45) DEFAULT NULL,
  `IMEI` varchar(16) DEFAULT NULL,
  `dispositivo` enum('Tablet','Celular') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `dispositivos_moveis`
--

INSERT INTO `dispositivos_moveis` (`id`, `funcionarios_id`, `pacote_serviços_id`, `data_obeteve`, `data_entregou`, `marca_modelo`, `IMEI`, `dispositivo`) VALUES
(1, 1, 1, '0000-00-00', '2023-05-30', NULL, NULL, 'Celular');

-- --------------------------------------------------------

--
-- Estrutura da tabela `emails`
--

CREATE TABLE `emails` (
  `id` int(11) NOT NULL,
  `endereco` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `emails`
--

INSERT INTO `emails` (`id`, `endereco`) VALUES
(1, 'desenvolvmento6@innovus.com.br');

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionarios`
--

CREATE TABLE `funcionarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `ativo` enum('Ativo','Desligado') NOT NULL,
  `ramal` int(11) DEFAULT NULL,
  `login` varchar(45) DEFAULT NULL,
  `senha` varchar(45) DEFAULT NULL,
  `nivel_permissao` enum('Administrador','Usuário') DEFAULT NULL,
  `funcao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `funcionarios`
--

INSERT INTO `funcionarios` (`id`, `nome`, `ativo`, `ramal`, `login`, `senha`, `nivel_permissao`, `funcao`) VALUES
(1, 'Rainer Teixeira', 'Ativo', 22644, 'Rainer', '98152749', 'Administrador', 1),
(2, 'pedro alves cabral', 'Ativo', 433, 'pedro', 'pedro', 'Administrador', 3),
(3, 'admin', 'Ativo', 11, 'admin', 'admin', 'Administrador', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionarios_emails`
--

CREATE TABLE `funcionarios_emails` (
  `id` int(11) NOT NULL,
  `funcionarios_id` int(11) NOT NULL,
  `emails_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `funcionarios_emails`
--

INSERT INTO `funcionarios_emails` (`id`, `funcionarios_id`, `emails_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionarios_possui_coletor`
--

CREATE TABLE `funcionarios_possui_coletor` (
  `id` int(11) NOT NULL,
  `coletor_id` int(11) NOT NULL,
  `funcionarios_id` int(11) NOT NULL,
  `data_saida` datetime NOT NULL,
  `data_entrada` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `funcionarios_possui_coletor`
--

INSERT INTO `funcionarios_possui_coletor` (`id`, `coletor_id`, `funcionarios_id`, `data_saida`, `data_entrada`) VALUES
(1, 1, 1, '2023-05-30 14:30:00', '2023-05-30 14:40:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `imagem_topicos`
--

CREATE TABLE `imagem_topicos` (
  `id` int(11) NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  `topico_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `impressora`
--

CREATE TABLE `impressora` (
  `id` int(11) NOT NULL,
  `marca_modelo` varchar(45) DEFAULT NULL,
  `tipo` enum('Matricial','Jato de Tinta','Laser') DEFAULT NULL,
  `localizacao_fisica` varchar(45) DEFAULT NULL,
  `funciona` varchar(45) DEFAULT NULL,
  `impressoracol` enum('Ativo','Defeito') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `impressora`
--

INSERT INTO `impressora` (`id`, `marca_modelo`, `tipo`, `localizacao_fisica`, `funciona`, `impressoracol`) VALUES
(1, 'Epson', 'Jato de Tinta', 'Faturamento', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `licencas_software`
--

CREATE TABLE `licencas_software` (
  `id` int(11) NOT NULL,
  `servidores_id` int(11) DEFAULT NULL,
  `computador_id` int(11) DEFAULT NULL,
  `banco_dados_id` int(11) DEFAULT NULL,
  `decricao_licenca` varchar(100) DEFAULT NULL,
  `numero_licenca` varchar(100) DEFAULT NULL,
  `validade` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `licencas_software`
--

INSERT INTO `licencas_software` (`id`, `servidores_id`, `computador_id`, `banco_dados_id`, `decricao_licenca`, `numero_licenca`, `validade`) VALUES
(1, 1, 1, NULL, 'Windows 10 pro', '287456-654555-4445545-55', '2010-10-10');

-- --------------------------------------------------------

--
-- Estrutura da tabela `manual`
--

CREATE TABLE `manual` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `manual`
--

INSERT INTO `manual` (`id`, `nome`) VALUES
(1, 'Manual TI'),
(2, 'Manual COMPRAS'),
(3, 'Manual FATURAMENTO'),
(4, 'Manual RH'),
(5, 'Manual ESTOQUE');

-- --------------------------------------------------------

--
-- Estrutura da tabela `manual_permisao`
--

CREATE TABLE `manual_permisao` (
  `manual_id` int(11) NOT NULL,
  `setor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `manual_permisao`
--

INSERT INTO `manual_permisao` (`manual_id`, `setor_id`) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 1),
(3, 3),
(4, 4),
(4, 5),
(5, 1),
(5, 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `mesa_cadeira`
--

CREATE TABLE `mesa_cadeira` (
  `id` int(11) NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `etiqueta_Inventário_mesa` int(11) DEFAULT NULL,
  `etiqueta_Inventário_cadeira` int(11) DEFAULT NULL,
  `funcionarios_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `mesa_cadeira`
--

INSERT INTO `mesa_cadeira` (`id`, `descricao`, `etiqueta_Inventário_mesa`, `etiqueta_Inventário_cadeira`, `funcionarios_id`) VALUES
(1, 'Balcao', 1498134, 2665264, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pacote_serviços`
--

CREATE TABLE `pacote_serviços` (
  `id` int(11) NOT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `numero_telefone` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `pacote_serviços`
--

INSERT INTO `pacote_serviços` (`id`, `descricao`, `valor`, `numero_telefone`) VALUES
(1, 'Whatapp ilimitado', 39.90, '219999137382');

-- --------------------------------------------------------

--
-- Estrutura da tabela `projeto`
--

CREATE TABLE `projeto` (
  `id` int(11) NOT NULL,
  `nome` text NOT NULL,
  `status` decimal(5,2) NOT NULL,
  `data_inicio` date NOT NULL,
  `data_fim` date DEFAULT NULL,
  `projeto_descricao` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `projeto`
--

INSERT INTO `projeto` (`id`, `nome`, `status`, `data_inicio`, `data_fim`, `projeto_descricao`) VALUES
(1, 'Desnvolvimento E-Commerce', 10.00, '2023-05-30', NULL, 'Desnvolvimento com javascript o site de eccomerce para vendas de peças');

-- --------------------------------------------------------

--
-- Estrutura da tabela `projeto_execucao`
--

CREATE TABLE `projeto_execucao` (
  `id` int(11) NOT NULL,
  `funcionarios_id` int(11) NOT NULL,
  `projeto_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `projeto_execucao`
--

INSERT INTO `projeto_execucao` (`id`, `funcionarios_id`, `projeto_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `racks`
--

CREATE TABLE `racks` (
  `id` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `localizacao_fisica` varchar(45) NOT NULL,
  `roteador_switches_id` int(11) NOT NULL,
  `servidores_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `roteador_switches`
--

CREATE TABLE `roteador_switches` (
  `id` int(11) NOT NULL,
  `modelo_equipamento` varchar(45) NOT NULL,
  `SNID` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `roteador_switches`
--

INSERT INTO `roteador_switches` (`id`, `modelo_equipamento`, `SNID`) VALUES
(1, 'Cisco 2350', '5665565665');

-- --------------------------------------------------------

--
-- Estrutura da tabela `sensores`
--

CREATE TABLE `sensores` (
  `id` varchar(45) NOT NULL,
  `alarmes_id` int(11) NOT NULL,
  `local` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `sensores`
--

INSERT INTO `sensores` (`id`, `alarmes_id`, `local`) VALUES
('1', 1, 'cozinha'),
('2', 1, 'escritorio'),
('3', 1, 'portaria');

-- --------------------------------------------------------

--
-- Estrutura da tabela `servidores`
--

CREATE TABLE `servidores` (
  `id` int(11) NOT NULL,
  `nome_servidor` varchar(100) NOT NULL,
  `marca_modelo` varchar(50) DEFAULT NULL,
  `placa_mae` varchar(50) DEFAULT NULL,
  `processador` varchar(50) DEFAULT NULL,
  `soquete` varchar(50) DEFAULT NULL,
  `hd` varchar(50) DEFAULT NULL,
  `memoria` varchar(50) DEFAULT NULL,
  `SNID` varchar(50) DEFAULT NULL,
  `banco_dados_id` int(11) DEFAULT NULL,
  `possui_ssd` enum('Não','Sim') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `servidores`
--

INSERT INTO `servidores` (`id`, `nome_servidor`, `marca_modelo`, `placa_mae`, `processador`, `soquete`, `hd`, `memoria`, `SNID`, `banco_dados_id`, `possui_ssd`) VALUES
(1, 'Servidor Arquivo', 'HP', 'MSI ABC', 'XEON 1020', '454', '1 TB', '10 GB', '65656556', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `setor`
--

CREATE TABLE `setor` (
  `id` int(11) NOT NULL,
  `nome_setor` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `setor`
--

INSERT INTO `setor` (`id`, `nome_setor`) VALUES
(1, 'Tecnologia da informação'),
(2, 'Compras'),
(3, 'Financeiro'),
(4, 'Vendas'),
(5, 'RH');

-- --------------------------------------------------------

--
-- Estrutura da tabela `setor_funcao`
--

CREATE TABLE `setor_funcao` (
  `id` int(11) NOT NULL,
  `nome_funcao` varchar(45) DEFAULT NULL,
  `setor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `topico`
--

CREATE TABLE `topico` (
  `id` int(11) NOT NULL,
  `manual_id` int(11) NOT NULL,
  `titulo` varchar(45) DEFAULT NULL,
  `conteudo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `topico`
--

INSERT INTO `topico` (`id`, `manual_id`, `titulo`, `conteudo`) VALUES
(1, 1, 'Como alterar o IP', 'Conteúdo do tópico 1 '),
(2, 1, 'Como formatar', 'Conteúdo do tópico 2'),
(3, 1, 'como resetar impressora', 'Conteúdo do tópico 3'),
(4, 1, 'Carga Média Tributária', 'Acessar o site: https://deolhonoimposto.ibpt.org.br/ <br>'),
(5, 2, 'Instalação do Onclick no notebook (modo servi', 'Conteúdo do tópico 1 '),
(6, 2, 'como cadastrar no sistema', 'Conteúdo do tópico 2'),
(7, 2, 'como fazer XMLs', 'Conteúdo do tópico 3'),
(8, 3, 'como faturar nota fiscal', 'Conteúdo do tópico 1 '),
(9, 4, 'como cadastrar funcionario', 'Conteúdo do tópico 1 '),
(10, 5, 'como dar entrada produto', 'Conteúdo do tópico 1 ');

-- --------------------------------------------------------

--
-- Estrutura da tabela `uniforme`
--

CREATE TABLE `uniforme` (
  `id` int(11) NOT NULL,
  `tamanho` varchar(45) NOT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `quantidade_disponivel` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `uniforme`
--

INSERT INTO `uniforme` (`id`, `tamanho`, `tipo`, `quantidade_disponivel`) VALUES
(1, 'P', 'Calca', 100),
(2, 'M', 'Blusa', 200),
(3, 'G', 'Blusa', 300);

-- --------------------------------------------------------

--
-- Estrutura da tabela `uniforme_dos_funcionarios`
--

CREATE TABLE `uniforme_dos_funcionarios` (
  `id` varchar(45) NOT NULL,
  `uniforme_id` int(11) NOT NULL,
  `uniforme_tamanho` varchar(45) NOT NULL,
  `funcionarios_id` int(11) NOT NULL,
  `data_entrega` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `uniforme_dos_funcionarios`
--

INSERT INTO `uniforme_dos_funcionarios` (`id`, `uniforme_id`, `uniforme_tamanho`, `funcionarios_id`, `data_entrega`) VALUES
('1', 1, 'p', 1, '2023-05-30');

-- --------------------------------------------------------

--
-- Estrutura da tabela `veiculos`
--

CREATE TABLE `veiculos` (
  `id` int(11) NOT NULL,
  `funcionarios_id` int(11) DEFAULT NULL,
  `placa` varchar(6) NOT NULL,
  `modelo` varchar(45) DEFAULT NULL,
  `ano` year(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `veiculos`
--

INSERT INTO `veiculos` (`id`, `funcionarios_id`, `placa`, `modelo`, `ano`) VALUES
(1, NULL, 'LKK-78', 'Gol 1.6 ', '2022');

-- --------------------------------------------------------

--
-- Estrutura da tabela `video_topicos`
--

CREATE TABLE `video_topicos` (
  `id` int(11) NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  `topico_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `video_topicos`
--

INSERT INTO `video_topicos` (`id`, `url`, `topico_id`) VALUES
(1, 'www.example.com/imagens/imagem1.jpg ', 1),
(2, 'www.example.com/imagens/imagem2.jpg ', 1),
(3, 'www.example.com/imagens/imagem3.jpg ', 2),
(4, 'www.example.com/imagens/imagem4.jpg ', 3),
(5, 'www.example.com/imagens/imagem5.jpg ', 4);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `alarmes`
--
ALTER TABLE `alarmes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `banco_dados`
--
ALTER TABLE `banco_dados`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `cameras`
--
ALTER TABLE `cameras`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `chave_alarme`
--
ALTER TABLE `chave_alarme`
  ADD KEY `fk_sdsdd_funcionarios1` (`funcionarios_id`),
  ADD KEY `fk_chave_alarme_alarmes1` (`alarmes_id`);

--
-- Índices para tabela `coletor`
--
ALTER TABLE `coletor`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `componentes_rede`
--
ALTER TABLE `componentes_rede`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_componentes_rede_computador1` (`computador_id`),
  ADD KEY `fk_componentes_rede_impressora1` (`impressora_id`),
  ADD KEY `fk_componentes_rede_cameras1` (`cameras_id`),
  ADD KEY `fk_componentes_rede_roteador_switches1` (`roteador_switches_id`),
  ADD KEY `fk_componentes_rede_servidores1` (`servidores_id`);

--
-- Índices para tabela `computador`
--
ALTER TABLE `computador`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_computador_funcionarios1` (`funcionarios_id`);

--
-- Índices para tabela `dispositivos_moveis`
--
ALTER TABLE `dispositivos_moveis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_dispositivos_moveis_funcionarios1` (`funcionarios_id`),
  ADD KEY `fk_dispositivos_moveis_pacote_serviços1` (`pacote_serviços_id`);

--
-- Índices para tabela `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `funcionarios_emails`
--
ALTER TABLE `funcionarios_emails`
  ADD PRIMARY KEY (`id`,`funcionarios_id`,`emails_id`),
  ADD KEY `fk_funcionarios_has_emails_funcionarios1` (`funcionarios_id`),
  ADD KEY `fk_funcionarios_has_emails_emails1` (`emails_id`);

--
-- Índices para tabela `funcionarios_possui_coletor`
--
ALTER TABLE `funcionarios_possui_coletor`
  ADD PRIMARY KEY (`id`,`coletor_id`,`funcionarios_id`),
  ADD KEY `fk_funcionarios_has_coletor_funcionarios1` (`funcionarios_id`),
  ADD KEY `fk_funcionarios_has_coletor_coletor1` (`coletor_id`);

--
-- Índices para tabela `imagem_topicos`
--
ALTER TABLE `imagem_topicos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_imagem_topico1` (`topico_id`);

--
-- Índices para tabela `impressora`
--
ALTER TABLE `impressora`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `licencas_software`
--
ALTER TABLE `licencas_software`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_licencas_software_servidores1` (`servidores_id`),
  ADD KEY `fk_licencas_software_computador1` (`computador_id`),
  ADD KEY `fk_licencas_software_banco_dados1` (`banco_dados_id`);

--
-- Índices para tabela `manual`
--
ALTER TABLE `manual`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `manual_permisao`
--
ALTER TABLE `manual_permisao`
  ADD PRIMARY KEY (`manual_id`,`setor_id`),
  ADD KEY `fk_permisao_setor` (`setor_id`);

--
-- Índices para tabela `mesa_cadeira`
--
ALTER TABLE `mesa_cadeira`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_mesa_cadeira_funcionarios1` (`funcionarios_id`);

--
-- Índices para tabela `pacote_serviços`
--
ALTER TABLE `pacote_serviços`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `projeto`
--
ALTER TABLE `projeto`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `projeto_execucao`
--
ALTER TABLE `projeto_execucao`
  ADD PRIMARY KEY (`id`,`funcionarios_id`,`projeto_id`),
  ADD KEY `fk_funcionarios_has_projeto_funcionarios1` (`funcionarios_id`),
  ADD KEY `fk_funcionarios_has_projeto_projeto1` (`projeto_id`);

--
-- Índices para tabela `racks`
--
ALTER TABLE `racks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_racks_roteador_switches1` (`roteador_switches_id`),
  ADD KEY `fk_racks_servidores1` (`servidores_id`);

--
-- Índices para tabela `roteador_switches`
--
ALTER TABLE `roteador_switches`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `sensores`
--
ALTER TABLE `sensores`
  ADD PRIMARY KEY (`alarmes_id`,`id`);

--
-- Índices para tabela `servidores`
--
ALTER TABLE `servidores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_servidores_banco_dados1` (`banco_dados_id`);

--
-- Índices para tabela `setor`
--
ALTER TABLE `setor`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `setor_funcao`
--
ALTER TABLE `setor_funcao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_setor_funcao_setor1` (`setor_id`);

--
-- Índices para tabela `topico`
--
ALTER TABLE `topico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_topico_manual1` (`manual_id`);

--
-- Índices para tabela `uniforme`
--
ALTER TABLE `uniforme`
  ADD PRIMARY KEY (`id`,`tamanho`);

--
-- Índices para tabela `uniforme_dos_funcionarios`
--
ALTER TABLE `uniforme_dos_funcionarios`
  ADD PRIMARY KEY (`id`,`uniforme_id`,`uniforme_tamanho`,`funcionarios_id`),
  ADD KEY `fk_uniforme_has_funcionarios_uniforme1` (`uniforme_id`,`uniforme_tamanho`),
  ADD KEY `fk_uniforme_has_funcionarios_funcionarios1` (`funcionarios_id`);

--
-- Índices para tabela `veiculos`
--
ALTER TABLE `veiculos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_veiculos_funcionarios1` (`funcionarios_id`);

--
-- Índices para tabela `video_topicos`
--
ALTER TABLE `video_topicos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_video_topico1` (`topico_id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alarmes`
--
ALTER TABLE `alarmes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `banco_dados`
--
ALTER TABLE `banco_dados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `cameras`
--
ALTER TABLE `cameras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `coletor`
--
ALTER TABLE `coletor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `componentes_rede`
--
ALTER TABLE `componentes_rede`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `computador`
--
ALTER TABLE `computador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `dispositivos_moveis`
--
ALTER TABLE `dispositivos_moveis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `emails`
--
ALTER TABLE `emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `funcionarios_emails`
--
ALTER TABLE `funcionarios_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `funcionarios_possui_coletor`
--
ALTER TABLE `funcionarios_possui_coletor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `imagem_topicos`
--
ALTER TABLE `imagem_topicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `impressora`
--
ALTER TABLE `impressora`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `licencas_software`
--
ALTER TABLE `licencas_software`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `manual`
--
ALTER TABLE `manual`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `mesa_cadeira`
--
ALTER TABLE `mesa_cadeira`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `pacote_serviços`
--
ALTER TABLE `pacote_serviços`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `projeto`
--
ALTER TABLE `projeto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `projeto_execucao`
--
ALTER TABLE `projeto_execucao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `racks`
--
ALTER TABLE `racks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `roteador_switches`
--
ALTER TABLE `roteador_switches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `servidores`
--
ALTER TABLE `servidores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `setor`
--
ALTER TABLE `setor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `topico`
--
ALTER TABLE `topico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `veiculos`
--
ALTER TABLE `veiculos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `video_topicos`
--
ALTER TABLE `video_topicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `chave_alarme`
--
ALTER TABLE `chave_alarme`
  ADD CONSTRAINT `fk_chave_alarme_alarmes1` FOREIGN KEY (`alarmes_id`) REFERENCES `alarmes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sdsdd_funcionarios1` FOREIGN KEY (`funcionarios_id`) REFERENCES `funcionarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `componentes_rede`
--
ALTER TABLE `componentes_rede`
  ADD CONSTRAINT `fk_componentes_rede_cameras1` FOREIGN KEY (`cameras_id`) REFERENCES `cameras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_componentes_rede_computador1` FOREIGN KEY (`computador_id`) REFERENCES `computador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_componentes_rede_impressora1` FOREIGN KEY (`impressora_id`) REFERENCES `impressora` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_componentes_rede_roteador_switches1` FOREIGN KEY (`roteador_switches_id`) REFERENCES `roteador_switches` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_componentes_rede_servidores1` FOREIGN KEY (`servidores_id`) REFERENCES `servidores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `computador`
--
ALTER TABLE `computador`
  ADD CONSTRAINT `fk_computador_funcionarios1` FOREIGN KEY (`funcionarios_id`) REFERENCES `funcionarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `dispositivos_moveis`
--
ALTER TABLE `dispositivos_moveis`
  ADD CONSTRAINT `fk_dispositivos_moveis_funcionarios1` FOREIGN KEY (`funcionarios_id`) REFERENCES `funcionarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_dispositivos_moveis_pacote_serviços1` FOREIGN KEY (`pacote_serviços_id`) REFERENCES `pacote_serviços` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD CONSTRAINT `fk_funcionarios_setor1` FOREIGN KEY (`funcao`) REFERENCES `setor_funcao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `funcionarios_emails`
--
ALTER TABLE `funcionarios_emails`
  ADD CONSTRAINT `fk_funcionarios_has_emails_emails1` FOREIGN KEY (`emails_id`) REFERENCES `emails` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_funcionarios_has_emails_funcionarios1` FOREIGN KEY (`funcionarios_id`) REFERENCES `funcionarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `funcionarios_possui_coletor`
--
ALTER TABLE `funcionarios_possui_coletor`
  ADD CONSTRAINT `fk_funcionarios_has_coletor_coletor1` FOREIGN KEY (`coletor_id`) REFERENCES `coletor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_funcionarios_has_coletor_funcionarios1` FOREIGN KEY (`funcionarios_id`) REFERENCES `funcionarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `imagem_topicos`
--
ALTER TABLE `imagem_topicos`
  ADD CONSTRAINT `fk_imagem_topico1` FOREIGN KEY (`topico_id`) REFERENCES `topico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `licencas_software`
--
ALTER TABLE `licencas_software`
  ADD CONSTRAINT `fk_licencas_software_banco_dados1` FOREIGN KEY (`banco_dados_id`) REFERENCES `banco_dados` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_licencas_software_computador1` FOREIGN KEY (`computador_id`) REFERENCES `computador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_licencas_software_servidores1` FOREIGN KEY (`servidores_id`) REFERENCES `servidores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `manual_permisao`
--
ALTER TABLE `manual_permisao`
  ADD CONSTRAINT `fk_permisao_manual` FOREIGN KEY (`manual_id`) REFERENCES `manual` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_permisao_setor` FOREIGN KEY (`setor_id`) REFERENCES `setor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `mesa_cadeira`
--
ALTER TABLE `mesa_cadeira`
  ADD CONSTRAINT `fk_mesa_cadeira_funcionarios1` FOREIGN KEY (`funcionarios_id`) REFERENCES `funcionarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `projeto_execucao`
--
ALTER TABLE `projeto_execucao`
  ADD CONSTRAINT `fk_funcionarios_has_projeto_funcionarios1` FOREIGN KEY (`funcionarios_id`) REFERENCES `funcionarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_funcionarios_has_projeto_projeto1` FOREIGN KEY (`projeto_id`) REFERENCES `projeto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `racks`
--
ALTER TABLE `racks`
  ADD CONSTRAINT `fk_racks_roteador_switches1` FOREIGN KEY (`roteador_switches_id`) REFERENCES `roteador_switches` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_racks_servidores1` FOREIGN KEY (`servidores_id`) REFERENCES `servidores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `sensores`
--
ALTER TABLE `sensores`
  ADD CONSTRAINT `fk_table1_alarmes1` FOREIGN KEY (`alarmes_id`) REFERENCES `alarmes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `servidores`
--
ALTER TABLE `servidores`
  ADD CONSTRAINT `fk_servidores_banco_dados1` FOREIGN KEY (`banco_dados_id`) REFERENCES `banco_dados` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `setor_funcao`
--
ALTER TABLE `setor_funcao`
  ADD CONSTRAINT `fk_setor_funcao_setor1` FOREIGN KEY (`setor_id`) REFERENCES `setor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `topico`
--
ALTER TABLE `topico`
  ADD CONSTRAINT `fk_topico_manual1` FOREIGN KEY (`manual_id`) REFERENCES `manual` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `uniforme_dos_funcionarios`
--
ALTER TABLE `uniforme_dos_funcionarios`
  ADD CONSTRAINT `fk_uniforme_has_funcionarios_funcionarios1` FOREIGN KEY (`funcionarios_id`) REFERENCES `funcionarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_uniforme_has_funcionarios_uniforme1` FOREIGN KEY (`uniforme_id`,`uniforme_tamanho`) REFERENCES `uniforme` (`id`, `tamanho`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `veiculos`
--
ALTER TABLE `veiculos`
  ADD CONSTRAINT `fk_veiculos_funcionarios1` FOREIGN KEY (`funcionarios_id`) REFERENCES `funcionarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `video_topicos`
--
ALTER TABLE `video_topicos`
  ADD CONSTRAINT `fk_video_topico1` FOREIGN KEY (`topico_id`) REFERENCES `topico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
