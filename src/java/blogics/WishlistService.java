/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package blogics;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import services.databaseservice.*;
import services.databaseservice.exception.*;
import util.Conversion;

/**
 *
 * @author arturo e riki
 */
public class WishlistService {
    
        

    public static ArrayList<Wishlist> getWishlist(DataBase database, String cduser) 
        throws NotFoundDBException,ResultSetDBException {

    Wishlist wishlist=null;
    //seleziono tutti i record con il cduser dell'utente
    String sql=" SELECT * " +
                " FROM wishlist " +
                " WHERE cduser='"+Conversion.getDatabaseString(cduser)+"'";
 
    ArrayList<Wishlist> Vwishlist = new ArrayList<Wishlist>();
    
    try {
        ResultSet resultSet = database.select(sql);
        
        
      while (resultSet.next()) {
        wishlist = new Wishlist(resultSet);
        Vwishlist.add(wishlist);
      }
      resultSet.close();
    }catch (SQLException ex) {
      throw new ResultSetDBException("WishlistService: getProdotti():  ResultSetDBException: "+ex.getMessage(), database);
    } catch (NotFoundDBException e){
              throw new NotFoundDBException("WishlistService: getProdotti():  ResultSetDBException: "+e.getMessage(), database);
    }
    return Vwishlist;

  }

    public static Wishlist insertNewProd(DataBase database,Long productCode,String cduser) throws NotFoundDBException,
                DuplicatedRecordDBException,ResultSetDBException{
                
          Wishlist wishlist;
          wishlist=new Wishlist(productCode,cduser);
          wishlist.insert(database);
          return wishlist;
        
        
    }
    
        public static void RemoveProd(DataBase database,Long productCode,String cduser) throws NotFoundDBException,
           ResultSetDBException{
        Wishlist wishlist;
        wishlist=new Wishlist(productCode,cduser);
        String sql;
        sql= "delete from wishlist where cduser='"+Conversion.getDatabaseString(cduser)+"' and productcode="+productCode+"" ;
        
        database.modify(sql);
       
    }
    
}
            
