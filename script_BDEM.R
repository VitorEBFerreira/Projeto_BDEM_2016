# script roteiro do BDEM - no repositório Projeto_BDEM_2016
# Antes de começar a fazer qualquer coisa:
# a) Coloque todos os arquivos postados no Classroom (já descompactados) dentro do repositório local Projeto_BDEM_2016
# b) commit este roteiro com a mensagem "dados, arquivos de texto e script roteiro BDEM" e envie para o repositório Projeto_BDEM_2016
# c) salve o script com outro nome (script_BDEM.R) e commit com a mensagem "script BDEM" e envie para o repositório Projeto_BDEM_2016

# Ao inserir os comandos em cada Tarefa de cada Etapa, mantenha as linhas de comentários e orientações colocadas pela professora


##################################
# ETAPA 1: BANCO DE DADOS DO SIM
##################################
# Você deve criar e estar na branch SIM antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1. Leitura do banco de dados SIM_2016 com 1309774 linhas e 87 colunas com o nome de dados_sim ####
# Verificar se a leitura foi feita corretamente e a estrutura dos dados

#Leitura do banco
dados_sim = read.csv("SIM_2016.csv",
                     header = T,
                     sep = ";",
                     stringsAsFactors = F)

#Verificando
dim(dados_sim)

#Estrutura
str(dados_sim)
summary(dados_sim)
View(dados_sim)

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SIM - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2. Reduzir dados_sim apenas para as colunas que serão utilizadas, nomeando este novo banco de dados como dados_sim_1####
# As colunas serão: 1, 3, 9, 10, 11, 14, 17, 35, 47
# Nomes das respectivas variáveis: CONTADOR, TIPOBITO, IDADE, SEXO, RACACOR, ESC2010, CODMUNRES, TPMORTEOCO, CAUSABAS

dados_sim_1 = dados_sim[, c(1, 3, 9, 10, 11, 14, 17, 35, 47)]
colnames(dados_sim_1) = c("CONTADOR", "TIPOBITO", "IDADE", "SEXO", "RACACOR", 
                           "ESC2010", "CODMUNRES", "TPMORTEOCO", "CAUSABAS")
dim(dados_sim_1)
names(dados_sim_1)
View(dados_sim_1)

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SIM - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016

# Tarefa 3. Reduzir dados_sim_1 apenas para o estado que o aluno irá trabalhar (utilizar os dois primeiros dígitos de CODMUNRES), nomeando este novo banco de dados como dados_sim_2####
# Códigos das UF: 11: RO, 12: AC, 13: AM, 14: RR, 15: PA, 16: AP, 17: TO, 21: MA, 22: PI, 23: CE, 24: RN
# 25: PB, 26: PE, 27: AL, 28: SE, 29: BA, 31: MG, 32: ES, 33: RJ, 35: SP, 41: PR, 42: SC, 43: RS
# 50: MS, 51: MT, 52: GO, 53: DF

# dados_sim_2 para MT (51)
dados_sim_2 = dados_sim_2 = subset(dados_sim_1, substr(CODMUNRES, 1, 2) == "51")

# observar abaixo o número de óbitos por UF de residência para certificar-se que seu banco de dados está correto
# 11:8344      12:3763     13:16799    14:2157      15:38557     16:2995     17:7490
# 21:34362     22:19187    23:54276    24:21922     25:28041     26:66928    27:20769    28:13516     29:88094
# 31:135257    32:22868    33:141089   35:296359
# 41:74740     42:40270    43:87583
# 50:16749     51:17535    52:38074    53:12050 

# Verificar se bateu com 17535
nrow(dados_sim_2)

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SIM - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Verificar em dados_sim_2 a frequência das categorias das seguintes variáveis:####
# TIPOBITO, SEXO, RACACOR, ESC2010, TPMORTEOCO, CAUSABAS
# Avalie também os valores das variável IDADE (não estranhe mas idade é composta de um dígito inicial que indica a unidade de medida)
# Unidades de medida a serem consideradas em IDADE: 0: minutos, 1: horas, 2: dias, 3: meses, 4: anos, 5: idade maior que 100 anos
# Atenção: a unidade de medida de IDADE no DICIONÀRIO do SIM está errada
# O propósito das avaliações acima é verificar se as categorias estão de acordo com o dicionário do SIM ou se aparecem categorias estranhas

# Frequências das variáveis qualitativas
table(dados_sim_2$TIPOBITO, useNA = "always")
# Resultado:
# 2 (Não fetal) = 17.535 
# NA = 0 (100% dos óbitos do banco são não fetais)

table(dados_sim_2$SEXO, useNA = "always")
# Resultado:
# 1 (Masculino) = 11.109 
# 2 (Feminino) = 6.416
# 0 (Ignorado) = 10
# NA = 0

table(dados_sim_2$RACACOR, useNA = "always")
# Resultado:
# 1 (Branca) = 6.173
# 2 (Preta) = 1.300
# 3 (Amarela) = 61
# 4 (Parda) = 9.525
# 5 (Indígena) = 241
# NA = 235

table(dados_sim_2$ESC2010, useNA = "always")
# Resultado:
# 0 (Sem esc.) = 3.628
# 1 (Fund I) = 5.794
# 2 (Fund II) = 2.884
# 3 (Médio) = 2.058
# 4 (Sup inc) = 185
# 5 (Sup comp) = 593
# 9 (Ignorado) = 1.036
# NA = 1.357

table(dados_sim_2$TPMORTEOCO, useNA = "always")
# Resultado:
# 1 (Gravidez) = 22
# 2 (Parto) = 3
# 3 (Aborto) = 2
# 4 (Até 42d) = 29
# 5 (43d-1a) = 16
# 8 (Não ocorreu) = 1.078
# 9 (Ignorado) = 509
# NA = 15.874

table(dados_sim_2$CAUSABAS, useNA = "always")
head(sort(table(dados_sim_2$CAUSABAS), decreasing = TRUE), 5)
# Resultado:
# I219 (Infarto) = 1.099
# R99 (Causas mal definidas) = 697
# J189 (Pneumonia) = 613
# I64 (AVC) = 440
# E149 (Diabetes) = 412

# Avaliação da unidade de medida de IDADE
idade_str = sprintf("%03d", as.numeric(dados_sim_2$IDADE))
table(substr(idade_str, 1, 1), useNA = "always")
# Resultado:
# 0 (Minutos) = 66
# 1 (Horas) = 119
# 2 (Dias) = 315
# 3 (Meses) = 239
# 4 (Anos) = 16.649
# 5 (>100 anos) = 107
# 9 (Ignorado) = 40

# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SIM - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016


# Tarefa 5. Atribuir para cada variável de dados_sim_2 como sendo NA a categoria de "Não informado ou Ignorado", ####
# geralmente com código 9
# Verifique o dicionário do SIM para identificar qual o código das categorias de cada variável
# Em variáveis quantitativas como IDADE verificar se existem valores como 9999 para NA

# Atribuição de NA às categorias de "Ignorado / Não informado"
dados_sim_2$TIPOBITO[dados_sim_2$TIPOBITO == 9] = NA

dados_sim_2$SEXO[dados_sim_2$SEXO == 0 | dados_sim_2$SEXO == 9] = NA

dados_sim_2$RACACOR[dados_sim_2$RACACOR == 9] = NA

dados_sim_2$ESC2010[dados_sim_2$ESC2010 == 9] = NA

dados_sim_2$TPMORTEOCO[dados_sim_2$TPMORTEOCO == 9] = NA

dados_sim_2$IDADE[dados_sim_2$IDADE == 999] = NA

dados_sim_2$CAUSABAS[dados_sim_2$CAUSABAS == "" | dados_sim_2$CAUSABAS == "9999"] = NA

# Verificação do total de NAs em cada variável
colSums(is.na(dados_sim_2))
# Resultado:
# CONTADOR: 0 | TIPOBITO: 0 | IDADE: 40 | SEXO: 10 | RACACOR: 235 
# ESC2010: 2393 | CODMUNRES: 0 | TPMORTEOCO: 16383 | CAUSABAS: 0
View(dados_sim_2)

# Ao terminar a Tarefa 5 commit com a mensagem "script BDEM - SIM - tarefas 1 a 5" e envie para o repositório Projeto_BDEM_2016


# Tarefa 6. Atribuir legendas para as categorias das variáveis qualitativas investigadas na tarefa 4.####
# Exemplo: dados_sim_2$TIPOBITO = factor(dados_sim_2$TIPOBITO, levels = c(1,2), labels = c("Fetal", "Não fetal")

# ATENçÃO: 1. Na hora de escrever os labels, somente a PRIMEIRA LETRA da legenda é maiúscula. Exemplo para SEXO: Feminino e Masculino
#          2. Nesta Tarefa 6 não crie novas variáveis dentro do banco de dados

# Transformando em fatores e atribuindo as legendas (labels):

