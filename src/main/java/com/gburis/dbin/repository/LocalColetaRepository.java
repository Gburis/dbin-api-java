package com.gburis.dbin.repository;

import com.gburis.dbin.model.LocalColeta;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LocalColetaRepository extends JpaRepository<LocalColeta, Long> {
    boolean existsByResponsavel_Id(Long idResponsavel);
}
