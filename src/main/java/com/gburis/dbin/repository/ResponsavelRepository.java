package com.gburis.dbin.repository;

import com.gburis.dbin.model.Responsavel;
import jakarta.validation.constraints.Email;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ResponsavelRepository extends JpaRepository<Responsavel, Long> {
    Optional<Responsavel> findByEmail(@Email String email);

    boolean existsByEmailAndIdNot(String email, Long id);
}
