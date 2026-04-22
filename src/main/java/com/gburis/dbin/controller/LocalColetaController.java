package com.gburis.dbin.controller;

import com.gburis.dbin.dto.LocalColetaRequestDTO;
import com.gburis.dbin.model.LocalColeta;
import com.gburis.dbin.service.LocalColetaService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/pontos-coleta")
public class LocalColetaController {

    @Autowired
    private  LocalColetaService service;

    @PostMapping
    public ResponseEntity<LocalColeta> criar(@RequestBody @Valid LocalColetaRequestDTO request) {
        LocalColeta salvo = service.criar(request);
        return ResponseEntity.status(201).body(salvo);
    }

    @PutMapping("/{id}")
    public ResponseEntity<LocalColeta> alterar(@PathVariable Long id,
                                               @RequestBody @Valid LocalColetaRequestDTO request) {
        LocalColeta atualizado = service.alterar(id, request);
        return ResponseEntity.ok(atualizado);
    }
}
