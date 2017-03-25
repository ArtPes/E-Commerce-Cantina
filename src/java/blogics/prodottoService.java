
package blogics;

import java.util.*;
import java.sql.*;

import util.*;
import services.databaseservice.*;
import services.databaseservice.exception.*;


public class prodottoService extends Object {

  
       

  public static Prodotto insertNewprodotto(DataBase database,String nome_p,String regione,String type_p,Long quantita,Double prezzo,String path,String cduser)
                   throws NotFoundDBException,DuplicatedRecordDBException,ResultSetDBException {

   Prodotto prodotto;
   prodotto=new Prodotto(nome_p,regione,type_p,quantita,prezzo,path,cduser);
   prodotto.insert(database);
   return prodotto;

  }
  
  public static void modifyProdotto(DataBase database,Long productCode,double prezzo, Long quantita)
            throws NotFoundDBException,ResultSetDBException{
        
        String sql = "UPDATE prodotto SET prezzo = "+prezzo+", quantita = "+quantita+" WHERE productcode="+productCode;
        
        database.modify(sql);
 
       }
          
  public static void RemoveProd(DataBase database,Long productCode) throws NotFoundDBException,
           ResultSetDBException{
        
        String sql= "DELETE FROM prodotto WHERE productcode="+productCode+"" ;
        
        database.modify(sql);
       
    }
  
  public static void ReduceQtaProd(DataBase database,Long productCode,Long quantita,int qta) throws NotFoundDBException,ResultSetDBException{
        Long redqta=quantita-qta; 
        
        String sql = "UPDATE prodotto set quantita="+redqta+ " WHERE productcode="+productCode;
        
        database.modify(sql);
 
       }
  
    
  public static Prodotto getProdotto(DataBase database, Long productCode) 
        throws NotFoundDBException,ResultSetDBException {

    Prodotto prodotto=null;

    String sql=" SELECT * " +
                "   FROM prodotto " +
                " WHERE " +
                "   productcode = "+productCode+" ";
    
    ResultSet resultSet = database.select(sql);
    
    try {
      if (resultSet.next())
        prodotto = new Prodotto(resultSet);
      resultSet.close();
    } catch (SQLException ex) {
      throw new ResultSetDBException("ProdottoService: getProdotto():  ResultSetDBException: "+ex.getMessage(), database);
    }
    return prodotto;

  }
  
  
    
 public static ArrayList<Prodotto> getProdotti(DataBase database) 
        throws NotFoundDBException,ResultSetDBException {

    Prodotto prodotto=null;

    String sql=" SELECT * " +
                "   FROM prodotto " +
                " order by rand()";
    ArrayList<Prodotto> prodotti = new ArrayList<Prodotto>();
    
    try {
        ResultSet resultSet = database.select(sql);
        
        
      while (resultSet.next()) {
        prodotto = new Prodotto(resultSet);
        //aggiunge i prodotti all'array List;
        prodotti.add(prodotto);
      }
      resultSet.close();
    }catch (SQLException ex) {
      throw new ResultSetDBException("ProdottoService: getProdotti():  ResultSetDBException: "+ex.getMessage(), database);
    } catch (NotFoundDBException e){
              throw new NotFoundDBException("ProdottoService: getProdotti():  ResultSetDBException: "+e.getMessage(), database);
    }
    return prodotti;
    
  }
 
  public static ArrayList<Prodotto> getProdottiNew(DataBase database) 
        throws NotFoundDBException,ResultSetDBException {

    Prodotto prodotto=null;

    String sql=" SELECT * " +
                "   FROM prodotto " +
                " ORDER BY productcode DESC";
    ArrayList<Prodotto> prodotti = new ArrayList<Prodotto>();
    
    try {
        ResultSet resultSet = database.select(sql);
        
        
      while (resultSet.next()) {
        prodotto = new Prodotto(resultSet);
        //aggiunge i prodotti all'array List;
        prodotti.add(prodotto);
      }
      resultSet.close();
    }catch (SQLException ex) {
      throw new ResultSetDBException("ProdottoService: getProdotti():  ResultSetDBException: "+ex.getMessage(), database);
    } catch (NotFoundDBException e){
              throw new NotFoundDBException("ProdottoService: getProdotti():  ResultSetDBException: "+e.getMessage(), database);
    }
    return prodotti;
    
  }
 
 public static ArrayList<Prodotto> searchProdotti(DataBase database, String search) 
        throws NotFoundDBException,ResultSetDBException {

    Prodotto prodotto=null;
   
   String sql="SELECT * FROM prodotto AS P JOIN details AS D ON P.productcode = D.productcode WHERE (P.nome_p LIKE '%"+search+"%' or D.dettagli LIKE '%"+search+"%' or P.regione LIKE '%"+search+"%') GROUP BY nome_p";
   
   ArrayList<Prodotto> rprodotti = new ArrayList<Prodotto>();
    
    try {
        ResultSet resultSet = database.select(sql);
        
        
      while (resultSet.next()) {
        prodotto = new Prodotto(resultSet);
        //aggiunge i prodotti all'array List;
        rprodotti.add(prodotto);
      }
      resultSet.close();
    }catch (SQLException ex) {
      throw new ResultSetDBException("ProdottoService: getProdotti():  ResultSetDBException: "+ex.getMessage(), database);
    } catch (NotFoundDBException e){
              throw new NotFoundDBException("ProdottoService: getProdotti():  ResultSetDBException: "+e.getMessage(), database);
    }
    return rprodotti;
    
 }
 
 
        
    
public static ArrayList<Prodotto> getProdottiV(DataBase database, String cduser) 
        throws NotFoundDBException,ResultSetDBException {

    Prodotto prodotto=null;

    String sql=" SELECT * " +
                "   FROM prodotto " +
                " WHERE cduser='"+Conversion.getDatabaseString(cduser)+"'";
   
    ArrayList<Prodotto> Vprodotti = new ArrayList<Prodotto>();
    
    try {
        ResultSet resultSet = database.select(sql);
        
        
      while (resultSet.next()) {
        prodotto = new Prodotto(resultSet);
        //agiungge i prodotti all'array List;
        Vprodotti.add(prodotto);
      }
      resultSet.close();
    }catch (SQLException ex) {
      throw new ResultSetDBException("ProdottoService: getProdotti():  ResultSetDBException: "+ex.getMessage(), database);
    } catch (NotFoundDBException e){
              throw new NotFoundDBException("ProdottoService: getProdotti():  ResultSetDBException: "+e.getMessage(), database);
    }
    return Vprodotti;

  }
   
    //ricerca tipo vini rossi dalle categorie
   public static ArrayList<Prodotto> searchProdottiType(DataBase database, String search) 
        throws NotFoundDBException,ResultSetDBException {

    Prodotto prodotto=null;

     String sql=" SELECT * FROM prodotto WHERE type_p LIKE '%"+search+"%'";
     
    ArrayList<Prodotto> rprodotti = new ArrayList<Prodotto>();
    
    try {
        ResultSet resultSet = database.select(sql);
        
        
      while (resultSet.next()) {
        prodotto = new Prodotto(resultSet);
        //aggiunge i prodotti all'array List;
        rprodotti.add(prodotto);
      }
      resultSet.close();
    }catch (SQLException ex) {
      throw new ResultSetDBException("ProdottoService: getProdotti():  ResultSetDBException: "+ex.getMessage(), database);
    } catch (NotFoundDBException e){
              throw new NotFoundDBException("ProdottoService: getProdotti():  ResultSetDBException: "+e.getMessage(), database);
    }
    return rprodotti;
    
 } 
}