dados_sim_2$TIPOBITO = factor(dados_sim_2$TIPOBITO, 
                              levels = c(1, 2), 
                              labels = c("Fetal", "Não fetal"))

dados_sim_2$SEXO = factor(dados_sim_2$SEXO, 
                          levels = c(1, 2), 
                          labels = c("Masculino", "Feminino"))

dados_sim_2$RACACOR = factor(dados_sim_2$RACACOR, 
                             levels = c(1, 2, 3, 4, 5), 
                             labels = c("Branca", "Preta", "Amarela", "Parda", "Indígena"))

dados_sim_2$ESC2010 = factor(dados_sim_2$ESC2010, 
                             levels = c(0, 1, 2, 3, 4, 5), 
                             labels = c("Sem escolaridade", "Fundamental I", "Fundamental II", "Médio", "Superior incompleto", "Superior completo"))

dados_sim_2$TPMORTEOCO = factor(dados_sim_2$TPMORTEOCO, 
                                levels = c(1, 2, 3, 4, 5, 8), 
                                labels = c("Na gravidez", "No parto", "No abortamento", "Até 42 dias após o término do parto", "De 43 dias a 1 ano após o término da gestação", "Não ocorreu nestes períodos"))

# Verificação da estrutura e frequências após aplicação das legendas
summary(dados_sim_2[, c("TIPOBITO", "SEXO", "RACACOR", "ESC2010", "TPMORTEOCO")])
# Resultado:
# TIPOBITO: Fetal: 0 | Não fetal: 17535 | NA's: 0
# SEXO: Masculino: 11109 | Feminino: 6416 | NA's: 10
# RACACOR: Branca: 6173 | Preta: 1300 | Amarela: 61 | Parda: 9525 | Indígena: 241 | NA's: 235
# ESC2010: Sem escolaridade: 3628 | Fundamental I: 5794 | Fundamental II: 2884 | Médio: 2058 | Superior incompleto: 185 | Superior completo: 593 | NA's: 2393
# TPMORTEOCO: Na gravidez: 22 | No parto: 3 | No abortamento: 2 | Até 42 dias após o término do parto: 29 | De 43 dias a 1 ano após o término da gestação: 16 | Não ocorreu nestes períodos: 1078 | NA's: 16383

# Ao terminar a Tarefa 6 commit com a mensagem "script BDEM - SIM - tarefas 1 a 6" e envie para o repositório Projeto_BDEM_2016


# Tarefa 7. Criar um banco de dados, de nome SIM_UF.csv (Exemplo: SIM_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 7 - SIM.pdf”####
# Atenção: a ordem das variáveis do arquivo deve ser respeitada

# 1. Seleção da base bruta de 87 colunas filtrada para Mato Grosso (51) para o cálculo de TORC
dados_sim$UF = substr(as.character(dados_sim$CODMUNRES), 1, 2)

df_sim_completo_uf = dados_sim[dados_sim$UF == "51", ]

df_sim_completo_uf$UF = NULL

# 2- Pré-cálculo dos vetores lógicos na base inteira (vetorização)

# Idade
codigo_idade = formatC(dados_sim_2$IDADE, width = 3, flag = "0")
unid_medida  = substr(codigo_idade, 1, 1)
val_idade    = as.numeric(substr(codigo_idade, 2, 3))

tempo_dias = ifelse(unid_medida %in% c("0", "1"), 0,
                    ifelse(unid_medida == "2", val_idade,
                           ifelse(unid_medida == "3", 30 * val_idade, NA)))

tempo_anos        = ifelse(unid_medida == "4", val_idade, ifelse(unid_medida == "5", 100 + val_idade, NA))
flag_idade_fertil = !is.na(tempo_anos) & tempo_anos >= 15 & tempo_anos <= 49

# Tratamento de Causas do CID-10
letra_cid = substr(dados_sim_2$CAUSABAS, 1, 1)
num_cid   = suppressWarnings(as.numeric(substr(dados_sim_2$CAUSABAS, 2, 3)))
chave_cid = ifelse(is.na(dados_sim_2$CAUSABAS), NA, paste0(letra_cid, formatC(num_cid, width = 2, flag = "0")))

e_causa_externa   = !is.na(chave_cid) & chave_cid >= "V01" & chave_cid <= "Y98"
e_causa_natural   = !is.na(chave_cid) & !e_causa_externa
e_cb_infecciosa   = e_causa_natural & chave_cid >= "A00" & chave_cid <= "B99"
e_cb_neoplasia    = e_causa_natural & ((chave_cid >= "C00" & chave_cid <= "D48") | (chave_cid >= "D50" & chave_cid <= "D89"))
e_cb_circulatorio = e_causa_natural & chave_cid >= "I00" & chave_cid <= "I99"
e_cb_respiratorio = e_causa_natural & chave_cid >= "J00" & chave_cid <= "J99"
e_cb_outras_nat   = e_causa_natural & !e_cb_infecciosa & !e_cb_neoplasia & !e_cb_circulatorio & !e_cb_respiratorio

# Classificação Neonatal e Pós-neonatal (óbitos não fetais)
e_neonatal         = !is.na(tempo_dias) & tempo_dias <= 27 & dados_sim_2$TIPOBITO == "Não fetal"
e_neonatal_precoce = e_neonatal & tempo_dias <= 6
e_neonatal_tardia  = e_neonatal & tempo_dias >= 7
e_pos_neonatal     = !is.na(tempo_dias) & tempo_dias >= 28 & tempo_dias <= 364 & dados_sim_2$TIPOBITO == "Não fetal"

# Classificação de Morte Materna
e_materno_gestacao = !is.na(dados_sim_2$TPMORTEOCO) & dados_sim_2$TPMORTEOCO == "Na gravidez"
e_materno_parto    = !is.na(dados_sim_2$TPMORTEOCO) & dados_sim_2$TPMORTEOCO == "No parto"
e_materno_aborto   = !is.na(dados_sim_2$TPMORTEOCO) & dados_sim_2$TPMORTEOCO == "No abortamento"
e_materno_42d      = !is.na(dados_sim_2$TPMORTEOCO) & dados_sim_2$TPMORTEOCO == "Até 42 dias após o término do parto"
e_materno_tardio   = !is.na(dados_sim_2$TPMORTEOCO) & dados_sim_2$TPMORTEOCO == "De 43 dias a 1 ano após o término da gestação"
e_materno_precoce  = e_materno_gestacao | e_materno_parto | e_materno_aborto | e_materno_42d
e_materno_total    = e_materno_precoce | e_materno_tardio | (!is.na(letra_cid) & letra_cid == "O")


# 3. Função de contagem por grupo de índices
calcula_soma = function(x) sum(x, na.rm = TRUE)

extrair_indicadores_sim = function(indices) {
  df87 = df_sim_completo_uf[indices, ]
  df9  = dados_sim_2[indices, ]
  
  data.frame(
    TO = length(indices), 
    TORC = calcula_soma(complete.cases(df87)),
    TORCR = calcula_soma(complete.cases(df9)),
    TO_NN = calcula_soma(e_causa_externa[indices]), 
    TO_N = calcula_soma(e_causa_natural[indices]),
    TO_CB_I = calcula_soma(e_cb_infecciosa[indices]), 
    TO_CB_N = calcula_soma(e_cb_neoplasia[indices]), 
    TO_CB_C = calcula_soma(e_cb_circulatorio[indices]),
    TO_CB_R = calcula_soma(e_cb_respiratorio[indices]), 
    TO_CB_O = calcula_soma(e_cb_outras_nat[indices]),
    TO_M = calcula_soma(dados_sim_2$SEXO[indices] == "Masculino"), 
    TO_F = calcula_soma(dados_sim_2$SEXO[indices] == "Feminino"),
    TO_F_IF = calcula_soma(dados_sim_2$SEXO[indices] == "Feminino" & flag_idade_fertil[indices]),
    TO_FT = calcula_soma(dados_sim_2$TIPOBITO[indices] == "Fetal"),
    TO_NT = calcula_soma(e_neonatal[indices]), 
    TO_NT_P = calcula_soma(e_neonatal_precoce[indices]), 
    TO_NT_T = calcula_soma(e_neonatal_tardia[indices]), 
    TO_PNT = calcula_soma(e_pos_neonatal[indices]),
    TONT_B  = calcula_soma(e_neonatal[indices] & dados_sim_2$RACACOR[indices] == "Branca"),
    TONT_PT = calcula_soma(e_neonatal[indices] & dados_sim_2$RACACOR[indices] == "Preta"),
    TONT_A  = calcula_soma(e_neonatal[indices] & dados_sim_2$RACACOR[indices] == "Amarela"),
    TONT_PD = calcula_soma(e_neonatal[indices] & dados_sim_2$RACACOR[indices] == "Parda"),
    TONT_I  = calcula_soma(e_neonatal[indices] & dados_sim_2$RACACOR[indices] == "Indígena"),
    TO_MT = calcula_soma(e_materno_total[indices]), 
    TO_MT_DG = calcula_soma(e_materno_gestacao[indices]), 
    TO_MT_PT = calcula_soma(e_materno_parto[indices]),
    TO_MT_AB = calcula_soma(e_materno_aborto[indices]), 
    TO_MT_42 = calcula_soma(e_materno_42d[indices]), 
    TO_MT_43 = calcula_soma(e_materno_tardio[indices]),
    TO_MT_P = calcula_soma(e_materno_precoce[indices]), 
    TO_MT_P_I = calcula_soma(e_materno_precoce[indices] & dados_sim_2$SEXO[indices] == "Feminino" & flag_idade_fertil[indices]),
    TO_MT_P_ES   = calcula_soma(e_materno_precoce[indices] & dados_sim_2$ESC2010[indices] == "Sem escolaridade"),
    TO_MT_P_EFI  = calcula_soma(e_materno_precoce[indices] & dados_sim_2$ESC2010[indices] == "Fundamental I"),
    TO_MT_P_EFII = calcula_soma(e_materno_precoce[indices] & dados_sim_2$ESC2010[indices] == "Fundamental II"),
    TO_MT_P_EM   = calcula_soma(e_materno_precoce[indices] & dados_sim_2$ESC2010[indices] == "Médio"),
    TO_MT_P_ESI  = calcula_soma(e_materno_precoce[indices] & dados_sim_2$ESC2010[indices] == "Superior incompleto"),
    TO_MT_P_ESC  = calcula_soma(e_materno_precoce[indices] & dados_sim_2$ESC2010[indices] == "Superior completo")
  )
}

