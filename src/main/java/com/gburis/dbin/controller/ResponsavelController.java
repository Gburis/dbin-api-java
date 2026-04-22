package com.gburis.dbin.controller;

import com.gburis.dbin.dto.ResponsavelRequestDTO;
import com.gburis.dbin.model.Responsavel;
import com.gburis.dbin.service.ResponsavelService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/funcionarios")
public class ResponsavelController {

    @Autowired
    private ResponsavelService service;


    @GetMapping
    public List<ResponsavelRequestDTO> listar() {
        return service.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Responsavel> buscarPorId(@PathVariable Long id) {
        try {
            return ResponseEntity.ok(service.buscarPorId(id));
        }catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping("/cadastrar")
    public ResponseEntity<Responsavel> criar(@RequestBody @Valid ResponsavelRequestDTO request) {
        return ResponseEntity.ok(service.criar(request));
    }

    @PutMapping("/{id}")
    public Responsavel alterar(@PathVariable Long id,
                               @RequestBody @Valid ResponsavelRequestDTO request) {
        return service.alterar(id, request);
    }

    @DeleteMapping("/{id}")
    public void deletar(@PathVariable Long id) {
        service.deletar(id);
    }
}
