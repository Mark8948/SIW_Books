package siw.books.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import siw.books.model.Autore;

public interface AutoreRepository extends CrudRepository<Autore, Long> {
	@Query(value = "SELECT r.autore_id " + "FROM recensione r " + "GROUP BY r.autore_id " + "ORDER BY AVG(r.voto) DESC "
			+ "LIMIT 2", nativeQuery = true)
	List<Long> findTopAutoriIds();

	@Query("SELECT a FROM Autore a WHERE LOWER(CONCAT(a.nome, ' ', a.cognome)) LIKE LOWER(CONCAT('%', :search, '%'))")
	List<Autore> findAuthorByName(@Param("search") String search);

}