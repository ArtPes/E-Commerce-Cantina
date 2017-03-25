/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package blogics;

import java.sql.*;
import java.util.ArrayList;
import services.databaseservice.DataBase;
import services.databaseservice.exception.DuplicatedRecordDBException;
import services.databaseservice.exception.NotFoundDBException;
import services.databaseservice.exception.ResultSetDBException;
import util.Conversion;

/**
 *
 * @author arturo e riki
 */
public class Wishlist {
    
       public Long productCode;
       public String cduser;
       
    
    
    public Wishlist(Long productCode,String cduser){
        
        this.productCode = productCode;
        this.cduser = cduser;   
          
    }
    
    public Wishlist(ResultSet resultSet) {
        
        try {productCode=resultSet.getLong("productcode");} catch (SQLException sqle) {}
        try {cduser=resultSet.getString("cduser");} catch (SQLException sqle) {}
            
    }
    
       
    public void insert(DataBase database) throws NotFoundDBException,
            DuplicatedRecordDBException,ResultSetDBException {
       
       /*check di unicità
       se l'utente ha già inserito il prodotto, non verrà
       reinserito nuovamente nella wishlist
       */
          String sql="";
        
    /* check di unicità */
    sql+= " SELECT * "+
          "   FROM wishlist"+
          " WHERE " +
         
          "   cduser='"+Conversion.getDatabaseString(cduser)+"' and "+
          "   productcode='"+productCode+"' ";
    
    ResultSet resultSet=database.select(sql);
    
    boolean exist=false;
    
    try {      
      exist=resultSet.next();
      resultSet.close();      
    } catch (SQLException e) {      
      throw new ResultSetDBException("user: update(): Errore sul ResultSet.");
    }
    
    if (exist) {
      throw new DuplicatedRecordDBException("user: update(): Tentativo di inserimento di "+
      "un contatto già esistente.");
    }
    
   
      if (!exist)   {
          sql="INSERT INTO wishlist (productcode,cduser) VALUES ("+
        productCode+","+
        "'"+Conversion.getDatabaseString(cduser)+"')";
    
    database.modify(sql);
       }   
   }
}


