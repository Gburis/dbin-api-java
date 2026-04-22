package com.gburis.dbin.service;

import com.gburis.dbin.dto.ResponsavelRequestDTO;
import com.gburis.dbin.exceptions.ApiErro;
import com.gburis.dbin.model.Responsavel;
import com.gburis.dbin.repository.LocalColetaRepository;
import com.gburis.dbin.repository.ResponsavelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ResponsavelService {

    @Autowired
    private ResponsavelRepository responsavelRepository;

    @Autowired
    private LocalColetaRepository localColetaRepository;

    public List<ResponsavelRequestDTO> listar() {
        return responsavelRepository
                .findAll()
                .stream()
                .map(ResponsavelRequestDTO::new)
                .toList();
    }

    public Responsavel buscarPorId(Long id) {
        return responsavelRepository.findById(id)
                .orElseThrow(() -> new ApiErro("Responsável não encontrado"));
    }

    public Responsavel criar(ResponsavelRequestDTO request) {
        Optional<Responsavel> existente = responsavelRepository.findByEmail(request.email());

        if (existente.isPresent()) {
            throw new ApiErro("E-mail já está em uso: " + request.email());
        }

        Responsavel r = new Responsavel();
        r.setNome(request.nome());
        r.setEmail(request.email());
        r.setTelefone(request.telefone() != null ? request.telefone() : null);
        return responsavelRepository.save(r);
    }

    public Responsavel alterar(Long id, ResponsavelRequestDTO request) {
        Boolean alterado = false;

        Responsavel existente = buscarPorId(id);

        if (request.email() != null && !request.email().equalsIgnoreCase(existente.getEmail())) {
            if (responsavelRepository.existsByEmailAndIdNot(request.email(), id)) {
                throw new ApiErro("O e-mail informado já está em uso por outro responsável.");
            }
            existente.setEmail(request.email());
            alterado = true;
        }

        if (request.nome() != null && !request.nome().isBlank()) {
            existente.setNome(request.nome());
            alterado = true;
        }
        if (request.telefone() != null) {
            existente.setTelefone(request.telefone());
            alterado = true;
        }

        if(!alterado) {
            throw new ApiErro("É necessario alterar ao menos uma informação.");
        }

        return responsavelRepository.save(existente);
    }

    public void deletar(Long id) {
        buscarPorId(id);

        boolean possuiLocal = localColetaRepository.existsByResponsavel_Id(id);

        if (possuiLocal) {
            throw new ApiErro("Não é possível excluir: o responsável está vinculado a um local de coleta.");
        }
        responsavelRepository.deleteById(id);
    }
}