# 4. Agregação por nível (UF = 51 e Municípios)
resumo_uf = cbind(data.frame(ANO = 2016, NIVEL = "UF", CODMUNRES = "51"),
                  extrair_indicadores_sim(seq_len(nrow(dados_sim_2))))

lista_municipios = sort(unique(dados_sim_2$CODMUNRES))
resumo_municipios = do.call(rbind, lapply(lista_municipios, function(codigo) {
  indices = which(dados_sim_2$CODMUNRES == codigo)
  cbind(data.frame(ANO = 2016, NIVEL = "MUNICIPIO", CODMUNRES = as.character(codigo)), 
        extrair_indicadores_sim(indices))
}))

# 5. Consolidação da tabela final
SIM_MT = rbind(resumo_uf, resumo_municipios)
rownames(SIM_MT) = NULL

# Checagem das dimensões
dim(SIM_MT)

# Ao terminar a Tarefa 7 commit com a mensagem "script BDEM - SIM - tarefas 1 a 7" e envie para o repositório Projeto_BDEM_2016


# Tarefa 8. Exportar o banco de dados com o nome SIM_UF.csv (Exemplo: SIM_RJ.csv)####

write.csv(SIM_MT, file = "SIM_MT.csv", row.names = FALSE)

# Ao terminar a Tarefa 8 fazer um commit com o comentário "dados SIM_UF 2016 e script - SIM - tarefas 1 a 8"  e envie para o repositório Projeto_BDEM_2016

####################################
# ETAPA 2: BANCO DE DADOS DO SINASC
####################################
# Você deve criar e estar na branch SINASC antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1. Leitura do banco de dados SINASC_2016 com 2857800 linhas e 61 colunas com o nome de dados_sinasc####
# Verificar se a leitura foi feita corretamente e a estrutura dos dados
# Por uma questão de padronização coloque todos os nomes das variáveis em letra maiúscula,
# usando o comando names(dados_sinasc) = toupper(names(dados_sinasc))
# Leitura do banco
dados_sinasc = read.csv("SINASC_2016.csv",
                     header = T,
                     sep = ";",
                     stringsAsFactors = F)
# Padronização
names(dados_sinasc) = toupper(names(dados_sinasc))
# Verificando
dim(dados_sinasc)
names(dados_sinasc)
# Estrutura
str(dados_sinasc)
summary(dados_sinasc)

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SINASC - tarefa 1" e envie para o repositório Projeto_BDEM_2016

# Tarefa 2. Reduzir dados_sinasc apenas para as colunas que serão utilizadas, nomeando este novo banco de dados como dados_sinasc_1####
# As colunas serão 3, 4, 5, 6, 11, 12, 13, 14, 18, 20, 21, 22, 23, 34, 37, 43, 47, 58, 59, 60, 61
# Nomes das respectivas variáveis: CODMUNNASC, LOCNASC, IDADEMAE, ESTCIVMAE, CODMUNRES, GESTACAO, GRAVIDEZ, PARTO, 
# SEXO, APGAR5, RACACOR, PESO, IDANOMAL, ESCMAE2010, RACACORMAE, SEMAGESTAC, TPAPRESENT, TPROBSON, PARIDADE, KOTELCHUCK, CONTADOR
dados_sinasc_1 = dados_sinasc[, c(3, 4, 5, 6, 11, 12, 13, 14, 18, 20, 21, 22, 23, 34, 37, 43, 47, 58, 59, 60, 61)]
names(dados_sinasc_1)
str(dados_sinasc_1)

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Reduzir dados_sinasc_1 apenas para o estado que o aluno irá trabalhar (utilizar os dois primeiros dígitos de CODMUNRES), nomeando este novo banco de dados como dados_sinasc_2####
# Códigos das UF: 11: RO, 12: AC, 13: AM, 14: RR, 15: PA, 16: AP, 17: TO, 21: MA, 22: PI, 23: CE, 24: RN
# 25: PB, 26: PE, 27: AL, 28: SE, 29: BA, 31: MG, 32: ES, 33: RJ, 35: SP, 41: PR, 42: SC, 43: RS
# 50: MS, 51: MT, 52: GO, 53: DF 

# observar abaixo o número de nascimentos por UF de residência para certificar-se que seu banco de dados está correto
# 11: 26602     12: 15773     13: 76703     14: 11376     15: 137681    16: 15521      17: 23870
# 21: 110493    22: 46986     23: 126246    24: 45366     25: 56083     26: 130733     27: 48164     28: 32218     29: 199830
# 31: 253520    32: 53413     33: 219129    35: 601437     
# 41: 155066    42: 95313     43: 141411
# 50: 42432     51: 53531     52: 95563     53: 43340 
dados_sinasc_2 = subset(dados_sinasc_1, substr(as.character(CODMUNRES), 1, 2) == "51")

# Verificação (deve retornar 53531 21)
dim(dados_sinasc_2)

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Verificar em dados_sinasc_2 a frequência das categorias das seguintes variáveis: LOCNASC, ESTCIVMAE, GESTACAO, GRAVIDEZ, PARTO,#####
# SEXO, RACACOR, IDANOMAL, ESCMAE2010, RACACORMAE, TPAPRESENT, TPROBSON, PARIDADE, KOTELCHUCK
# Avalie também os valores das variáveis quantitativas de IDADEMAE, SEMAGESTAC, APGAR5 e PESO
vars_qualitativas = c("LOCNASC", "ESTCIVMAE", "GESTACAO", "GRAVIDEZ", "PARTO",
                      "SEXO", "RACACOR", "IDANOMAL", "ESCMAE2010", "RACACORMAE",
                      "TPAPRESENT", "TPROBSON", "PARIDADE", "KOTELCHUCK")

lapply(dados_sinasc_2[, vars_qualitativas], table, useNA = "always")

# Resumo estatístico das variáveis quantitativas
vars_quantitativas = c("IDADEMAE", "SEMAGESTAC", "APGAR5", "PESO")

summary(dados_sinasc_2[, vars_quantitativas])

# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016


# Tarefa 5. Atribuir para cada variável de dados_sinasc_2 como sendo NA a categoria de "Não informado ou Ignorado", #####
# geralmente com código 9
# Verifique o dicionário do SINASC para identificar qual o código das categorias de cada variável
# KOTELCHUCK = 9 significa "Não informado"   TPROBSON = 11 significa "Não classificado por falta de informação"
# Em variáveis quantitativas como IDADEMAE verificar se existem valores como 9999 para NA
dados_sinasc_2$LOCNASC[dados_sinasc_2$LOCNASC == 9] = NA
dados_sinasc_2$ESTCIVMAE[dados_sinasc_2$ESTCIVMAE == 9] = NA
dados_sinasc_2$GESTACAO[dados_sinasc_2$GESTACAO == 9] = NA
dados_sinasc_2$GRAVIDEZ[dados_sinasc_2$GRAVIDEZ == 9] = NA
dados_sinasc_2$PARTO[dados_sinasc_2$PARTO == 9] = NA
dados_sinasc_2$SEXO[dados_sinasc_2$SEXO == 0 | dados_sinasc_2$SEXO == 9] = NA
dados_sinasc_2$RACACOR[dados_sinasc_2$RACACOR == 9] = NA
dados_sinasc_2$IDANOMAL[dados_sinasc_2$IDANOMAL == 9] = NA
dados_sinasc_2$ESCMAE2010[dados_sinasc_2$ESCMAE2010 == 9] = NA
dados_sinasc_2$RACACORMAE[dados_sinasc_2$RACACORMAE == 9] = NA
dados_sinasc_2$TPAPRESENT[dados_sinasc_2$TPAPRESENT == 9] = NA
dados_sinasc_2$TPROBSON[dados_sinasc_2$TPROBSON == 11] = NA
dados_sinasc_2$PARIDADE[dados_sinasc_2$PARIDADE == 9] = NA
dados_sinasc_2$KOTELCHUCK[dados_sinasc_2$KOTELCHUCK == 9] = NA

