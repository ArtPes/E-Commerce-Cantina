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
 * @author filippo
 */
public class Pagamento {
    public Long id;
    public java.util.Date data;
    public String stato;
    public Long idordine;
    public double importo_pagamento;
    
    public Pagamento(java.util.Date data,String stato,Long idordine,double importo_pagamento) {
        
       // this.id = id;
        this.data = data;
        this.stato = stato;
        this.idordine = idordine;
        this.importo_pagamento = importo_pagamento;
    }
    
    public Pagamento(ResultSet resultSet) {
        try { id = new Long(resultSet.getLong("id")); }
            catch(SQLException sqle) {}
        try { data = resultSet.getDate("data"); }
            catch(SQLException sqle) {}
        try { stato = resultSet.getString("stato"); }
            catch(SQLException sqle) {}
        try { idordine = new Long(resultSet.getLong("idordine")); }
            catch(SQLException sqle) {}
        try { importo_pagamento = resultSet.getDouble("importo_pagamento");}
        catch(SQLException sqle) {}
    }
    public void insert(DataBase database) 
            throws NotFoundDBException,DuplicatedRecordDBException,
            ResultSetDBException {
        
        String sql="";
        
        /*check di unicità per il nome della categoria*/
        sql += "select id from pagamento where idordine ='"+idordine+"'";
        ResultSet resultSet = database.select(sql);
        
        boolean exist = false;
        try {
        exist = resultSet.next();
        resultSet.close();
        } catch(SQLException e) {
            throw new ResultSetDBException("Pagamento: insert() "
                    + "Errore su ResultSet");
        }
        if (exist) {
            throw new DuplicatedRecordDBException("Pagamento: insert():"
                    + " Pagamento già esistente");
        }
        
       
        
        sql = "insert into pagamento(data,idordine,importo_pagamento,stato) "
                + " values('"+Conversion.convertJavaDateToSqlDate(data)+"',"+idordine+","+importo_pagamento+",'"+Conversion.getDatabaseString(stato)+"')";
        database.modify(sql);
        
    }

}
