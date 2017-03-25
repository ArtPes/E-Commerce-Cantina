
package bflows;

import java.beans.*;
import javax.servlet.http.*;

import services.databaseservice.*;
import services.databaseservice.exception.*;
import services.errorservice.*;
import services.sessionservice.*;
import blogics.*;

/**
 *
 * @author  GAL_PES
 *
 */
public class LogonManagement extends Object implements java.io.Serializable{
  
  private String errorMessage;
  private int result;
  private String cduser;
  private String pass;
  private String tipo;
  private String lingua;
  private Cookie[] cookies=null;
    
  
  
  /**
   * funzione di logon
   * ricerca avviene con CD_USER
   */
  public void logon() {
    
    DataBase database = null;
    
    try {
      
      database=DBService.getDataBase();
      
      User user = userService.getUser(database,cduser);
      if ( user== null || !user.pass.equals(pass)) {
        cookies=null;
        setResult(EService.RECOVERABLE_ERROR);
        setErrorMessage("Username e pass errati!");
      } else {
            cookies=Session.createCookie(database,user);
            
      }
      
      database.commit();
      
    } catch (NotFoundDBException ex) {
      
      EService.logAndRecover(ex);
      setResult(EService.UNRECOVERABLE_ERROR);
      
    } catch (ResultSetDBException ex) {
      
      EService.logAndRecover(ex);
      setResult(EService.UNRECOVERABLE_ERROR);
      
    } finally {
      try { 
          if (database != null)
            database.close(); 
      }
      catch (NotFoundDBException e) { EService.logAndRecover(e); }
    }
    
  }
  
  public void logout() {    
    cookies=Session.deleteCookie(cookies);   
     }
  
  public String getErrorMessage() {
    return errorMessage;
  }
  public void setErrorMessage(String errorMessage) {
    this.errorMessage = errorMessage;
  }
  public int getResult() {
    return this.result;
  }
  public void setResult(int result) {
    this.result = result;
  }
  public String getCduser() {
    return this.cduser;
  }
  public void setCduser(String cduser) {
    this.cduser = cduser;
  }
    
  public String getTipo() {
    return this.tipo;
  }
  public void setTipo(String tipo) {
    this.tipo = tipo;
  }
    public String getLingua() {
    return this.lingua;
  }
  public void setLingua(String lingua) {
    this.lingua = lingua;
  }
  
  /** setter per la pass
   * 
   * @param pass 
   */
  public void setpass(String pass) {
    this.pass = pass;
  }
  public Cookie getCookies(int index) {
    return this.cookies[index];
  }
  public Cookie[] getCookies() {
    return this.cookies;
  }
  public void setCookies(int index, Cookie cookies) {
    this.cookies[index] = cookies;
  }
  public void setCookies(Cookie[] cookies) {
    this.cookies = cookies;
  }
  
}
