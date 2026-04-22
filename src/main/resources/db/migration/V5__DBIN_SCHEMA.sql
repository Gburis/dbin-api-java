/*
    Criação DATBASE DBin
    Estrutura base das tabelas, chaves estrangeiras e sequências
*/

-- INI T_ALERTA
CREATE TABLE t_alerta (
                          id_alerta    NUMBER(10) NOT NULL,
                          id_local     NUMBER(10) NOT NULL,
                          dt_hr_alerta TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
                          mensagem     VARCHAR2(150) NOT NULL,
                          coletado     CHAR(1) NOT NULL
);

ALTER TABLE t_alerta ADD CONSTRAINT t_alerta_pk PRIMARY KEY ( id_alerta, id_local );
CREATE SEQUENCE seq_alerta START WITH 1 INCREMENT BY 1;
-- FIM T_ALERTA

-- INI T_COLETA
CREATE TABLE t_coleta (
                          id_coleta    NUMBER(10) NOT NULL,
                          cod_material CHAR(3) NOT NULL,
                          id_local     NUMBER(10) NOT NULL,
                          dt_hr_coleta TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
                          kg_coletado  NUMBER(15, 5) NOT NULL,
                          calculado    CHAR(1)
);

ALTER TABLE t_coleta ADD CONSTRAINT t_coleta_pk PRIMARY KEY ( id_coleta, cod_material, id_local );
CREATE SEQUENCE seq_coleta START WITH 1 INCREMENT BY 1;
-- FIM T_COLETA

-- INI T_ENDERECO_COLETA
CREATE TABLE t_endereco_coleta (
                                   id_endereco NUMBER(10) NOT NULL,
                                   logradouro  VARCHAR2(60) NOT NULL,
                                   numero      VARCHAR2(5) NOT NULL,
                                   nm_bairro   VARCHAR2(60) NOT NULL,
                                   nm_cidade   VARCHAR2(40) NOT NULL,
                                   uf          VARCHAR2(2) NOT NULL,
                                   cep         NUMBER(8) NOT NULL
);

ALTER TABLE t_endereco_coleta ADD CONSTRAINT t_endereco_coleta_pk PRIMARY KEY ( id_endereco );
CREATE SEQUENCE seq_endereco START WITH 1 INCREMENT BY 1;
-- FIM T_ENDERECO_COLETA

-- INI T_LOCAL_COLETA
CREATE TABLE t_local_coleta (
                                id_local       NUMBER(10) NOT NULL,
                                id_endereco    NUMBER(10) NOT NULL,
                                id_responsavel NUMBER(10) NOT NULL,
                                pct_alerta     NUMBER(3, 2) NOT NULL,
                                kg_limite      NUMBER(10, 3) NOT NULL,
                                kg_atual       NUMBER(10, 3) NOT NULL
);

ALTER TABLE t_local_coleta ADD CONSTRAINT t_local_coleta_pk PRIMARY KEY ( id_local );
CREATE SEQUENCE seq_local START WITH 1 INCREMENT BY 1;
-- FIM T_LOCAL_COLETA

-- INI T_MATERIAL
CREATE TABLE t_material (
                            cod_material CHAR(3) NOT NULL,
                            nm_material  VARCHAR2(10) NOT NULL
);

ALTER TABLE t_material ADD CONSTRAINT t_material_pk PRIMARY KEY ( cod_material );
-- FIM T_MATERIAL

-- INI T_RESPONSAVEL
CREATE TABLE t_responsavel (
                               id_responsavel NUMBER(10) NOT NULL,
                               nm_responsavel VARCHAR2(60) NOT NULL,
                               email          VARCHAR2(60) NOT NULL,
                               telefone       NUMBER(15)
);

ALTER TABLE t_responsavel ADD CONSTRAINT t_responsavel_pk PRIMARY KEY ( id_responsavel );
CREATE SEQUENCE seq_responsavel START WITH 1 INCREMENT BY 1;
-- FIM T_RESPONSAVEL

-- INI ADIÇÂO DE CHAVES ESTRANGEIRAS
ALTER TABLE t_local_coleta
    ADD CONSTRAINT t_endereco_coleta_fk FOREIGN KEY ( id_endereco )
        REFERENCES t_endereco_coleta ( id_endereco );

ALTER TABLE t_coleta
    ADD CONSTRAINT t_local_coleta_fk FOREIGN KEY ( id_local )
        REFERENCES t_local_coleta ( id_local );

ALTER TABLE t_alerta
    ADD CONSTRAINT t_local_coleta_fkv1 FOREIGN KEY ( id_local )
        REFERENCES t_local_coleta ( id_local );

ALTER TABLE t_coleta
    ADD CONSTRAINT t_material_fk FOREIGN KEY ( cod_material )
        REFERENCES t_material ( cod_material );

ALTER TABLE t_local_coleta
    ADD CONSTRAINT t_responsavel_fk FOREIGN KEY ( id_responsavel )
        REFERENCES t_responsavel ( id_responsavel );

