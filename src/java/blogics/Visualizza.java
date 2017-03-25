/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package blogics;
import java.sql.*;
import services.databaseservice.*;
import services.databaseservice.exception.DuplicatedRecordDBException;
import services.databaseservice.exception.NotFoundDBException;
import services.databaseservice.exception.ResultSetDBException;
import util.Conversion;
/**
 *
 * @author filippo
 * Questa relazione tiene traccia dei prodotti
 * che l'utente ha visualizzato
 * dove per visualizzare si intende la visione
 * dei dettagli prodotto
 */
public class Visualizza {
   public Long productCode;
   public String cduser;
   
   public Visualizza(Long productCode,String cduser) {
       this.productCode = productCode;
       this.cduser = cduser;
   }
   
   public Visualizza(ResultSet resultSet) {
       try { productCode = new Long(resultSet.getLong("productcode")); }
        catch(SQLException sqle) {}
       try { cduser = resultSet.getString("cduser"); }
        catch(SQLException sqle) {}
  
   }
   
   public void insert(DataBase database) throws NotFoundDBException,
            DuplicatedRecordDBException,ResultSetDBException {
       
       /*check di unicità
       se l'utente ha già visualizzato il prodotto, la nuova
       visualizzazione non viene inserita nel database
       */
       String sql = " select * "
               + " from visualizza "
               + " where cduser='"+Conversion.getDatabaseString(cduser)+"' and productcode="+productCode;
       
       ResultSet resultSet = database.select(sql);;
       boolean exist = false;
       try { 
           exist = resultSet.next();
           resultSet.close();
       }
       catch(SQLException e) {
           throw new ResultSetDBException("Visualizza: insert() errore sul resultSet");
           
       }
       
       /* se non esiste inserisco la visualizzazione nel db*/
       if (!exist){
           
           sql = " insert into visualizza(productcode,cduser) "
                   + " values("+productCode+",'"+Conversion.getDatabaseString(cduser)+"')";
           
           database.modify(sql);
       }
    
   }
}
