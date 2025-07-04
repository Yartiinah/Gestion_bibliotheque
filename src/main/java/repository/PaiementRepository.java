package repository;

import model.Paiement;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PaiementRepository extends JpaRepository<Paiement, Integer> {
    List<Paiement> findByAdherentId(int adherentId);
}
