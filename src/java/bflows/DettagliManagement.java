/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package bflows;

import blogics.Dettagli;
import blogics.DettagliService;
import blogics.Prodotto;
import blogics.prodottoService;
import javax.servlet.http.Cookie;
import services.databaseservice.DBService;
import services.databaseservice.DataBase;
import services.databaseservice.exception.DuplicatedRecordDBException;
import services.databaseservice.exception.NotFoundDBException;
import services.databaseservice.exception.ResultSetDBException;
import services.errorservice.EService;
import services.sessionservice.Session;

/**
 *
 * @author arturo e riki
 */

public class DettagliManagement implements java.io.Serializable{
    
  private int result;
  private String errorMessage;
  private Long productCode;
  private String lingua;
  private String adettagli; //se no da errori con la creazione sotto
  private Dettagli dettagli;
  private Cookie[] cookies=null;
             
//inserimento nuovo dettaglio
public void DettagliManagementInsert() {
    
    DataBase database = null;    
    Dettagli dettagli;
    util.Debug.println("adettagli "+adettagli);
    
    try {
      
      database=DBService.getDataBase();
      
      dettagli=DettagliService.insertNewDettagli(database,productCode,lingua,adettagli);            
      
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
      setErrorMessage("Il prodotto inserito e gia' esistente.");
      database.rollBack();  
      
    } finally {
      try { database.close(); }
      catch (NotFoundDBException e) { EService.logAndRecover(e); }
    }
    
  }
   
  public void logout() {    
    cookies=Session.deleteCookie(cookies);   
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
  public Long getProductCode() {
    return this.productCode;
  }
  public void setProductCode(Long productCode) {
    this.productCode = productCode;
  }
    public String getLingua() {
    return this.lingua;
  }
  public void setLingua(String lingua) {
    this.lingua = lingua;
  }
    public String getAdettagli() {
    return this.adettagli;
  }
  public void setAdettagli(String adettagli) {
    this.adettagli = adettagli;
  }
   
}