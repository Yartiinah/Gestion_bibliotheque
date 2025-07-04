package service;

import model.Reservation;
import repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ReservationService {
    @Autowired
    private ReservationRepository reservationRepository;

    public Reservation save(Reservation reservation) {
        return reservationRepository.save(reservation);
    }

    public List<Reservation> getReservationsEnAttente() {
        return reservationRepository.findByStatut("en_attente");
    }

    public List<Reservation> getReservationsByAdherent(Integer adherentId) {
        return reservationRepository.findByAdherentId(adherentId);
    }

    public Optional<Reservation> getById(Integer id) {
        return reservationRepository.findById(id);
    }

    public void delete(Integer id) {
        reservationRepository.deleteById(id);
    }
}
