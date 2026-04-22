package com.gburis.dbin.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "T_ENDERECO_COLETA")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class EnderecoColeta {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "END_SEQ")
    @SequenceGenerator(name = "END_SEQ", sequenceName = "SEQ_ENDERECO", allocationSize = 1)
    @Column(name = "ID_ENDERECO")
    private Long id;

    @Column(name = "LOGRADOURO", nullable = false, length = 60)
    private String logradouro;

    @Column(name = "NUMERO", nullable = false, length = 5)
    private String numero;

    @Column(name = "NM_BAIRRO", nullable = false, length = 60)
    private String bairro;

    @Column(name = "NM_CIDADE", nullable = false, length = 40)
    private String cidade;

    @Column(name = "UF", nullable = false, length = 2)
    private String uf;

    @Column(name = "CEP", nullable = false)
    private Long cep;
}
