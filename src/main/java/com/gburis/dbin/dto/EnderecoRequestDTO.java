package com.gburis.dbin.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record EnderecoRequestDTO(
        String logradouro,
        String numero,
        String bairro,
        @NotBlank String cidade,
        @NotBlank String uf,
        @NotNull Long cep
) { }
