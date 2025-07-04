package repository;

import model.Exemplaire;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ExemplaireRepository extends JpaRepository<Exemplaire, Integer> {
    Optional<Exemplaire> findByReference(String reference);
}