dados_sinasc_2$IDADEMAE[dados_sinasc_2$IDADEMAE == 99] = NA
dados_sinasc_2$SEMAGESTAC[dados_sinasc_2$SEMAGESTAC == 99] = NA
dados_sinasc_2$APGAR5[dados_sinasc_2$APGAR5 == 99] = NA
dados_sinasc_2$PESO[dados_sinasc_2$PESO == 9999] = NA

lapply(dados_sinasc_2[, vars_qualitativas], table, useNA = "always")
summary(dados_sinasc_2[, vars_quantitativas])
colSums(is.na(dados_sinasc_2))

# Ao terminar a Tarefa 5 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 5" e envie para o repositório Projeto_BDEM_2016


# Tarefa 6. Atribuir legendas para as categorias das variáveis qualitativas investigadas na tarefa 4.####
# Exemplo: dados_sinasc_2$KOTELCHUCK = factor(dados_sinasc_2$KOTELCHUCK, levels = c(1,2,3,4,5), 
# labels = c("Não realizou pré-natal", "Inadequado", "Intermediário", "Adequado",  
# "Mais que adequado")

# ATENçÃO: 1. Na hora de escrever os labels, somente a primeira letra da legenda é maiúscula. Exemplo para SEXO: Feminino e Masculino
#          2. Nesta Tarefa 6 não crie novas variáveis dentro do banco de dados
dados_sinasc_2$LOCNASC = factor(dados_sinasc_2$LOCNASC, levels = c(1, 2, 3, 4, 5),
                                labels = c("Hospital", "Outros estabelecimentos de saúde",
                                           "Domicílio", "Outros", "Aldeia indígena"))

dados_sinasc_2$ESTCIVMAE = factor(dados_sinasc_2$ESTCIVMAE, levels = c(1, 2, 3, 4, 5),
                                  labels = c("Solteira", "Casada", "Viúva",
                                             "Separada judicialmente/divorciada", "União estável"))

dados_sinasc_2$GESTACAO = factor(dados_sinasc_2$GESTACAO, levels = c(1, 2, 3, 4, 5, 6),
                                 labels = c("Menos de 22 semanas", "22 a 27 semanas",
                                            "28 a 31 semanas", "32 a 36 semanas",
                                            "37 a 41 semanas", "42 semanas e mais"))

dados_sinasc_2$GRAVIDEZ = factor(dados_sinasc_2$GRAVIDEZ, levels = c(1, 2, 3),
                                 labels = c("Única", "Dupla", "Tripla ou mais"))

dados_sinasc_2$PARTO = factor(dados_sinasc_2$PARTO, levels = c(1, 2),
                              labels = c("Vaginal", "Cesário"))

dados_sinasc_2$SEXO = factor(dados_sinasc_2$SEXO, levels = c(1, 2),
                             labels = c("Masculino", "Feminino"))

dados_sinasc_2$RACACOR = factor(dados_sinasc_2$RACACOR, levels = c(1, 2, 3, 4, 5),
                                labels = c("Branca", "Preta", "Amarela", "Parda", "Indígena"))

dados_sinasc_2$IDANOMAL = factor(dados_sinasc_2$IDANOMAL, levels = c(1, 2),
                                 labels = c("Sim", "Não"))

dados_sinasc_2$RACACORMAE = factor(dados_sinasc_2$RACACORMAE, levels = c(1, 2, 3, 4, 5),
                                   labels = c("Branca", "Preta", "Amarela", "Parda", "Indígena"))

dados_sinasc_2$TPAPRESENT = factor(dados_sinasc_2$TPAPRESENT, levels = c(1, 2, 3),
                                   labels = c("Cefálico", "Pélvica ou podálica", "Transversa"))

dados_sinasc_2$ESCMAE2010 = factor(dados_sinasc_2$ESCMAE2010, levels = c(0, 1, 2, 3, 4, 5),
                                   labels = c("Sem escolaridade", "Fundamental I (1ª a 4ª série)",
                                              "Fundamental II (5ª a 8ª série)", "Médio (antigo 2º grau)",
                                              "Superior incompleto", "Superior completo"))

dados_sinasc_2$PARIDADE = factor(dados_sinasc_2$PARIDADE, levels = c(0, 1),
                                 labels = c("Nulípara", "Multípara"))

dados_sinasc_2$KOTELCHUCK = factor(dados_sinasc_2$KOTELCHUCK, levels = c(1, 2, 3, 4, 5),
                                   labels = c("Não realizou pré-natal", "Inadequado", "Intermediário",
                                              "Adequado", "Mais que adequado"))

# Verificando
str(dados_sinasc_2)

# Ao terminar a Tarefa 6 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 6" e envie para o repositório Projeto_BDEM_2016


# Tarefa 7. Categorizar as variáveis IDADEMAE, PESO e APGAR5 e criar variáveis referentes ao deslocamento materno (peregrinação) e estado civil####
# nova variável: dados_sinasc_2$F_PESO com PESO: < 2500: Baixo peso, >=2500 e < 4000: Peso normal, >= 4000: Macrossomia
# nova variável dados_sinasc_2$F_IDADE com IDADEMAE: <15, 15-19, 20-24, 25-29, 30-34, 35-39, 40-44, 45-49, 50+
# nova variável dados_sinasc_2$F_APGAR5 com APGAR5: < 7: Baixo, >= 7: Normal
# Atenção para casos de NA em IDADEMAE, PESO e APGAR5
# nova variável: dados_sinasc_2$PEREG: Não: CODMUNNASC igual a CODMUNRES, Sim: CODMUNNASC diferente de CODMUNRES
# nova variável: dados_sinasc_2$ESTCIV: Sem companheiro: ESTCIVMAE 1, 3 ou 4, Com companheiro: ESTCIVMAE 2 ou 5
# Ao categorizar as variáveis, garantir que sejam transformadas em tipo fator
# Categorização do Peso ao Nascer
dados_sinasc_2$F_PESO = ifelse(is.na(dados_sinasc_2$PESO), NA,
                               ifelse(dados_sinasc_2$PESO < 2500, "Baixo peso",
                                      ifelse(dados_sinasc_2$PESO < 4000, "Peso normal", "Macrossomia")))
dados_sinasc_2$F_PESO = factor(dados_sinasc_2$F_PESO, 
                               levels = c("Baixo peso", "Peso normal", "Macrossomia"))