-- FIM ADIÇÂO DE CHAVES ESTRANGEIRAS


/*
    Inserir Informações nas tabelas
*/

-- INSERIR INFORMAÇÕES ENDERECO

INSERT INTO t_endereco_coleta VALUES (seq_endereco.nextval, 'Av. Presidente Vargas', '320', 'Centro', 'Itanhaém', 'SP', 11740000);
INSERT INTO t_endereco_coleta VALUES (seq_endereco.nextval, 'Rua João Mariano Ferreira', '85', 'Savoy', 'Itanhaém', 'SP', 11742030);
INSERT INTO t_endereco_coleta VALUES (seq_endereco.nextval, 'Rua Urcezino Ferreira', '210', 'Gaivota', 'Itanhaém', 'SP', 11740000);
INSERT INTO t_endereco_coleta VALUES (seq_endereco.nextval, 'Rua Benedito Calixto', '450', 'Suarão', 'Itanhaém', 'SP', 11740100);
INSERT INTO t_endereco_coleta VALUES (seq_endereco.nextval, 'Rua do Meio', '60', 'Cibratel II', 'Itanhaém', 'SP', 11740050);

--INSERIR INFORMAÇÃO MATERIAL
INSERT INTO t_material VALUES ('PAP', 'Papel');
INSERT INTO t_material VALUES ('PLA', 'Plástico');
INSERT INTO t_material VALUES ('VID', 'Vidro');
INSERT INTO t_material VALUES ('MET', 'Metal');
INSERT INTO t_material VALUES ('ORG', 'Orgânico');

-- INSERIR INFORMAÇÃO RESPONSAVEL
INSERT INTO t_responsavel VALUES (seq_responsavel.nextval, 'Gabriel Olimpio', 'gabriel@dbin.com', 13999990001);
INSERT INTO t_responsavel VALUES (seq_responsavel.nextval, 'Amanda Olimpio',  'amanda@dbin.com',  13999990002);
INSERT INTO t_responsavel VALUES (seq_responsavel.nextval, 'Rafael Olimpio',  'rafael@dbin.com',  13999990003);
INSERT INTO t_responsavel VALUES (seq_responsavel.nextval, 'Pedro Olimpio',   'pedro@dbin.com',   13999990004);
INSERT INTO t_responsavel VALUES (seq_responsavel.nextval, 'Emanuel Olimpio', 'emanuel@dbin.com', 13999990005);

-- INSERIR INFORMAÇÃO LOCAL
INSERT INTO t_local_coleta VALUES (seq_local.nextval, 1, 1, 0.80, 500, 380); -- Centro – Gabriel Olimpio
INSERT INTO t_local_coleta VALUES (seq_local.nextval, 2, 2, 0.75, 450, 300); -- Savoy – Amanda Olimpio
INSERT INTO t_local_coleta VALUES (seq_local.nextval, 3, 3, 0.85, 600, 520); -- Gaivota – Rafael Olimpio
INSERT INTO t_local_coleta VALUES (seq_local.nextval, 4, 4, 0.80, 550, 200); -- Suarão – Pedro Olimpio
INSERT INTO t_local_coleta VALUES (seq_local.nextval, 5, 5, 0.70, 400, 390); -- Cibratel II – Emanuel Olimpio

-- INSERIR INFORMAÇÃO COLETA JÁ CALCULADO
INSERT INTO t_coleta VALUES (seq_coleta.nextval, 'PAP', 1, SYSTIMESTAMP, 120, 1); -- Centro – Papel
INSERT INTO t_coleta VALUES (seq_coleta.nextval, 'PLA', 2, SYSTIMESTAMP, 80,  1);  -- Savoy – Plástico
INSERT INTO t_coleta VALUES (seq_coleta.nextval, 'VID', 3, SYSTIMESTAMP, 150, 1); -- Gaivota – Vidro
INSERT INTO t_coleta VALUES (seq_coleta.nextval, 'MET', 4,  SYSTIMESTAMP, 90, 1);  -- Suarão – Metal
INSERT INTO t_coleta VALUES (seq_coleta.nextval, 'ORG', 5,  SYSTIMESTAMP, 200,1); -- Cibratel II – Orgânico

-- INSERIR INFORMAÇÃO ALERTA JÁ COLETADO
INSERT INTO t_alerta VALUES (seq_alerta.nextval, 1, SYSTIMESTAMP, 'Container do centro atingiu 80%, já esvaziado.', 1);
INSERT INTO t_alerta VALUES (seq_alerta.nextval, 2, SYSTIMESTAMP, 'Nível de plástico em 85%, coleta necessária.', 1);
INSERT INTO t_alerta VALUES (seq_alerta.nextval, 3, SYSTIMESTAMP, 'Coleta de vidro concluída com sucesso.', 1);
INSERT INTO t_alerta VALUES (seq_alerta.nextval, 4, SYSTIMESTAMP, 'Container de metal ultrapassou limite definido.', 1);
INSERT INTO t_alerta VALUES (seq_alerta.nextval, 5, SYSTIMESTAMP, 'Coleta orgânica realizada e validada.', 1);

