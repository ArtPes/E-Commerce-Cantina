
package bflows;

import java.util.*;
import java.beans.*;
import javax.servlet.http.*;

import services.databaseservice.*;
import services.databaseservice.exception.*;
import services.errorservice.*;
import services.sessionservice.*;
import blogics.*;

public class UserManagement implements java.io.Serializable{
    
  private int result;
  private String errorMessage;
  private User[] users;
  private String pass;
  private String nome;
  private String cduser;
  private String indirizzo;
  private String surname;
  private String citta;
  private String tipo;
  private String telefono;
  private String email;
  private User   user;
  private String lingua;
  private Cookie[] cookies=null;
    
  //inserisce un nuovo utente
  public void UserManagementInsert() {
    
    DataBase database = null;    
    User user;
    
    try {
      
      database=DBService.getDataBase();
      
      user=userService.insertNewuser(database,cduser,pass,nome,surname,indirizzo,citta,telefono,email,tipo,lingua);            
      
      database.commit();
            
    } catch (NotFoundDBException ex) {
      
      EService.logAndRecover(ex);
      setResult(EService.UNRECOVERABLE_ERROR);
      database.rollBack();
      
    }catch (ResultSetDBException ex) {
      
      EService.logAndRecover(ex);
      setResult(EService.UNRECOVERABLE_ERROR);
      database.rollBack();
      
    } catch (DuplicatedRecordDBException ex) {
      
      EService.logAndRecover(ex);
      setResult(EService.RECOVERABLE_ERROR);
      setErrorMessage("L'utente inserito e gia' esistente.");
      database.rollBack();  
      
    } finally {
      try { database.close(); }
      catch (NotFoundDBException e) { EService.logAndRecover(e); }
    }
    
  }
   
  //modifica dati utente
  public void UserManagementModify() {
    
    DataBase database=null;    
    User user;
    user=null;
    try {
      
      database=DBService.getDataBase();
      
      user=userService.getUser(database,cduser);
           
      user.cduser=cduser;
      user.nome=nome;
      user.surname=surname;      
      user.pass=pass;      
      user.indirizzo=indirizzo;
      user.citta=citta;
      user.telefono=telefono;
      user.email=email;     
      user.tipo=tipo;
      
                  
      user.update(database);
      
      database.commit();
      
    } catch (NotFoundDBException ex) {
      
      EService.logAndRecover(ex);
      setResult(EService.UNRECOVERABLE_ERROR);
      database.rollBack();
      
    } catch (ResultSetDBException ex) {
      
      EService.logAndRecover(ex);
      setResult(EService.UNRECOVERABLE_ERROR);
      database.rollBack();
      
    } catch (DuplicatedRecordDBException ex) {
      
      EService.logAndRecover(ex);
      setResult(EService.RECOVERABLE_ERROR);
      setErrorMessage("L'utente inserito e' gia' esistente.");
      database.rollBack();  
            
    } finally {
      try { database.close(); }
      catch (NotFoundDBException e) { EService.logAndRecover(e); }
    }
    
  }   
  
  
  //cancella un utente
  public void UserManagementDelete() {
    
    DataBase database = null;
    User user;
    
    try {
      
      database=DBService.getDataBase();
            
      user=userService.getUser(database,cduser);
      
      user.delete(database);
      
      database.commit();
      
    } catch (NotFoundDBException ex) {
      
      EService.logAndRecover(ex);
      setResult(EService.UNRECOVERABLE_ERROR);
      database.rollBack();
      
    } catch (ResultSetDBException ex) {
      
      EService.logAndRecover(ex);
      setResult(EService.UNRECOVERABLE_ERROR);
      database.rollBack();      
      
    } finally {
      try { database.close(); }
      catch (NotFoundDBException e) { EService.logAndRecover(e); }
    }
    
  }
  //lista degli utente iscritti (solo per admin)
  public void ListUsersView() {
        
        DataBase database = null;
        ArrayList<User> ausers = new ArrayList<User>();
        try {
            database = DBService.getDataBase();
                
                //restituisce la lista di prodotti random
                ausers = userService.getUtenti(database);
                users = new User[ausers.size()];
                ausers.toArray(users);
                        /*Committo il Database per le operazioni di visualizzazione*/
        database.commit();
        }//fine try

        catch (NotFoundDBException e) {
            
            EService.logAndRecover(e);
            setResult(EService.UNRECOVERABLE_ERROR);
        }
        catch (ResultSetDBException ex) {
      
              EService.logAndRecover(ex);
              setResult(EService.UNRECOVERABLE_ERROR);
      
        } finally {
            try {if (database!=null) database.close(); } catch(NotFoundDBException e) {
                setResult(EService.UNRECOVERABLE_ERROR);
            }
        }
        
    }


  
  public int getResult() {
    return this.result;
  }
  public void setResult(int result) {
    this.result = result;
  }
  public String getErrorMessage() {
    return this.errorMessage;
  }
  public void setErrorMessage(String errorMessage) {
    this.errorMessage = errorMessage;
  }
  public String getNome() {
    return this.nome;
  }
  public void setNome(String nome) {
    this.nome = nome;
  }
  
  public String getCduser() {
    return this.cduser;
  }
  public void setCduser(String cduser) {
    this.cduser = cduser;
  }
  public String getLingua() {
    return this.lingua;
  }
  public void setLingua(String lingua) {
    this.lingua = lingua;
  }
  
  public User getUsers(int index) {
    return this.users[index];
  }
  public User[] getUsers() {
    return this.users;
  }
  public void setUsers(int index, User users) {
    this.users[index] = users;
  }
  public void setUsers(User[] users) {
    this.users = users;
  } 
  
  public String getpass() {
    return this.pass;
  }
   public String getIndirizzo() {
    return this.indirizzo;
  }
   
  public void setIndirizzo(String indirizzo)
  {
      this.indirizzo = indirizzo;
  }
   
   public String getTipo() {
    return this.tipo;
  }
  public void setpass(String pass) {
    this.pass = pass;
  }
  public String getsurname() {
    return this.surname;
  }
  public void setsurname(String surname) {
    this.surname = surname;
  }
  public String getCitta() {
    return this.citta;
  }
  public void setCitta(String citta) {
    this.citta = citta;
  }
  public String getTelefono() {
    return this.telefono;
  }
  public void setTelefono(String telefono) {
    this.telefono = telefono;
  }
  public String getEmail() {
    return this.email;
  }
  public void setEmail(String email) {
    this.email = email;
  }
  /** Setter for property user.
   * @param user New value of property user.
   */
  public void setUser(User user) {
    this.user = user;
  }

    
    
    public void setTipo(String tipo) 
    {
        this.tipo = tipo;
    }
  
    

  public User getUtenti(int index) {
    return this.users[index];
  }

  public User[] getUtenti() {
    return this.users;
  } 

  public void setUtenti(int index, User users) {
    this.users[index] = users;
  }

  public void setUtenti(User[] users) {
    this.users = users;
  } 
    
    
}