# Categorização da Idade da Mãe
dados_sinasc_2$F_IDADE = cut(dados_sinasc_2$IDADEMAE,
                             breaks = c(0, 15, 20, 25, 30, 35, 40, 45, 50, Inf),
                             right = FALSE,
                             labels = c("<15", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50+"))

# Categorização do Apgar no 5º minuto
dados_sinasc_2$F_APGAR5 = ifelse(is.na(dados_sinasc_2$APGAR5), NA,
                                 ifelse(dados_sinasc_2$APGAR5 < 7, "Baixo", "Normal"))
dados_sinasc_2$F_APGAR5 = factor(dados_sinasc_2$F_APGAR5, 
                                 levels = c("Baixo", "Normal"))

# Peregrinação
dados_sinasc_2$PEREG = ifelse(is.na(dados_sinasc_2$CODMUNNASC) | is.na(dados_sinasc_2$CODMUNRES), NA,
                              ifelse(dados_sinasc_2$CODMUNNASC == dados_sinasc_2$CODMUNRES, "Não", "Sim"))
dados_sinasc_2$PEREG = factor(dados_sinasc_2$PEREG, 
                              levels = c("Não", "Sim"))

# Estado Civil Recodificado
dados_sinasc_2$ESTCIV = ifelse(is.na(dados_sinasc_2$ESTCIVMAE), NA,
                               ifelse(dados_sinasc_2$ESTCIVMAE %in% c("Solteira", "Viúva", "Separada judicialmente/divorciada"),
                                      "Sem companheiro", "Com companheiro"))
dados_sinasc_2$ESTCIV = factor(dados_sinasc_2$ESTCIV, 
                               levels = c("Sem companheiro", "Com companheiro"))

# Verificação das novas variáveis criadas
str(dados_sinasc_2[, c("F_PESO", "F_IDADE", "F_APGAR5", "PEREG", "ESTCIV")])
summary(dados_sinasc_2[, c("F_PESO", "F_IDADE", "F_APGAR5", "PEREG", "ESTCIV")])
lapply(dados_sinasc_2[, c("F_PESO", "F_IDADE", "F_APGAR5", "PEREG", "ESTCIV")], table, useNA = "always")
tapply(dados_sinasc_2$IDADEMAE, dados_sinasc_2$F_IDADE, range, na.rm = TRUE)
tapply(dados_sinasc_2$APGAR5, dados_sinasc_2$F_APGAR5, range, na.rm = TRUE)

# Ao terminar a Tarefa 7 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 7" e envie para o repositório Projeto_BDEM_2016


# Tarefa 8. Agregar ao banco de dados_sinasc_2 as informações PESO_P10 e PESO_P90 a partir de Tabela_PIG_Brasil.csv####
# a Tabela PIG informa P10 e P90 dos pesos, de acordo com a idade gestacional
# Criar nova variável referente ao peso, de acordo com a idade gestacional, conforme indicado abaixo
# nova variável apenas para casos de GRAVIDEZ Única: dados_sinasc_2$F_PIG: PIG: PESO < PESO_P10, AIG: PESO_P10 <= PESO <= PESO_P90, GIG: PESO > PESO_P90
# Atenção para casos de NA em SEMAGESTAC, PESO ou SEXO. Lembre-se também que em dados_sinasc_2 SEXO está como fator com as categorias Feminino e Masculino.
# Leitura da Tabela PIG
pig = read.csv("Tabela_PIG_Brasil.csv",
               header = TRUE,
               sep = ";",
               stringsAsFactors = FALSE)

names(pig) = toupper(names(pig))

# Ajusta a variável SEXO da tabela PIG para fator
if (is.numeric(pig$SEXO)) {
  pig$SEXO = factor(pig$SEXO, levels = c(1, 2), labels = c("Masculino", "Feminino"))
} else {
  pig$SEXO = factor(pig$SEXO, levels = c("Masculino", "Feminino"))
}

# Junção (merge) por SEMAGESTAC e SEXO
dados_sinasc_2 = merge(dados_sinasc_2, 
                       pig[, c("SEMAGESTAC", "SEXO", "PESO_P10", "PESO_P90")],
                       by = c("SEMAGESTAC", "SEXO"),
                       all.x = TRUE)

# Criação da variável F_PIG (inicializa com NA)
dados_sinasc_2$F_PIG = NA

# Condição para gravidez Única e com dados de percentis disponíveis
e_unica = !is.na(dados_sinasc_2$GRAVIDEZ) & dados_sinasc_2$GRAVIDEZ == "Única"

dados_sinasc_2$F_PIG[e_unica & dados_sinasc_2$PESO < dados_sinasc_2$PESO_P10] = "PIG"
dados_sinasc_2$F_PIG[e_unica & dados_sinasc_2$PESO >= dados_sinasc_2$PESO_P10 & dados_sinasc_2$PESO <= dados_sinasc_2$PESO_P90] = "AIG"
dados_sinasc_2$F_PIG[e_unica & dados_sinasc_2$PESO > dados_sinasc_2$PESO_P90] = "GIG"

# Transformação em fator com ordem dos níveis
dados_sinasc_2$F_PIG = factor(dados_sinasc_2$F_PIG, levels = c("PIG", "AIG", "GIG"))

# Verificação
table(GRAVIDEZ = dados_sinasc_2$GRAVIDEZ, F_PIG = dados_sinasc_2$F_PIG, useNA = "always")
summary(dados_sinasc_2[, c("PESO_P10", "PESO_P90", "F_PIG")])

# Ao terminar a Tarefa 8 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 8" e envie para o repositório Projeto_BDEM_2016


# Tarefa 9. Criar um banco de dados, de nome SINASC_UF.csv (Exemplo: SINASC_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 9 - SINASC.pdf”
# Atenção: a ordem das variáveis do arquivo deve ser respeitada

#################################################  
# Base inicial (municípios)
#################################################
base = data.frame(CODMUNRES = sort(unique(dados_sinasc_2$CODMUNRES)))

# TN - total de nascimentos
TN = as.data.frame(table(factor(dados_sinasc_2$CODMUNRES)))
names(TN) = c("CODMUNRES","TN")

base = merge(base, TN, by = "CODMUNRES", all.x = TRUE)


# TNRC - completos nas 61 variáveis
dados_UF = dados_sinasc[substr(as.character(dados_sinasc$CODMUNRES), 1, 2) == "51",]
dados_UF_comp = dados_UF[complete.cases(dados_UF), ]

TNRC = as.data.frame(table(factor(dados_UF_comp$CODMUNRES,levels = base$CODMUNRES)))
names(TNRC) = c("CODMUNRES","TNRC")

base = merge(base, TNRC, by = "CODMUNRES", all.x = TRUE)

# TNRCR - completos nas 22 variáveis
dados_UF_1 = dados_sinasc_1[substr(as.character(dados_sinasc_1$CODMUNRES), 1, 2) == "51",]
dados_UF_1_comp = dados_UF_1[complete.cases(dados_UF_1), ]

TNRCR = as.data.frame(table(factor(dados_UF_1_comp$CODMUNRES, levels = base$CODMUNRES)))
names(TNRCR) = c("CODMUNRES","TNRCR")

base = merge(base, TNRCR, by = "CODMUNRES", all.x = TRUE)

#################################################
# Informações das gestantes
#################################################
# Idade

# Frequências
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$F_IDADE, levels = c("<15","15-19","20-24","25-29", "30-34","35-39","40-44","45-49","50+")))
df = as.data.frame.matrix(tab)
names(df) = c("TGI_15","TGI_15_19","TGI_20_24","TGI_25_29", "TGI_30_34","TGI_35_39","TGI_40_44","TGI_45_49","TGI_50")
df$CODMUNRES = rownames(df)

df$TGIF= df$TGI_15_19 + df$TGI_20_24 + df$TGI_25_29 + df$TGI_30_34 +
  df$TGI_35_39 + df$TGI_40_44 + df$TGI_45_49

base = merge(base, df, by = "CODMUNRES", all.x = TRUE)

# Percentis
p_idade = aggregate(IDADEMAE ~ CODMUNRES,dados_sinasc_2, function(x) quantile(x, probs = c(0.25,0.5,0.75), na.rm = TRUE))
p_idade = do.call(data.frame, p_idade)
names(p_idade) = c("CODMUNRES","IM_P25","IM_P50","IM_P75")
p_idade[, c("IM_P25","IM_P50","IM_P75")] = round(p_idade[, c("IM_P25","IM_P50","IM_P75")], 2)

base = merge(base, p_idade, by="CODMUNRES", all.x=TRUE)

# Média
media_idade = aggregate(IDADEMAE ~ CODMUNRES, dados_sinasc_2, mean, na.rm = TRUE)
media_idade$IDADEMAE = round(media_idade$IDADEMAE, 2)
names(media_idade)[2] = "IM_MD"

# Desvio-padrão
dp_idade = aggregate(IDADEMAE ~ CODMUNRES, dados_sinasc_2, sd, na.rm = TRUE)
dp_idade$IDADEMAE = round(dp_idade$IDADEMAE, 2)
names(dp_idade)[2] = "IM_DP"
temp = merge(media_idade, dp_idade, by = "CODMUNRES")

base = merge(base, temp, by = "CODMUNRES", all.x = TRUE)

# Escolaridade
# Frequências
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$ESCMAE2010, levels = c("Sem escolaridade", "Fundamental I (1ª a 4ª série)", "Fundamental II (5ª a 8ª série)", "Médio (antigo 2º grau)", "Superior incompleto", "Superior completo")))
df = as.data.frame.matrix(tab)
names(df) = c("EM_S","EM_FI","EM_FII","EM_M", "EM_SI","EM_SC")
df$CODMUNRES = rownames(df)

base = merge(base, df, by = "CODMUNRES", all.x = TRUE)


# Raca/Cor da Mãe
# Frequências
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$RACACORMAE, levels = c("Branca", "Preta", "Amarela", "Parda", "Indígena")))
df = as.data.frame.matrix(tab)
names(df) = c("TGRC_B","TGRC_PT","TGRC_A","TGRC_PD", "TGRC_I")
df$CODMUNRES = rownames(df)

base = merge(base, df, by = "CODMUNRES", all.x = TRUE)

# Estado civil
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$ESTCIV, levels = c("Sem companheiro","Com companheiro")))
df = as.data.frame.matrix(tab)
names(df) = c("TGSC","TGCC")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)


# Primiparidade
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$PARIDADE, levels = c("Nulípara", "Multípara")))
df = as.data.frame.matrix(tab)
names(df) = c("TGPRI","TGNPRI")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)


