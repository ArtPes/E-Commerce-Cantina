
package blogics;

import java.util.*;
import java.sql.*;

import util.*;
import services.databaseservice.*;
import services.databaseservice.exception.*;


public class DettagliService extends Object {

  
       

    public static Dettagli insertNewDettagli(DataBase database,Long productCode, String lingua,String adettagli)
                   throws NotFoundDBException,DuplicatedRecordDBException,ResultSetDBException {

   Dettagli dettagli;
   dettagli=new Dettagli(productCode,lingua,adettagli);
   dettagli.insertDettagli(database);
   return dettagli;

  }

    public static Dettagli getDettagli(DataBase database, Long productCode,String lingua) 
        throws NotFoundDBException,ResultSetDBException {

    Dettagli dettagli=null;

    
    String sql=" SELECT * " +
                "   FROM details " +
                " WHERE " +
                "  productcode = "+productCode+" and "+
                "  lingua='" + Conversion.getDatabaseString(lingua)+"' ";

    ResultSet resultSet = database.select(sql);
    
    try {
      if (resultSet.next())
        dettagli = new Dettagli(resultSet);
      resultSet.close();
    } catch (SQLException ex) {
      throw new ResultSetDBException("DettagliService: getDettagli():  ResultSetDBException: "+ex.getMessage(), database);
    }
    return dettagli;

  }
    /*
    metodo per restituire i dettagli quando ricercati  per stringa
    */
     public static ArrayList<Dettagli> getDettagliSearch(DataBase database, String search) 
        throws NotFoundDBException,ResultSetDBException {

   Dettagli dettagli =null;
   
   String sql="SELECT * FROM prodotto AS P INNER JOIN details AS D ON P.productcode = D.productcode WHERE (P.nome_p LIKE '%"+search+"%' or D.dettagli LIKE '%"+search+"%' or P.regione LIKE '%"+search+"%')";
   
    ArrayList<Dettagli> sdettagli = new ArrayList<Dettagli>();
    
    try {
        ResultSet resultSet = database.select(sql);
        
        
      while (resultSet.next()) {
        dettagli = new Dettagli(resultSet);
        //aggiunge i prodotti all'array List;
        sdettagli.add(dettagli);
      }
      resultSet.close();
    }catch (SQLException ex) {
      throw new ResultSetDBException("DettagliService: getDettagliSearch():  ResultSetDBException: "+ex.getMessage(), database);
    } catch (NotFoundDBException e){
              throw new NotFoundDBException("ProdottoService: getDettagliSearcg():  ResultSetDBException: "+e.getMessage(), database);
    }
    return sdettagli;
    
 }
     
     /*funzione per restituire i dettagli di prodotti
        quando ricercati per tipo
     */
  public static ArrayList<Dettagli> getDettagliSearchType(DataBase database, String search) 
        throws NotFoundDBException,ResultSetDBException {

      Dettagli dettagli = null;

     String sql=" SELECT * FROM prodotto as P inner join details as D on P.productcode=D.productcode WHERE type_p LIKE '%"+search+"%'";
     
    ArrayList<Dettagli> sdettagli = new ArrayList<Dettagli>();
    
    try {
        ResultSet resultSet = database.select(sql);
        
        
      while (resultSet.next()) {
        dettagli = new Dettagli(resultSet);
        //aggiunge i prodotti all'array List;
        sdettagli.add(dettagli);
      }
      resultSet.close();
    }catch (SQLException ex) {
      throw new ResultSetDBException("ProdottoService: getProdotti():  ResultSetDBException: "+ex.getMessage(), database);
    } catch (NotFoundDBException e){
              throw new NotFoundDBException("ProdottoService: getProdotti():  ResultSetDBException: "+e.getMessage(), database);
    }
    return sdettagli;
    
 }
 

 
}