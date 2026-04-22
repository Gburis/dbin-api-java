package com.gburis.dbin.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record LocalColetaRequestDTO(
        @NotNull Long idResponsavel,
        EnderecoRequestDTO endereco,
        @NotNull @Positive Double pctAlerta,
        @NotNull @Positive Double kgLimite,
        @NotNull Double kgAtual
) {

}