/*
    Criação de Automações DBin
*/

-- GERAR ALERTA
CREATE OR REPLACE TRIGGER trg_local_gera_alerta
AFTER UPDATE OF kg_atual ON t_local_coleta
    FOR EACH ROW
DECLARE
v_pct_limite       NUMBER := NVL(:NEW.pct_alerta, 0.80); -- usa 80% se vier nulo
  v_percentual_atual NUMBER := CASE WHEN :NEW.kg_limite > 0 THEN :NEW.kg_atual / :NEW.kg_limite ELSE 0 END;
  v_alertas_abertos  NUMBER;
BEGIN

  -- Preciso buscar se já não existe alerta não coletado
SELECT COUNT(*)
INTO v_alertas_abertos
FROM t_alerta
WHERE id_local = :NEW.id_local
  AND coletado = '0';

-- gera alerta se atingiu ao limite e ainda não existe alerta coletado
IF v_percentual_atual >= v_pct_limite AND v_alertas_abertos = 0 THEN
    INSERT INTO t_alerta (id_alerta, id_local, dt_hr_alerta, mensagem, coletado)
    VALUES (
      seq_alerta.NEXTVAL,
      :NEW.id_local,
      SYSTIMESTAMP,
      'Limite atingido: '||TO_CHAR(:NEW.kg_atual)||' / '||TO_CHAR(:NEW.kg_limite)||' kg ('||
      TO_CHAR(v_pct_limite * 100)||'%).',
      '0'
    );
END IF;
END;

-- ATUALIZAR KG ATUAL COM BASE A COLETA
CREATE OR REPLACE TRIGGER trg_coleta_atualiza_saldo
AFTER INSERT ON t_coleta
FOR EACH ROW
BEGIN
UPDATE t_local_coleta
SET kg_atual = GREATEST(0, kg_atual - :NEW.kg_coletado)
WHERE id_local = :NEW.id_local;
END;

-- REMOVER ALERTA CASO O VALOR DIMINUA
CREATE OR REPLACE TRIGGER trg_local_resolve_alerta
AFTER UPDATE OF kg_atual ON t_local_coleta
    FOR EACH ROW FOLLOWS trg_local_gera_alerta
BEGIN
  IF :NEW.kg_limite > 0
     AND (:NEW.kg_atual / :NEW.kg_limite) < NVL(:NEW.pct_alerta, 0.80) THEN
UPDATE t_alerta
SET coletado  = '1',
    mensagem = SUBSTR(
            NVL(mensagem, '') || ' | ' ||
            'Parâmetros atualizados: alerta encerrado em ' ||
            TO_CHAR(SYSTIMESTAMP, 'DD/MM/YYYY HH24:MI:SS'),
            1, 150
               )
WHERE id_local = :NEW.id_local
  AND coletado = '0';
END IF;
END;

-- REOVER ALERTA CASO O LOCAL TENHA ALTERAÇÃO DE INFRA
CREATE OR REPLACE TRIGGER trg_reavalia_alerta_param
AFTER UPDATE OF pct_alerta, kg_limite ON t_local_coleta
    FOR EACH ROW
DECLARE
v_pct_limite       NUMBER := NVL(:NEW.pct_alerta, 0.80);
  v_percentual_atual NUMBER := CASE WHEN :NEW.kg_limite > 0 THEN :NEW.kg_atual / :NEW.kg_limite ELSE 0 END;
  v_alertas_abertos  NUMBER;
BEGIN
  -- (Fluxo Downgrade) Gerar Alerta caso o limite ja esteja utrapassado
  IF v_percentual_atual >= v_pct_limite THEN
SELECT COUNT(*) INTO v_alertas_abertos
FROM t_alerta
WHERE id_local = :NEW.id_local
  AND coletado = '0';

IF v_alertas_abertos = 0 THEN
      INSERT INTO t_alerta (id_alerta, id_local, dt_hr_alerta, mensagem, coletado)
      VALUES (seq_alerta.NEXTVAL, :NEW.id_local, SYSTIMESTAMP,
              'Parâmetros atualizados e ('||
              :NEW.kg_atual||' / '||:NEW.kg_limite||' kg) já atingido.', '0');
END IF;

  -- (Fluxo Upgrade) Resolver alerta caso não utrapsse novos limites
ELSE
UPDATE t_alerta
SET coletado  = '1',
    mensagem = SUBSTR(
            NVL(mensagem, '') || ' | ' ||
            'Parâmetros atualizados: alerta encerrado em ' ||
            TO_CHAR(SYSTIMESTAMP, 'DD/MM/YYYY HH24:MI:SS'),
            1, 150
               )
WHERE id_local = :NEW.id_local
  AND coletado = '0';
END IF;
END;