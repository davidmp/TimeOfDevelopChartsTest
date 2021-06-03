/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.syscenter.dao;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pe.com.syscenter.modelo.Data1;

/**
 *
 * @author LAB REDES
 */
@Repository
public interface Data1Repository extends JpaRepository<Data1, Integer>{
    Optional<Data1> findByMes(String mes);
    boolean existsByMes(String mes);    
}
