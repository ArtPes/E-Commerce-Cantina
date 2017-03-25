
package blogics;

import java.util.*;
import java.sql.*;

import util.*;
import services.databaseservice.*;
import services.databaseservice.exception.*;


public class userService extends Object {

  
       

    public static User insertNewuser(DataBase database,String nome,
                            String pass,
                            String surname,String cduser,String indirizzo,String citta,String telefono,String email,String tipo,String lingua)
          
    throws NotFoundDBException,DuplicatedRecordDBException,ResultSetDBException {

   User user;

   user=new User(nome,pass,surname,cduser,indirizzo,citta, telefono, email,tipo,lingua);
   user.insert(database);
   return user;

  }

    public static User getUser(DataBase database, String cduser) 
        throws NotFoundDBException,ResultSetDBException {

    User user=null;

    String sql=" SELECT * " +
                "   FROM utenti " +
                " WHERE " +
                "  cduser = '" + util.Conversion.getDatabaseString(cduser)+"'";
    
    ResultSet resultSet = database.select(sql);
    
    try {
      if (resultSet.next())
        user = new User(resultSet);
      resultSet.close();
    } catch (SQLException ex) {
      throw new ResultSetDBException("UserService: getUser():  ResultSetDBException: "+ex.getMessage(), database);
    }
    return user;

  }
  
  
   public static ArrayList<User> getUtenti(DataBase database) 
        throws NotFoundDBException,ResultSetDBException {

    User user=null;

    String sql=" SELECT * " +
                "   FROM utenti " +
                " order by nome";
    ArrayList<User> users = new ArrayList<User>();
    
    try {
        ResultSet resultSet = database.select(sql);
        
        
      while (resultSet.next()) {
        user = new User(resultSet);
        //aggiunge i prodotti all'array List;
        users.add(user);
      }
      resultSet.close();
    }catch (SQLException ex) {
      throw new ResultSetDBException("ProdottoService: getProdotti():  ResultSetDBException: "+ex.getMessage(), database);
    } catch (NotFoundDBException e){
              throw new NotFoundDBException("ProdottoService: getProdotti():  ResultSetDBException: "+e.getMessage(), database);
    }
    return users;
    
  }
  
  
}