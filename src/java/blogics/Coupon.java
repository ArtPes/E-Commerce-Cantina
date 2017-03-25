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
 * @author arturo e riki

 */
public class Coupon {
    
    public Long id;
    public String cduser;
    public double importo;
    public java.util.Date data_inizio;
    public java.util.Date data_fine;
    public int usato;
    
    /*costruttore senza il parametro id, perchè il campo è autoincrementante*/
    public Coupon(String cduser,double importo,
            java.util.Date data_inizio,java.util.Date data_fine,int usato) {
        //this.id = id; 
        this.cduser = cduser;
        this.importo = importo;
        this.data_inizio = data_inizio;
        this.data_fine = data_fine;
        this.usato = usato;
               
    }
    
    public Coupon(ResultSet resultSet) {
        try { id = new Long(resultSet.getLong("id"));}
            catch(SQLException sqle) {}
        try { cduser = resultSet.getString("cduser");}
            catch(SQLException sqle) {}
        try { importo = resultSet.getDouble("importo"); }
            catch(SQLException sqle) {}
        try { data_inizio = resultSet.getDate("data_inizio"); }
            catch(SQLException sqle) {}
        try { usato = resultSet.getInt("usato");}
            catch(SQLException sqle) {}
        try { data_fine = resultSet.getDate("data_fine"); }
            catch(SQLException sqle) {}
    }
     public void insert(DataBase database) throws NotFoundDBException,
            ResultSetDBException {
       
         /*non posso avere exception di duplicazione perchè ho una  chiave autoincremnt*/
     
          String sql = " insert into coupon(cduser,data_inizio,data_fine,importo,usato) "
                   + " values('"+Conversion.getDatabaseString(cduser)+"','"+Conversion.convertJavaDateToSqlDate(data_inizio)+"','"
                   +Conversion.convertJavaDateToSqlDate(data_fine)+"',"+importo+","+usato+")";
           
           database.modify(sql);
       
    
   }
     
    public void delete(DataBase database) throws NotFoundDBException,
            DuplicatedRecordDBException,ResultSetDBException {
        
        String sql =" update coupon set usato=1 "
                + " where id="+id;
        
        database.modify(sql);
        
    }
    
}
