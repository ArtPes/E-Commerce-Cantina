                
package blogics;

import java.sql.*;

import util.*;
import services.databaseservice.*;
import services.databaseservice.exception.*;

public class User  {
  public Long contactCode;
  public String cduser;
  public String nome;
  public String pass;
  public String surname;
  public String indirizzo;
  public String tipo;
  public String citta;
  public String telefono;
  public String email;
  public String lingua;
  
  
  
  public User(String cduser,String pass,String nome,String surname,String indirizzo,String citta,String telefono,String email,String tipo,String lingua) {
  
    this.cduser = cduser;
    this.pass=pass;
    this.nome=nome;
    this.surname=surname;   
    this.indirizzo=indirizzo;
    this.citta=citta;
    this.telefono=telefono;
    this.email=email;
    this.tipo=tipo;
    this.lingua=lingua;
    
  }
  
  public User(ResultSet resultSet) {
      
    try {cduser=resultSet.getString("cduser");} catch (SQLException sqle) {}
    try {pass=resultSet.getString("pwd");} catch (SQLException sqle) {}
    try {nome=resultSet.getString("nome");} catch (SQLException sqle) {}
    try {surname=resultSet.getString("surname");} catch (SQLException sqle) {}
    try {citta=resultSet.getString("citta");} catch (SQLException sqle) {}
    try {indirizzo=resultSet.getString("via");} catch (SQLException sqle) {}
    try {telefono=resultSet.getString("tel");} catch (SQLException sqle) {}
    try {email=resultSet.getString("email");} catch (SQLException sqle) {}
    try {tipo=resultSet.getString("usertype");} catch (SQLException sqle) {}
    try {lingua=resultSet.getString("lingua");} catch (SQLException sqle) {}
   
    
  }
  
  public void insert(DataBase database)
  throws NotFoundDBException,DuplicatedRecordDBException,ResultSetDBException {
    
    String sql="";
    
    /* check di unicità */
    sql+= " SELECT cd_contact "+
          "   FROM utenti "+
          " WHERE " +
          
          "   cduser='" + Conversion.getDatabaseString(cduser)+"' and "+
          
          "   email='"+Conversion.getDatabaseString(email)+"' ";
    
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
    
    /* generazione cd_contact */
    sql="SELECT MAX(cd_contact) AS N FROM utenti";
    
    try {
      resultSet=database.select(sql);
      
      if (resultSet.next())
        contactCode = new Long(resultSet.getLong("N")+1);
      else
        contactCode = new Long(1);
      
      resultSet.close();
      
    } catch (SQLException e) {
      throw new ResultSetDBException("Contact: insert(): Errore sul ResultSet --> impossibile calcolare cd_contact.");
    }
    
    /*  inserimento nuovo contatto */
    
    sql=" INSERT INTO utenti "+
        "   ( cd_contact,"+
        "     cduser,pwd,"+
        "     nome,surname,"+
        "     email,via,"+
        "     citta,tel,"+
        "     usertype,lingua "+
        "   ) "+
        " VALUES ("+
        contactCode+","+
       
        "'"+Conversion.getDatabaseString(cduser)+"',"+
        "'"+Conversion.getDatabaseString(pass)+"',"+
        "'"+Conversion.getDatabaseString(nome)+"',"+
        "'"+Conversion.getDatabaseString(surname)+"',"+
        "'"+Conversion.getDatabaseString(email)+"',"+
        "'"+Conversion.getDatabaseString(indirizzo)+"',"+
        "'"+Conversion.getDatabaseString(citta)+"',"+
        "'"+Conversion.getDatabaseString(telefono)+"',"+
        "'"+Conversion.getDatabaseString(tipo)+"',"+
        "'"+Conversion.getDatabaseString(lingua)+"')";
        
        
    
    database.modify(sql);
    
  }
  
  
  
  public void update(DataBase database) 
    throws NotFoundDBException,ResultSetDBException,DuplicatedRecordDBException {
      
    String sql=" UPDATE utenti "+
        " SET "+
        
        
        "   pwd = '"+Conversion.getDatabaseString(pass)+"', "+
        "   nome = '"+Conversion.getDatabaseString(nome)+"', "+
        "   surname = '"+Conversion.getDatabaseString(surname)+"', "+
        "   email = '"+Conversion.getDatabaseString(email)+"', "+
        "   via = '"+Conversion.getDatabaseString(indirizzo)+"', "+
        "   citta = '"+Conversion.getDatabaseString(citta)+"', "+
        "   tel = '"+Conversion.getDatabaseString(telefono)+"', "+
        "   lingua = '"+Conversion.getDatabaseString(lingua)+"' "+
        
    
        " WHERE "+
        "  cduser = '" + Conversion.getDatabaseString(cduser)+"'";
    
    database.modify(sql);
        
  }
  
  public void delete(DataBase database) 
  throws NotFoundDBException,ResultSetDBException {
    
     String sql= "DELETE FROM utenti WHERE cduser='" + Conversion.getDatabaseString(cduser)+"'";
    
    database.modify(sql);        
    
  }
  
}


