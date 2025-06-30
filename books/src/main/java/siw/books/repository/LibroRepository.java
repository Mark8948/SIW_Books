package siw.books.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import siw.books.model.Autore;
import siw.books.model.Libro;

public interface LibroRepository extends JpaRepository<Libro, Long> {
    // Ricerca libri per autore
    List<Libro> findByAutoriContaining(Autore autore);

    // Trova gli ID dei libri con la media voti più alta (limit 2)
    @Query(value = """
        SELECT r.libro_id
          FROM recensione r
         GROUP BY r.libro_id
         ORDER BY AVG(r.voto) DESC
        LIMIT 2
        """, nativeQuery = true)
    List<Long> findTopLibriIds();

    // Ricerca libri per titolo (case-insensitive, substring match)
    @Query("""
        SELECT l
          FROM Libro l
         WHERE LOWER(l.titolo) LIKE LOWER(CONCAT('%', :titolo, '%'))
        """)
    List<Libro> cercaPerTitoloIgnoreCase(@Param("titolo") String titolo);
}