#################################################
# Informações das gestações
#################################################
# Tipo
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$GRAVIDEZ, levels = c("Única", "Dupla", "Tripla ou mais")))
df = as.data.frame.matrix(tab)
names(df) = c("TGU","TEMP1","TEMP2")
df$TGG = df$TEMP1 + df$TEMP2
df$CODMUNRES = rownames(df)

base = merge(base, df[,c("CODMUNRES","TGU","TGG")], by = "CODMUNRES", all.x = TRUE)

# Duração da gestação
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$GESTACAO, levels = c("Menos de 22 semanas", "22 a 27 semanas", "28 a 31 semanas", "32 a 36 semanas", "37 a 41 semanas", "42 semanas e mais")))
df = as.data.frame.matrix(tab)
names(df) = c("TGD_22","TGD_22_27","TGD_28_31","TGD_32_36", "TGD_37_41", "TGD_42")
df$CODMUNRES = rownames(df)

df$TGD_PRT= df$TGD_22 + df$TGD_22_27 + df$TGD_28_31 + df$TGD_32_36 
df$TGD_AT= df$TGD_37_41
df$TGD_PST= df$TGD_42

base = merge(base, df, by = "CODMUNRES", all.x = TRUE)

# Percentis
p_duracao = aggregate(SEMAGESTAC ~ CODMUNRES,dados_sinasc_2, function(x) quantile(x, probs = c(0.25,0.5,0.75), na.rm = TRUE))
p_duracao = do.call(data.frame, p_duracao)
names(p_duracao) = c("CODMUNRES","DG_P25","DG_P50","DG_P75")
p_duracao[, c("DG_P25","DG_P50","DG_P75")] = round(p_duracao[, c("DG_P25","DG_P50","DG_P75")], 2)

base = merge(base, p_duracao, by="CODMUNRES", all.x=TRUE)

# Média
media_duracao = aggregate(SEMAGESTAC ~ CODMUNRES, dados_sinasc_2, mean, na.rm = TRUE)
media_duracao$SEMAGESTAC = round(media_duracao$SEMAGESTAC, 2)
names(media_duracao)[2] = "DG_MD"

# Desvio-padrão
dp_duracao = aggregate(SEMAGESTAC ~ CODMUNRES, dados_sinasc_2, sd, na.rm = TRUE)
dp_duracao$SEMAGESTAC = round(dp_duracao$SEMAGESTAC, 2)
names(dp_duracao)[2] = "DG_DP"
temp = merge(media_duracao, dp_duracao, by = "CODMUNRES")

base = merge(base, temp, by = "CODMUNRES", all.x = TRUE)


# Consultas de pre-natal
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$KOTELCHUCK, levels = c("Não realizou pré-natal", "Inadequado", "Intermediário", "Adequado", "Mais que adequado")))
df = as.data.frame.matrix(tab)
names(df) = c("TKC_NR","TKC_ID","TKC_IT","TKC_AD", "TKC_MAD")
df$CODMUNRES = rownames(df)

base = merge(base, df, by = "CODMUNRES", all.x = TRUE)


#################################################
# Informações dos partos
#################################################
# Peregrinação
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$PEREG, levels = c("Sim","Não")))
df = as.data.frame.matrix(tab)
names(df) = c("TGPRG_S","TGPRG_N")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)

# Tipo de parto
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$PARTO, levels = c("Vaginal", "Cesário")))
df = as.data.frame.matrix(tab)
names(df) = c("TPV","TPC")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)

# Posição do feto
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$TPAPRESENT, levels = c("Cefálico", "Pélvica ou podálica", "Transversa")))
df = as.data.frame.matrix(tab)
names(df) = c("TRAP_C", "TRAP_P", "TRAP_T")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)


# Grupo de Robson
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$TPROBSON, levels = 1:10))
df = as.data.frame.matrix(tab)
names(df) = c("TGROB_1","TGROB_2", "TGROB_3", "TGROB_4", "TGROB_5", "TGROB_6", "TGROB_7", "TGROB_8", "TGROB_9", "TGROB_10")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)


# Local de nascimento
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$LOCNASC, levels = c("Hospital", "Outros estabelecimentos de saúde", "Domicílio", "Outros", "Aldeia indígena")))
df = as.data.frame.matrix(tab)
names(df) = c("TNLOC_H", "TNLOC_ES", "TNLOC_D", "TNLOC_O", "TNLOC_AI")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)


#################################################
# Informações dos recém-nascidos
#################################################
# Sexo
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$SEXO, levels = c("Masculino","Feminino")))
df = as.data.frame.matrix(tab)
names(df) = c("TRS_M", "TRS_F")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)


# Raça/Cor
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$RACACOR, levels = c("Branca", "Preta", "Amarela", "Parda", "Indígena")))
df = as.data.frame.matrix(tab)
names(df) = c("TRRC_B","TRRC_PT","TRRC_A", "TRRC_PD", "TRRC_I")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)


# Peso
# Frequências
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$F_PESO, levels = c("Baixo peso","Peso normal","Macrossomia")))
df = as.data.frame.matrix(tab)
names(df) = c("TRP_BP", "TRP_N", "TRP_M")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)

# Percentis
p_peso = aggregate(PESO ~ CODMUNRES,dados_sinasc_2, function(x) quantile(x, probs = c(0.25,0.5,0.75), na.rm = TRUE))
p_peso = do.call(data.frame, p_peso)
names(p_peso) = c("CODMUNRES","PESO_P25","PESO_P50","PESO_P75")
p_peso[, c("PESO_P25","PESO_P50","PESO_P75")] = round(p_peso[, c("PESO_P25","PESO_P50","PESO_P75")], 2)

base = merge(base, p_peso, by="CODMUNRES", all.x=TRUE)

# Média
media_peso = aggregate(PESO ~ CODMUNRES, dados_sinasc_2, mean, na.rm = TRUE)
media_peso$PESO = round(media_peso$PESO, 2)
names(media_peso)[2] = "PESO_MD"

# Desvio-padrão
dp_peso = aggregate(PESO ~ CODMUNRES, dados_sinasc_2, sd, na.rm = TRUE)
dp_peso$PESO = round(dp_peso$PESO, 2)
names(dp_peso)[2] = "PESO_DP"
temp = merge(media_peso, dp_peso, by = "CODMUNRES")

base = merge(base, temp, by = "CODMUNRES", all.x = TRUE)


# Peso por idade gestacional - gestações únicas
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$F_PIG, levels = c("PIG","AIG","GIG")))
df = as.data.frame.matrix(tab)
names(df) = c("TRPIG_P", "TRPIG_A", "TRPIG_G")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)


# Apgar ao 5º minuto
# Frequências
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$F_APGAR5, levels = c("Baixo","Normal")))
df = as.data.frame.matrix(tab)
names(df) = c("TRAPG5_B","TRAPG5_N")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)

# Média
media_apgar5 = aggregate(APGAR5 ~ CODMUNRES, dados_sinasc_2, mean, na.rm = TRUE)
media_apgar5$APGAR5 = round(media_apgar5$APGAR5, 2)
names(media_apgar5)[2] = "APG5_MD"

# Desvio-padrão
dp_apgar5 = aggregate(APGAR5 ~ CODMUNRES, dados_sinasc_2, sd, na.rm = TRUE)
dp_apgar5$APGAR5 = round(dp_apgar5$APGAR5, 2)
names(dp_apgar5)[2] = "APG5_DP"
temp = merge(media_apgar5, dp_apgar5, by = "CODMUNRES")

base = merge(base, temp, by = "CODMUNRES", all.x = TRUE)


# Anomalia congênita
tab = table(dados_sinasc_2$CODMUNRES, factor(dados_sinasc_2$IDANOMAL, levels = c("Sim", "Não")))
df = as.data.frame.matrix(tab)
names(df) = c("TRAC","TRSAC")
df$CODMUNRES = rownames(df)

base = merge(base, df, by="CODMUNRES", all.x=TRUE)


# Linha da UF
linha_estado = base[1, ]
linha_estado[,] = NA

# colunas de contagem: indicar as variáveis contínuas, que por exclusão não terão valores somados
cols_contagem = setdiff(names(base), c("CODMUNRES","IM_P25","IM_P50","IM_P75", "IM_MD","IM_DP", 
                                       "DG_P25", "DG_P50", "DG_P75", "DG_MD", "DG_DP", 
                                       "PESO_P25", "PESO_P50", "PESO_P75", "PESO_MD", "PESO_DP",
                                       "APG5_MD", "APG5_DP"))

linha_estado[cols_contagem] = colSums(base[cols_contagem], na.rm = TRUE)

# medidas para variáveis quantitativas 
# Idade da mãe
linha_estado$IM_MD = round(mean(dados_sinasc_2$IDADEMAE, na.rm = TRUE), 2)
linha_estado$IM_DP = round(sd(dados_sinasc_2$IDADEMAE, na.rm = TRUE), 2)

