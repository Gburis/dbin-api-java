package com.gburis.dbin.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Entity
@Table(name = "T_LOCAL_COLETA")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LocalColeta {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "LOCAL_SEQ")
    @SequenceGenerator(name = "LOCAL_SEQ", sequenceName = "SEQ_LOCAL", allocationSize = 1)
    @Column(name = "ID_LOCAL")
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "ID_ENDERECO")
    private EnderecoColeta endereco;

    @ManyToOne(optional = false)
    @JoinColumn(name = "ID_RESPONSAVEL")
    private Responsavel responsavel;

    @Column(name = "PCT_ALERTA", nullable = false)
    private BigDecimal pctAlerta;

    @Column(name = "KG_LIMITE", nullable = false)
    private BigDecimal kgLimite;

    @Column(name = "KG_ATUAL", nullable = false)
    private BigDecimal kgAtual;
}
