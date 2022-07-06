library(tidyverse);
vars <- list(
        AnoBase = sym("AN_BASE"),
        Regiao = sym("NM_REGIAO"),
        SiglaIes = sym("SG_ENTIDADE_ENSINO"),
        NomePrograma = sym("NM_PROGRAMA"),
        GrandeAreaDescricao = sym("NM_GRANDE_AREA_CONHECIMENTO"),
        AreasConhecimento = sym("NM_AREA_CONHECIMENTO"),
        Nivel = sym("NM_GRAU_ACADEMICO"),
        DataDefesa = sym("DT_TITULACAO")
);
df3 <- select(br.capes.btd.2013a2016.2017.12.01_2013, !!!vars)