q = round(quantile(dados_sinasc_2$IDADEMAE, probs = c(0.25,0.5,0.75), na.rm = TRUE), 2)
linha_estado$IM_P25 = q[1]
linha_estado$IM_P50 = q[2]
linha_estado$IM_P75 = q[3]


# Duração da gestação
linha_estado$DG_MD = round(mean(dados_sinasc_2$SEMAGESTAC, na.rm = TRUE), 2)
linha_estado$DG_DP = round(sd(dados_sinasc_2$SEMAGESTAC, na.rm = TRUE), 2)

q = round(quantile(dados_sinasc_2$SEMAGESTAC, probs = c(0.25,0.5,0.75), na.rm = TRUE), 2)
linha_estado$DG_P25 = q[1]
linha_estado$DG_P50 = q[2]
linha_estado$DG_P75 = q[3]


# Peso
linha_estado$PESO_MD = round(mean(dados_sinasc_2$PESO, na.rm = TRUE), 2)
linha_estado$PESO_DP = round(sd(dados_sinasc_2$PESO, na.rm = TRUE), 2)

q = round(quantile(dados_sinasc_2$PESO, probs = c(0.25,0.5,0.75), na.rm = TRUE), 2)
linha_estado$PESO_P25 = q[1]
linha_estado$PESO_P50 = q[2]
linha_estado$PESO_P75 = q[3]


# Apgar ao 5º minuto
linha_estado$APG5_MD = round(mean(dados_sinasc_2$APGAR5, na.rm = TRUE), 2)
linha_estado$APG5_DP = round(sd(dados_sinasc_2$APGAR5, na.rm = TRUE), 2)


# código da UF e ordem das colunas
linha_estado$CODMUNRES = 51

# Banco de dados final para o Acre
SINASC_MT = rbind(linha_estado, base)

SINASC_MT$NIVEL = c("UF", rep("MUNICIPIO", nrow(SINASC_MT)-1))
SINASC_MT$ANO = 2016

SINASC_MT = SINASC_MT[, c("ANO","NIVEL","CODMUNRES", names(SINASC_MT)[!names(SINASC_MT) %in% c("ANO","NIVEL","CODMUNRES")])]
SINASC_MT$CODMUNRES = as.character(SINASC_MT$CODMUNRES)

# Verificando o banco final
str(SINASC_MT)
head(SINASC_MT)
dim(SINASC_MT)

# Tarefa 10. Exportar o banco de dados com o nome SINASC_UF.csv (Exemplo: SINASC_RJ.csv)
write.csv2(SINASC_MT, "SINASC_MT.csv", row.names = FALSE)
# Ao terminar a Tarefa 10 commit com o comentário "dados SINASC_UF 2016 e script - SIM - tarefas 1 a 10"  e envie para o repositório Projeto_BDEM_2016



####################################
# ETAPA 3: BANCOS DE DADOS DO SIDRA
####################################
# Você deve criar e estar na branch SIDRA antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Ler os bancos de dados abaixo listados com os respectivos nomes
# dados_sidra_1 para população residente estimada - UF e municípios - 2016 - SIDRA - tabela_6579.csv
# dados_sidra_2 para população residente censo 2010 - UF e municípios - total e por sexo - SIDRA - tabela_1552.csv
# dados_sidra_3 para população residente censo 2010 - por faixa etária - UF - SIDRA - tabela_1552.csv
# dados_sidra_4 para população residente censo 2010 - por faixa etária e sexo - municípios - SIDRA - tabela_1552.csv
# Atenção que agora os arquivos têm nomes e códigos (com 7 dígitos) dos municípios (e alguns UF)

# Verificar se a leitura de todos os bancos foi feita corretamente e a estrutura dos dados

# Leitura da tabela de estimativa 2016 (latin1 e tratamento de '...' como NA)
dados_sidra_1 = read.csv("população residente estimada - UF e municípios - 2016 - SIDRA - tabela_6579.csv",
                          sep = ";", fileEncoding = "latin1", na.strings = "...")

# Leitura das tabelas do Censo 2010 em UTF-8 com BOM
dados_sidra_2 = read.csv("população residente censo 2010 - UF e municípios - total e por sexo - SIDRA - tabela_1552.csv",
                          sep = ";", fileEncoding = "UTF-8-BOM")

dados_sidra_3 = read.csv("população residente censo 2010 - por faixa etária - UF - SIDRA - tabela_1552.csv",
                          sep = ";", fileEncoding = "UTF-8-BOM")

dados_sidra_4 = read.csv("população residente censo 2010 - por faixa etária e sexo - municípios - SIDRA - tabela_1552.csv",
                          sep = ";", fileEncoding = "UTF-8-BOM")

# Remoção de eventual linha vazia no final da tabela 3
dados_sidra_3 = subset(dados_sidra_3, !is.na(CODMUNRES))

# Verificação das dimensões e estruturas
dim(dados_sidra_1); str(dados_sidra_1)
dim(dados_sidra_2); str(dados_sidra_2)
dim(dados_sidra_3); str(dados_sidra_3)
dim(dados_sidra_4); str(dados_sidra_4)
table(dados_sidra_4$F_IDADE)

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SIDRA - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2. Criar uma nova variável de nome CODUF com os códigos da UF nos bancos dados_sidra_1, dados_sidra_2, dados_sidra_4

dados_sidra_1$CODUF <- substr(as.character(dados_sidra_1$CODMUNRES), 1, 2)
dados_sidra_2$CODUF <- substr(as.character(dados_sidra_2$CODMUNRES), 1, 2)
dados_sidra_4$CODUF <- substr(as.character(dados_sidra_4$CODMUNRES), 1, 2)

# Conferência dos códigos de UF criados
table(dados_sidra_1$CODUF)

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SIDRA - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Selecionar em dados_sidra_ 1 a dados_sidra_4 a UF de responsabilidade do aluno 
# e chamar os bancos de dados, respectivamente por sidra_1, sidra_2, sidra_3 e sidra_4

sidra_1 = subset(dados_sidra_1, CODUF == "51")
sidra_2 = subset(dados_sidra_2, CODUF == "51")
sidra_3 = subset(dados_sidra_3, CODMUNRES == 51)
sidra_4 = subset(dados_sidra_4, CODUF == "51")

# Conferência do número de linhas para Mato Grosso
nrow(sidra_1)  # deve dar 143 (1 UF + 142 municípios)
nrow(sidra_2)  # deve dar 142 (1 UF + 141 municípios do Censo 2010)
nrow(sidra_3)  # deve dar 19 (19 faixas etárias)
nrow(sidra_4)  # deve dar 2679 (141 municípios x 19 faixas)

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SIDRA - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016

# Tarefa 4: Criar um banco de dados, de nome SIDRA_UF.csv (Exemplo: SIDRA_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 4 - SIDRA.pdf”

# Agrupamento das faixas etárias em: <15 anos, 15 a 49 anos e 50+ anos
# Unindo as linhas da UF (sidra_3) com as dos municípios (sidra_4)
df_faixas = rbind(sidra_3[, c("CODMUNRES", "F_IDADE", "POP", "POPF")],
                   sidra_4[, c("CODMUNRES", "F_IDADE", "POP", "POPF")])

# Classificação dos grupos etários
faixas_15 = c("0 a 4 anos", "5 a 9 anos", "10 a 14 anos")
faixas_15_49 = c("15 a 19 anos", "20 a 24 anos", "25 a 29 anos", "30 a 34 anos", 
                  "35 a 39 anos", "40 a 44 anos", "45 a 49 anos")

df_faixas$GRUPO = ifelse(df_faixas$F_IDADE %in% faixas_15, "15",
                          ifelse(df_faixas$F_IDADE %in% faixas_15_49, "15_49", "50"))

# Agregação da população total por grupo etário
totais_pop = as.data.frame.matrix(tapply(df_faixas$POP, list(df_faixas$CODMUNRES, df_faixas$GRUPO), sum))
colnames(totais_pop) = c("POPRC_15", "POPRC_15_49", "POPRC_50")
totais_pop$CODMUNRES = as.numeric(rownames(totais_pop))

# Agregação da população feminina por grupo etário
totais_popf = as.data.frame.matrix(tapply(df_faixas$POPF, list(df_faixas$CODMUNRES, df_faixas$GRUPO), sum))
colnames(totais_popf) = c("POPRC_F_15", "POPRC_F_15_49", "POPRC_F_50")
totais_popf$CODMUNRES = as.numeric(rownames(totais_popf))

# Junção dos bancos (base sidra_1 + sidra_2 + faixas etárias) pela chave CODMUNRES (7 dígitos)
SIDRA_MT = merge(sidra_1[, c("CODMUNRES", "POPRE_T")],
                  sidra_2[, c("CODMUNRES", "POPRC_T", "POPRC_M", "POPRC_F")], 
                  by = "CODMUNRES", all.x = TRUE)

SIDRA_MT = merge(SIDRA_MT, totais_pop, by = "CODMUNRES", all.x = TRUE)
SIDRA_MT = merge(SIDRA_MT, totais_popf, by = "CODMUNRES", all.x = TRUE)

