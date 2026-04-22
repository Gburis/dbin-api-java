package com.gburis.dbin.dto;

import com.gburis.dbin.model.Responsavel;
import jakarta.validation.constraints.Email;

public record ResponsavelRequestDTO(
        Long id,
        String nome,
         @Email String email,
        Long telefone
) {
    public ResponsavelRequestDTO(Responsavel responsavel) {
        this(
                responsavel.getId(),
                responsavel.getNome(),
                responsavel.getEmail(),
                responsavel.getTelefone()
        );
    }
}
