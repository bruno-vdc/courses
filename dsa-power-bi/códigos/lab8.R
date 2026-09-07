#instalando os pacotes necessários
#install.packages("tidyverse")
#install.packages("dplyr")
#install.packages("solitude")
#install.packages("ggplot2")
#install.packages("readr")

#importando as bibliotecas
library(tidyverse)
library(dplyr)
library(solitude)
library(ggplot2)
library(readr)

#carregando os dados
dados_historicos_dsa <- read_csv("C:/Users/bruno/Documents/OneDrive/cursos e estudos/cursos online de extensão/power bi/Microsoft Power BI Para Business Intelligence e Data Science/17 - machine learning e power bi para detecção de anomalias/prática/dados_historicos.csv")
View(dados_historicos_dsa)

#criando o modelo de isolationforest
?isolationForest
modelo_ml_dsa = isolationForest$new()

#treinando o modelo
modelo_ml_dsa$fit(dados_historicos_dsa)

#previsão com uso de dados históricos
previsoes_historico = dados_historicos_dsa %>%
  modelo_ml_dsa$predict() %>%
  arrange(desc(anomaly_score))

#density plot
plot(density(previsoes_historico$anomaly_score))

#definindo como anomalia quando anomaly_score>0.62
indices_historico = previsoes_historico[which(previsoes_historico$anomaly_score>0.62)]

#filtrando
anomalias_historico = dados_historicos_dsa[indices_historico$id, ]
normais_historico = dados_historicos_dsa[-indices_historico$id, ]

#plotando
colors()
ggplot() +
  geom_point(data = normais_historico,
             mapping = aes(transacao1, transacao2),
             col = "skyblue3",
             alpha = 0.5) +
  geom_point(data = anomalias_historico,
             mapping = aes(transacao1, transacao2),
             col = "red2",
             alpha = 0.8)

#carregando os novos dados
novos_dados_dsa <-read_csv("C:/Users/bruno/Documents/OneDrive/cursos e estudos/cursos online de extensão/power bi/Microsoft Power BI Para Business Intelligence e Data Science/17 - machine learning e power bi para detecção de anomalias/prática/novos_dados.csv")
View(novos_dados_dsa)

#previsões com os novos dados
previsoes_novos_dados = modelo_ml_dsa$predict(novos_dados_dsa)

#definindo como anomalia quando anomaly_score>0.62
indices_novos_dados = previsoes_novos_dados[which(previsoes_novos_dados$anomaly_score>0.62)]

#filtrando
anomalias_novos_dados = novos_dados_dsa[indices_novos_dados$id, ]
normais_novos_dados = novos_dados_dsa[-indices_novos_dados$id, ]

#plotando
colors()
ggplot() +
  geom_point(data = normais_novos_dados,
             mapping = aes(transacao1, transacao2),
             col = "skyblue3",
             alpha = 0.5) +
  geom_point(data = anomalias_novos_dados,
             mapping = aes(transacao1, transacao2),
             col = "red2",
             alpha = 0.8)

#arredondando a coluna de anomalia para 2 casas decimais
previsoes_novos_dados <- previsoes_novos_dados %>%
  mutate(anomaly_score = round(anomaly_score, 2))

#criando uma coluna com base na condição
previsoes_novos_dados <- previsoes_novos_dados %>%
  mutate(status = ifelse(anomaly_score>0.62, "anomalia", "normal"))

#criando o box plot
ggplot(previsoes_novos_dados, aes(x=status, y=anomaly_score, fill=status)) +
  geom_boxplot() +
  labs(title='Box Plot de Anomalias e Normais',
       x='Status',
       y='Anomaly Score') +
  theme_minimal() +
  scale_fill_manual(values = c("anomalia"="red", 'normal'='blue')) +
  theme(legend.position='none')

#salvando o resultado
write.csv(previsoes_novos_dados, 'previsoes_novos_dados.csv')