# Adição de metadados
SIDRA_MT$ANO = 2016
SIDRA_MT$NIVEL = ifelse(SIDRA_MT$CODMUNRES == 51, "UF", "MUNICIPIO")

# Ajuste de CODMUNRES para 6 dígitos nos municípios e "51" na UF
SIDRA_MT$CODMUNRES = ifelse(SIDRA_MT$NIVEL == "UF", "51", substr(as.character(SIDRA_MT$CODMUNRES), 1, 6))

# Ordenação: linha da UF no topo e municípios ordenados pelo código
SIDRA_MT = SIDRA_MT[order(SIDRA_MT$NIVEL != "UF", SIDRA_MT$CODMUNRES), ]

# Seleção final das 13 colunas na ordem exata do arquivo de especificações
cols_ordem = c("ANO", "NIVEL", "CODMUNRES", "POPRE_T", "POPRC_T", "POPRC_M", "POPRC_F",
                "POPRC_15", "POPRC_15_49", "POPRC_50", "POPRC_F_15", "POPRC_F_15_49", "POPRC_F_50")

SIDRA_MT = SIDRA_MT[, cols_ordem]
rownames(SIDRA_MT) = NULL

# Validação das faixas etárias (a soma das faixas deve bater com a população total do Censo)
all((SIDRA_MT$POPRC_15 + SIDRA_MT$POPRC_15_49 + SIDRA_MT$POPRC_50) == SIDRA_MT$POPRC_T, na.rm = TRUE)

# Verificação do banco final
dim(SIDRA_MT)
head(SIDRA_MT)

# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SIDRA - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016

# Tarefa 5:Exportar o banco de dados com o nome SIDRA_UF.csv (Exemplo: SIDRA_RJ.csv)
# Ao terminar a Tarefa 5 commit com o comentário "dados SIDRA_UF 2016 e script - SIDRA - tarefas 1 a 5"  e envie para o repositório Projeto_BDEM_2016


####################################
# ETAPA 4: BANCOS DE DADOS DO ATLAS
####################################
# Você deve criar e estar na branch ATLAS antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Ler os bancos de dados abaixo listados com os respectivos nomes
# codigos_IBGE_2010 para códigos dos municípios - 2010.csv
# dados_atlas_1 para IDHM - 2010 (CENSO) e 2016 (PNAD) - total e por sexo - UF - Atlas Brasil.csv
# dados_atlas_2 para IDHM - 2010 - municípios - Atlas Brasil.csv
# Atenção que agora alguns arquivos só têm os nomes dos municípios e das UFs, mas não têm os códigos

# Verificar se a leitura de todos os bancos foi feita corretamente e a estrutura dos dados

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - ATLAS - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2: Manipular o banco de dados e criar o banco de dados ATLAS_UF

# Criar o banco UF_codigo tipo tabela de correspondência
UF_codigo = data.frame(
  UF = c("Rondônia","Acre","Amazonas","Roraima","Pará","Amapá","Tocantins",
         "Maranhão","Piauí","Ceará","Rio Grande do Norte","Paraíba",
         "Pernambuco","Alagoas","Sergipe","Bahia","Minas Gerais",
         "Espírito Santo","Rio de Janeiro","São Paulo","Paraná",
         "Santa Catarina","Rio Grande do Sul","Mato Grosso do Sul",
         "Mato Grosso","Goiás","Distrito Federal"),
  
  SIGLA = c("RO","AC","AM","RR","PA","AP","TO",
            "MA","PI","CE","RN","PB","PE","AL",
            "SE","BA","MG","ES","RJ","SP",
            "PR","SC","RS","MS","MT","GO","DF"),
  
  CODUF = c(11,12,13,14,15,16,17,
            21,22,23,24,25,26,27,
            28,29,31,32,33,35,
            41,42,43,50,51,52,53)
)

# Retirar de dados_atlas_1 a linha do Brasil e adicionar (com merge by UF) as colunas de UF_codigo

# Criar o banco linha_estado somente com as linhas da UF e com as seguintes colunas:
# ANO=2016, NIVEL=UF, CODMUNRES, IDHM_A, IDHM_CA, IDHM_CA_M e IDHM_CA_F 

# Selecionar de linha_estado a UF da responsabilidade do aluno por CODMUNRES

# Criar em dados_atlas_2 a coluna com UF

# Retirar (UF) da variável município

# Acrescentar em codigos_IBGE_2010 a variável CODUF baseado nos dois primeiros dígitos de CODMUNRES

# Acrescentar a codigos_IBGE_2010 as variáveis de UF_codigo (merge by CODUF)

# Associar dados_atlas_2 a codigos_IBGE_2010 e nomear o novo arquivo por atlas_municipio
# Neste caso o merge será by.x = c("município","UF") e by.y = c("município","SIGLA")

# Remover de atlas_municipio a coluna UF.y criada no merge

# Selecionar somente a UF de responsabilidade do aluno através dos dois primeiros dógitos de CODMUNRES

# Criar banco ATLAS_MUNICIPIO com as linhas dos municípios e com as seguintes variáveis:
# ANO=2016, NIVEL=MUNICIPIO, CODMUNRES, IDHM_A=NA, IDHM_CA, IDHM_CA_M=NA, IDHM_CA_F=NA

# Criar banco final ATLAS_UF "juntando" os bancos linha_estado e ATLAS_MUNICIPIO


# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - ATLAS - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Exportar o banco de dados com o nome ATLAS_UF.csv (Exemplo: ATLAS_RJ.csv)
# Ao terminar a Tarefa 3 commit com o comentário "dados ATLAS_UF 2016 e script - ATLAS - tarefas 1 a 3"  e envie para o repositório Projeto_BDEM_2016



####################################
# ETAPA 5: BANCOS DE DADOS DO SINISA
####################################
# Você deve criar e estar na branch SINISA antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Ler o bancos de dados abaixo listado com os respectivo nome
# dados_sinisa para agua e esgoto - município - 2016.csv
# Atenção que o arquivo tem códigos e nomes de municípios e muitos NAs. 
# Repare que os valores estão com o milhar indicado por ponto, o que não deve acontecer para o R não entender como decimal

# Verificar se a leitura de todos os bancos foi feita corretamente e a estrutura dos dados
# Remover a pontuação de milhar e converter para formato numérico

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SINISA - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2. Reduzir dados_sinisa apenas para o estado que o aluno irá trabalhar (utilizar os dois primeiros dígitos de CODMUNRES), nomeando este novo banco de dados como dados_sinisa_1

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SINISA - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Criar um banco de dados, de nome SINISA_UF.csv (Exemplo: SINISA_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 3 - SINISA.pdf”

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SINISA - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Exportar o banco de dados com o nome SINISA_UF.csv (Exemplo: SINISA_RJ.csv)
# Ao terminar a Tarefa 4 commit com o comentário "dados SINISA_UF 2016 e script - SINISA - tarefas 1 a 4"  e enviar para o repositório Projeto_BDEM_2016



################################
# ETAPA 6: CRIAÇÃO DE BDEM_UF
################################
# Você deve estar agora em main e antes de inserir qualquer comando desta ETAPA
# deverá fazer os merges de cada uma das 5 branches. A cada merge pode fazer o comentário "merge da branch TAL"
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Agregar os arquivos SIDRA_UF, ATLAS_UF, SINASC_UF, SIM_UF, SINISA_UF no banco BDEM_UF (Exemplo: BDEM_RJ)
# Leitura dos 5 bancos de dados expeortados das etapas anteriores

# Agregação dos bancos
# Lembre-se que SIDRA e ATLAS tem CODMUNRES com 7 dígitos e SINASC, SIM e SINISA com 6 dígitos
# Além disso dentro do merge all = TRUE garante a manutenção de qualquer município presente em um dos bancos envolvidos no merge


# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - BDEM - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2: Inserir os seguintes indicadores epidemiológicos (com apenas dias casas decimais) no BDEM_UF:
# TFG: Taxa de fecundidade geral
# TMG: Taxa de mortalidade geral
# RMM: Razão de mortalidade materna
# TMM: Taxa de mortalidade materna
# TMM_P: Taxa de mortalidade materna em até 42 dias
# TMN: Taxa de mortalidade neonatal
# TMN_P: Taxa de mortalidade neonatal precoce
# TMN_T: Taxa de mortalidade neonatal tardia
# TMI: Taxa de mortalidade infantil

# Conferir o banco BDEM_UF após inserção dos indicadores

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - BDEM - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3: Exportar o banco de dados com o nome BDEM_UF.csv (Exemplo: BDEM_RJ.csv)
# Ao terminar a Tarefa 3 commit com o comentário "dados BDEM_UF 2016 e script - BDEM - tarefas 1 a 3"  e enviar para o repositório Projeto_BDEM_2016
 