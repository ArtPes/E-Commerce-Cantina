                
package blogics;

import java.sql.*;

import util.*;
import services.databaseservice.*;
import services.databaseservice.exception.*;

public class Prodotto  {
  public Long productCode;
  public String nome_p;
  public String type_p;
  public String regione;
  public Double prezzo;
  public String tipo;
  public String path;
  public Long quantita;
  public String cduser;
 
  
  
  public Prodotto(String nome_p,String regione,String type_p,Long quantita,Double prezzo,String path,String cduser) {
  
    this.nome_p = nome_p;
    this.regione=regione;
    this.type_p=type_p;    
    this.prezzo=prezzo;    
    this.path=path;
    this.quantita=quantita;
    this.cduser=cduser;
  }
  
  public Prodotto(ResultSet resultSet) {
    try {productCode=new Long(resultSet.getString("productcode"));} catch(SQLException sqle) {}
    try {nome_p=resultSet.getString("nome_p");} catch (SQLException sqle) {}
    try {regione=resultSet.getString("regione");} catch (SQLException sqle) {}    
    try {type_p=resultSet.getString("type_p");} catch (SQLException sqle) {}
    try {path=resultSet.getString("path");} catch (SQLException sqle) {}
    try {prezzo=new Double(resultSet.getDouble("prezzo"));} catch (SQLException sqle) {}
    try {quantita=new Long(resultSet.getLong("quantita"));} catch (SQLException sqle) {}
    try {cduser=resultSet.getString("cduser");} catch(SQLException sqle) {}
    
  }
  
  public void insert(DataBase database)
  throws NotFoundDBException,DuplicatedRecordDBException,ResultSetDBException {
    
    String sql="";
    
    /* check di unicità */
    sql+= " SELECT productcode "+
          "   FROM prodotto "+
          " WHERE " +
          
          "   nome_p='" + Conversion.getDatabaseString(nome_p)+"' and "+
          
          "   regione='"+Conversion.getDatabaseString(regione)+"' ";
    
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
    
    /* generazione productcode */
    sql="SELECT MAX(productcode) AS N FROM prodotto";
    
    try {
      resultSet=database.select(sql);
      
      if (resultSet.next())
        productCode = new Long(resultSet.getLong("N")+1);
      else
        productCode = new Long(1);
      
      resultSet.close();
      
    } catch (SQLException e) {
      throw new ResultSetDBException("Contact: insert(): Errore sul ResultSet --> impossibile calcolare productcode.");
    }
    
    /*  inserimento nuovo prodotto */
    
    sql=" INSERT INTO prodotto "+
        "   ( productcode,"+
        "     nome_p,regione,"+
        "     type_p,"+
        "     quantita,prezzo,"+
        "     path,cduser"+
        
        "   ) "+
        " VALUES ("+
        productCode+","+
       
        "'"+Conversion.getDatabaseString(nome_p)+"',"+
        "'"+Conversion.getDatabaseString(regione)+"',"+        
        "'"+Conversion.getDatabaseString(type_p)+"',"+
        "'"+quantita+"',"+
        "'"+prezzo+"',"+
        "'"+Conversion.getDatabaseString(path)+"',"+  
        "'"+Conversion.getDatabaseString(cduser)+"')";
    
    database.modify(sql);
    
  }

  public void update(DataBase database) 
    throws NotFoundDBException,ResultSetDBException,DuplicatedRecordDBException {
      
    String sql= "UPDATE prodotto SET prezzo = "+prezzo+", quantita = "+quantita+" WHERE productcode="+productCode+"";
    
    database.modify(sql);
        
  }
  
  public void delete(DataBase database) 
  throws NotFoundDBException,ResultSetDBException {
        
    String sql= "DELETE FROM prodotto WHERE productcode="+productCode+"" ;
   
    
    database.modify(sql);        
    
  }
  
}


