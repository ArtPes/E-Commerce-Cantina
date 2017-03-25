/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package bflows;

import blogics.*;
import blogics.Wishlist;
import java.beans.*;
import java.io.Serializable;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Cookie;
import services.databaseservice.*;
import services.databaseservice.exception.*;
import services.errorservice.*;
import services.logservice.*;
import services.sessionservice.*;
import services.sessionservice.Session;
import util.*;

public class WishlistManagement implements Serializable {
    
    
    private int result;
    private String errorMessage;
    private String cduser;
    private Long productCode;
    private Prodotto[] prodotti;
    private Cookie[] cookies;
    private Wishlist[] wl;
   
  
    /**
     * metodo per ottenere la vista dei prodootti appartenti alla lista di un utente
     */
  public void WishlistView() {
    
           DataBase database=null;
           ArrayList<Wishlist> wish =new ArrayList<Wishlist>();
           try{ 
                database=DBService.getDataBase();
                /*seleziono tutti record che contengono il cduser dell'utente
                utilizzo i cookie*/
                wish = WishlistService.getWishlist(database,(Session.getCduser(cookies)));
                Wishlist[] cwl = new Wishlist[wish.size()];
                wish.toArray(cwl);
                
                prodotti = new Prodotto[wish.size()];
                for (int i=0; i<cwl.length;i++)
                    prodotti[i] = prodottoService.getProdotto(database,cwl[i].productCode);
                   
          
                /*Committo il database*/
                database.commit();
                
    } catch (NotFoundDBException ex) {
      
      EService.logAndRecover(ex);
      setResult(EService.UNRECOVERABLE_ERROR);
      
    } catch (ResultSetDBException ex) {
      
      EService.logAndRecover(ex);
      setResult(EService.UNRECOVERABLE_ERROR);
      
    } finally {
      try { database.close(); }
      catch (NotFoundDBException e) { EService.logAndRecover(e); }
    }
    
  }
  

      /**
       * metodo per aggiungere un prodotto alla wishlist
       */
 
    public void insertNewProdotto(){
        DataBase database =null;
        
        try{
            
      database=DBService.getDataBase();
      
      WishlistService.insertNewProd(database,productCode,(Session.getCduser(cookies)));            
      
      database.commit();
        }
        
        catch (NotFoundDBException ex) {
      
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
      setErrorMessage("Il prodotto inserito e gia' in lista.");
      database.rollBack();  
      
    } finally {
      try { database.close(); }
      catch (NotFoundDBException e) { EService.logAndRecover(e); }
    }
        
    }
    
    /**
     * metodo per rimuovere un prodotto dalla wishlist
     */
    public void RemoveProd(){
        DataBase database=null;
        try{
            database=DBService.getDataBase();
            WishlistService.RemoveProd(database,productCode,(Session.getCduser(cookies)));
            database.commit();
        }
        catch(NotFoundDBException e){
            EService.logAndRecover(e);
            setResult(EService.UNRECOVERABLE_ERROR);
             if(database!=null)
                 database.rollBack();
        }
        catch(ResultSetDBException ex){
            EService.logAndRecover(ex);
            setResult(EService.RECOVERABLE_ERROR);
             if(database!=null)
                 database.rollBack();
        }
        finally{
            try{ if(database!=null)
                database.close();}catch(NotFoundDBException e){
                setResult(EService.UNRECOVERABLE_ERROR);
            }
        }
    }

            
        
    public void setResult(int result) {
        this.result = result;
    }
    
    public int getResult() {
        return this.result;
    }
    
     public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public String getCduser() {
        return cduser;
    }

    public void setCduser(String Cduser) {
        this.cduser = cduser;
    }

    public Long getProductCode() {
        return productCode;
    }

    public void setproductCode(Long productCode) {
        this.productCode = productCode;
    }
    public Cookie[] getCookies() {
        return cookies;
    }

    public void setCookies(Cookie[] cookies) {
        this.cookies = cookies;
    }
 //restituisce i prodotti index 
  public Prodotto getProdotti(int index) {
    return this.prodotti[index];
  }
   //restituisce i prodotti
  public Prodotto[] getProdotti() {
    return this.prodotti;
  } 
//setta l'iesimo  prodotto
  public void setProdotti(int index, Prodotto prodotti) {
    this.prodotti[index] = prodotti;
  }
  //setta prodotti
  public void setProdotti(Prodotto[] prodotti) {
    this.prodotti = prodotti;
  } 
    
}