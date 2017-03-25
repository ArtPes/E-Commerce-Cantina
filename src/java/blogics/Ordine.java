/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package blogics;
import java.sql.*;
import java.util.Date.*;
import services.databaseservice.DataBase;
import services.databaseservice.exception.DuplicatedRecordDBException;
import services.databaseservice.exception.NotFoundDBException;
import services.databaseservice.exception.ResultSetDBException;
import util.Conversion;
/**
 *
 * @author arturo
 */
public class Ordine {
    public Long idordine;
    public java.util.Date data_ordine;
    public String via;
    public String citta;
    public String cap;
    public java.util.Date data_consegna;
    public String cduser;
    public String stato;
    
    public Ordine(java.util.Date data_ordine,String via,
                    String citta, String cap,
                    java.util.Date data_consegna,String cduser){
        /*l'id dell'ordine è una chiave autoincrement*/
        this.data_ordine = data_ordine;
        this.via = via;
        this.citta = citta;
        this.cap = cap;
        this.data_consegna = data_consegna;
        this.cduser = cduser;
              
    } 
    public Ordine(ResultSet resultSet) {
        try { idordine = new Long(resultSet.getLong("idordine"));}
            catch(SQLException sqle) {}
        try { data_ordine = resultSet.getDate("data_ordine"); }
            catch(SQLException sqle) {}
        try { via = resultSet.getString("via"); }
            catch(SQLException sqle) {}
        try { citta = resultSet.getString("citta"); }
            catch(SQLException sqle) {}
        try { cap = resultSet.getString("cap"); }
            catch(SQLException sqle) {}
         try { stato = resultSet.getString("stato"); }
            catch(SQLException sqle) {}
        try { data_consegna = resultSet.getDate("data_consegna"); }
            catch(SQLException sqle) {}
        try { cduser =  resultSet.getString("cduser"); }
            catch(SQLException sqle) {}
    }
     public void insert(DataBase database)
             throws NotFoundDBException,DuplicatedRecordDBException,ResultSetDBException {
       

      String sql="";

       sql = " insert into ordine(data_ordine,via,citta,cap,data_consegna,cduser) "
                   + " values('"+Conversion.convertJavaDateToSqlDate(data_ordine)+"',"+
                   "'"+Conversion.getDatabaseString(via)+"',"+
                   "'"+Conversion.getDatabaseString(citta)+"',"+
                   "'"+Conversion.getDatabaseString(cap)+"',"+
                   "'"+Conversion.convertJavaDateToSqlDate(data_consegna)+"','"+Conversion.getDatabaseString(cduser)+"')";
           
           database.modify(sql);
    
   }
   
}

