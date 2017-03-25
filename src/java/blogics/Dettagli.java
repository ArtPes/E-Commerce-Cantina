/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package blogics;

import java.sql.*;

import util.*;
import services.databaseservice.*;
import services.databaseservice.exception.*;
/**
 *
 * @author arturo e riki
 */
public class Dettagli {
     public Long productCode;
     public String adettagli;
     public String lingua;
     public Long id;
    

public Dettagli(Long productCode, String lingua,String dettagli ){
    this.productCode=productCode;
    this.lingua=lingua;
    this.adettagli = dettagli; 

}

public Dettagli(ResultSet resultSet) {
    try {productCode=new Long(resultSet.getString("productcode"));} catch(SQLException sqle) {}
    try {lingua=resultSet.getString("lingua");} catch (SQLException sqle) {}
    try {adettagli=resultSet.getString("dettagli");} catch (SQLException sqle) {} 
}


public void insertDettagli(DataBase database)
  throws NotFoundDBException,DuplicatedRecordDBException,ResultSetDBException {
    
    String sql="";
    
    /* check di unicità */
    sql+= " SELECT productcode "+
          "   FROM details "+
          " WHERE " +         
          " productcode="+productCode+" AND  lingua='"+Conversion.getDatabaseString(lingua)+"' ";
    
    ResultSet resultSet=database.select(sql);
    
    boolean exist=false;
    
    try {
      exist=resultSet.next();
      resultSet.close();
    } catch (SQLException e) {
      throw new ResultSetDBException("Contact: insert(): Errore sul ResultSet.");
    }
    
    if (exist) {
      throw new DuplicatedRecordDBException("Contact: insert(): Tentativo di inserimento di un contatto già esistente.");
    }
    
        /* generazione id */
    sql="SELECT MAX(id) AS N FROM details";
    
    try {
      resultSet=database.select(sql);
      
      if (resultSet.next())
        id = new Long(resultSet.getLong("N")+1);
      else
        id = new Long(1);
      
      resultSet.close();
      
    } catch (SQLException e) {
      throw new ResultSetDBException("Contact: insert(): Errore sul ResultSet --> impossibile calcolare CD_CONTACT.");
    }
    
    /*  inserimento nuovo dettaglio */
 
     sql=" INSERT INTO details"+
        "(id,productcode,"+
        "lingua,dettagli"+
        "   )"+
        "VALUES("+
             id+","+
        productCode+","+
        "'"+Conversion.getDatabaseString(lingua)+"',"+
        "'"+Conversion.getDatabaseString(adettagli)+"')";      

    
    database.modify(sql);
    
  }

  
  public void deleteDettagli(DataBase database) 
  throws NotFoundDBException,ResultSetDBException {
    
    String sql;
    
    sql=" DELETE FROM details "+
        " WHERE "+
        " productcode="+productCode+"";
    
    database.modify(sql);        
    
  }
  
}
