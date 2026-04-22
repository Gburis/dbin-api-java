package com.gburis.dbin.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "T_RESPONSAVEL")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Responsavel {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "RESP_SEQ")
    @SequenceGenerator(name = "RESP_SEQ", sequenceName = "SEQ_RESPONSAVEL", allocationSize = 1)
    @Column(name = "ID_RESPONSAVEL")
    private Long id;

    @Column(name = "NM_RESPONSAVEL", nullable = false, length = 60)
    private String nome;

    @Column(name = "EMAIL", nullable = false, length = 60)
    private String email;

    @Column(name = "TELEFONE")
    private Long telefone;
}
