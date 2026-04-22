package com.gburis.dbin.service;

import com.gburis.dbin.dto.LocalColetaRequestDTO;
import com.gburis.dbin.dto.EnderecoRequestDTO;
import com.gburis.dbin.exceptions.ApiErro;
import com.gburis.dbin.model.EnderecoColeta;
import com.gburis.dbin.model.LocalColeta;
import com.gburis.dbin.model.Responsavel;
import com.gburis.dbin.repository.EnderecoColetaRepository;
import com.gburis.dbin.repository.LocalColetaRepository;
import com.gburis.dbin.repository.ResponsavelRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Service
public class LocalColetaService {

    private final LocalColetaRepository localRepo;
    private final EnderecoColetaRepository enderecoRepo;
    private final ResponsavelRepository respRepo;

    public LocalColetaService(LocalColetaRepository localRepo,
                              EnderecoColetaRepository enderecoRepo,
                              ResponsavelRepository respRepo) {
        this.localRepo = localRepo;
        this.enderecoRepo = enderecoRepo;
        this.respRepo = respRepo;
    }

    public LocalColeta criar(LocalColetaRequestDTO request) {
        Responsavel resp = respRepo.findById(request.idResponsavel())
                .orElseThrow(() -> new ApiErro("Responsável não encontrado"));

        EnderecoColeta end = salvarEndereco(request.endereco());

        LocalColeta local = new LocalColeta();
        local.setResponsavel(resp);
        local.setEndereco(end);
        local.setPctAlerta(BigDecimal.valueOf(request.pctAlerta()));
        local.setKgLimite(BigDecimal.valueOf(request.kgLimite()));
        local.setKgAtual(BigDecimal.valueOf(request.kgAtual()));

        return localRepo.save(local);
    }

    private EnderecoColeta salvarEndereco(EnderecoRequestDTO req) {
        EnderecoColeta end = new EnderecoColeta();
        end.setLogradouro(req.logradouro());
        end.setNumero(req.numero());
        end.setBairro(req.bairro());
        end.setCidade(req.cidade());
        end.setUf(req.uf());
        end.setCep(req.cep());
        return enderecoRepo.save(end);
    }

    public LocalColeta alterar(Long id, LocalColetaRequestDTO request) {

        LocalColeta local = localRepo.findById(id)
                .orElseThrow(() -> new ApiErro("Ponto de coleta não encontrado"));

        Responsavel resp = respRepo.findById(request.idResponsavel())
                .orElseThrow(() -> new ApiErro("Responsável não encontrado"));

        local.setResponsavel(resp);
        local.setPctAlerta(BigDecimal.valueOf(request.pctAlerta()));
        local.setKgLimite(BigDecimal.valueOf(request.kgLimite()));
        local.setKgAtual(BigDecimal.valueOf(request.kgAtual()));

        return localRepo.save(local);
    }

}
