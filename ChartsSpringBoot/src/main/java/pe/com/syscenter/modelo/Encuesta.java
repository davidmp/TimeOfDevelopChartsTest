/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.syscenter.modelo;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.Data;

/**
 *
 * @author davidmp
 */
@Data
@Entity
@Table(name = "encuesta")

public class Encuesta implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_encuesta")
    private Integer idEncuesta;
    @Column(name = "descripcion")
    private String descripcion;
    @Column(name = "opcion1")
    private Integer opcion1;
    @Column(name = "opcion2")
    private Integer opcion2;
    @Column(name = "opcion3")
    private Integer opcion3;
    @Column(name = "opcion4")
    private Integer opcion4;
    @Column(name = "opcion5")
    private Integer opcion5;

    
}
