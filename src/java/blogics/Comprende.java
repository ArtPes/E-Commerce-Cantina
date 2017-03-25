/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package blogics;
import java.sql.*;
import services.databaseservice.DataBase;
import services.databaseservice.exception.*;

public class Comprende {
    public Long productcode;
    public Long idordine;
    public Long qta;
    
    /**
     * costruttore dell'oggetto Composto_da
     * @param idordine idordine
     * @param productcode productcode
     * @param qta quantita' prodotto
     */
    public Comprende(Long idordine,Long productcode,Long qta){
        this.productcode = productcode;
        this.idordine = idordine;
	this.qta = qta;
    }
    
    public  Comprende(ResultSet resultSet) {
        try { productcode = new Long(resultSet.getLong("productcode")); }
            catch(SQLException sqle) {}
        try { idordine = new Long(resultSet.getLong("idordine")); }
            catch(SQLException sqle) {}
	try { qta = new Long(resultSet.getLong("qta")); }
	    catch(SQLException sqle) {}
            
    }
    
    /**
     * metodo per l'inserimento di un recordo in Composto_da
     * @param database connessione al db
     * @throws NotFoundDBException exception di db non trovato 
     * @throws DuplicatedRecordDBException se si verifica un exception di
     * duplicazione record
     * @throws ResultSetDBException exception sul resultset
     */
     public void insert(DataBase database) throws NotFoundDBException,
            DuplicatedRecordDBException,ResultSetDBException {
       
       /*check di unicità
       se l'utente ha già inserito tale prodotto nll'ordine
	viene generata un exception
       */
       String sql = " select * "
               + " from comprende "
               + " where idordine="+idordine+" and productcode="+productcode+" and qta="+qta;
       
       ResultSet resultSet = database.select(sql);;
       boolean exist = false;
       try { 
           exist = resultSet.next();
           resultSet.close();
       }
       catch(SQLException e) {
           throw new ResultSetDBException("Comprende: insert() errore sul resultSet");
           
       }
       
       /* lancio dbduplicatedrecordexception*/
       if (exist){
           throw new DuplicatedRecordDBException("ComprendeService: insert() duplicazione record");
       }
	/*inserisco il record dell'ordine*/
	
           sql = " insert into comprende(idordine,productcode,qta) "
                   + " values("+idordine+","+productcode+","+qta+")";
           
           database.modify(sql);
    
   }                    
}
