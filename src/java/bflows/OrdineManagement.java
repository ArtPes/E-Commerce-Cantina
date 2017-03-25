/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package bflows;

import java.beans.*;
import java.io.Serializable;
import services.databaseservice.exception.*;
import services.errorservice.*;
import services.logservice.*;
import blogics.*;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.*;
import services.databaseservice.DBService;
import services.databaseservice.DataBase;
import services.sessionservice.Session;
import util.*;
/**
 *
 * @author arturo
 */
public class OrdineManagement implements Serializable {
    
  
    private Cookie[] cookies;
    private int result;
    private String errorMessage;
    private java.util.Date dataordine;
    private java.util.Date dataconsegna;
    private String via;
    private String citta;
    private String cap;
    private double totorder;
    private int norderelement;
    private Ordine ordine;
    private Ordine[] ordini;
    private Long idordine;
    private String cduser;
    private String stato;
    
    public OrdineManagement() {}
//mostra l'ultimo ordine di un determinato utente per fare il check ordine
    public void ViewOrdine() throws ResultSetDBException 
    {DataBase database = null;
        try {
            database = DBService.getDataBase();
            ordine= OrdineService.getOrderfromCduser(database,Session.getCduser(cookies));          
            database.commit();
            util.Debug.println("ViewOrdine idOrdine:"+ordine.idordine);
            }
        catch (NotFoundDBException ex) { 
              
            EService.logAndRecover(ex);
            setResult(EService.UNRECOVERABLE_ERROR);
      
        } finally {
            try {  if(database!=null)
                database.close(); }
            catch (NotFoundDBException e) { EService.logAndRecover(e); }
        }
        
}
//metodo per inserimento di un ordine nel database aggiorna anche la quantità dei prodotti disponibili sottraendo a quelli in giacenza quelli ordinati dall'utente
    public void addOrdine()
    {
        DataBase database = null;
        
        try{
            /*ottengo la connessione al database*/
            database = DBService.getDataBase();
            /*prendo l'cduser dai cookie*/
            dataordine = new Date();
            /*indico una prevista data di consegna
            la inizializzo a oggi e gli aggiungo
            3 giorni*/
            dataconsegna = new Date();
            Calendar cal = Calendar.getInstance();
            cal.setTime(dataconsegna);
            cal.add(Calendar.DATE, 3);
            dataconsegna = cal.getTime();
            
            ordine = OrdineService.insertNewOrdine(database,String.valueOf(Session.getCduser(cookies)),dataordine,via,
                    citta,cap,dataconsegna);
            /*inserimento dei prodotti che compongono l'ordine*/
            /*ho inizialitto l'ordine senza l'id perchè  è una chiave autoincrementante del database*/
            /*dovrei già aver creato la tupla corrispondente a questo ordine*/
            
            
            /*inserisco gli elementi dell'ordine e calcolo il totale ordine*/
            totorder = 0;
                 norderelement = 0;
            CartItem[] items = Session.getCartItems(cookies);
            
            for ( int i=0;i<items.length;i++)
            {
               Comprende record = ComprendeService.insertOrderItem(database,ordine.idordine,items[i].getProductCode(),items[i].getQta());
                /*devo fare l'update della quantità dei prodotti nel carrello*/
                Prodotto product = prodottoService.getProdotto(database, items[i].getProductCode());
                product.quantita = product.quantita - items[i].getQta();
                product.update(database);
                totorder += items[i].getQta()*product.prezzo;   
                norderelement += items[i].getQta();
            }
            
            /*svuoto il carrello*/
          cookies = Session.removeCart(cookies);
            
            database.commit();
        } 
        catch (NotFoundDBException ex) 
        {
            EService.logAndRecover(ex);
            setResult(EService.UNRECOVERABLE_ERROR);
            if (database!=null)
                database.rollBack();

        }
        catch (ResultSetDBException ex) {
      
            EService.logAndRecover(ex);
            setResult(EService.UNRECOVERABLE_ERROR);
            if(database!=null)
                    database.rollBack();
      
        } catch (DuplicatedRecordDBException ex) {

          EService.logAndRecover(ex);
          setResult(EService.RECOVERABLE_ERROR);
          setErrorMessage("Errore sull'ordine! riprova");
          if (database!=null)
              database.rollBack();  

        } finally {
          try { if (database!=null)
              database.close(); }
          catch (NotFoundDBException e) 
          { EService.logAndRecover(e); }
        }
    }
//metodo per eliminare un ordine   
    public void deleteOrdine()
    {
    
        DataBase database=null;
        try{
            database=DBService.getDataBase();
            OrdineService.RemoveOrdine(database,idordine);
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
     //visualizzare il tot del carrello
    public void OrderTot() 
    {
        /*in cart view setto il totale del carrello e il numero
        dei prodotti nel carrello
        */
        DataBase database = null;
        CartItem[] items = Session.getCartItems(cookies);
         if (items != null) {
             try {
                 database = DBService.getDataBase();
                 totorder = 0;
                 norderelement = 0;
                 Prodotto product;
                 for (int i = 0; i < items.length;i++) {
                     product = prodottoService.getProdotto(database,items[i].getProductCode());
                     util.Debug.println("quantita: "+items[i].getQta()+ " prezzo: "+product.prezzo);
                     totorder += items[i].getQta()*product.prezzo;   
                     norderelement += items[i].getQta();
                 }
                  database.commit();   
             }
             catch (NotFoundDBException e) {
            
            EService.logAndRecover(e);
            setResult(EService.UNRECOVERABLE_ERROR);
        }
        catch (ResultSetDBException ex) {
      
              EService.logAndRecover(ex);
              setResult(EService.UNRECOVERABLE_ERROR);
      
        } finally {
            try { if (database!=null) database.close(); } catch(NotFoundDBException e) {
                setResult(EService.UNRECOVERABLE_ERROR);
            }
        }
             
         }   
    }
// metodo per ottenere la vista degli ordini effettuati dall'utente
    public void ListOrderView()
    {
        DataBase database = null;
        ArrayList aord = new ArrayList();
        try {
            database = DBService.getDataBase();
            
            aord = OrdineService.getOrdinifromUser(database,String.valueOf(Session.getCduser(cookies)));
            ordini = new Ordine[aord.size()];
            aord.toArray(ordini);
            database.commit();
        }
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
//ottenere tutti gli ordini effettuati(solo gli amministratori possono)
    public void TotListOrderView()
    {
        DataBase database = null;
        ArrayList aord = new ArrayList();
        try {
            database = DBService.getDataBase();
            
            aord = OrdineService.getAllOrder(database);
            ordini = new Ordine[aord.size()];
            aord.toArray(ordini);
            database.commit();
        }
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
//modifica lo stato dell'0rdine
    public void AOrderModify()
     {
         DataBase database = null;
         Ordine ordine;
         try {
            
             database = DBService.getDataBase();
             OrdineService.setStatoOrdine(database, idordine, stato);
             database.commit();

         }
         catch (NotFoundDBException ex) 
        {
            EService.logAndRecover(ex);
            setResult(EService.UNRECOVERABLE_ERROR);
            if(database!=null)
                database.rollBack();

        }
        catch (ResultSetDBException ex) {
      
            EService.logAndRecover(ex);
            setResult(EService.UNRECOVERABLE_ERROR);
            if(database!=null)
                database.rollBack();
      
        }finally {
          try { if(database!=null)
              database.close(); }
          catch (NotFoundDBException e) 
          { EService.logAndRecover(e); }
        }
     }
    
    
    
    
      /**
       * getter dei cookies
       * @return Cookie[]
       */
    public Cookie[] getCookies() {
        return cookies;
    }
    
    /** getter indexed dei cookie
     * 
     * @param index indice del cookie
     * @return Cookie 
     */
    public Cookie getCookies(int index) {
        return cookies[index];
    }

    /**
     * setter dei Cookie
     * @param cookies 
     */
    public void setCookies(Cookie[] cookies) {
        this.cookies = cookies;
    }

    /**
     * getter per result
     * @return int
     */
    public int getResult() {
        return result;
    }
/**
 * setter per result
 * @param result 
 */
    public void setResult(int result) {
        this.result = result;
    }
/**
 * getter per errorMessage
 * @return String
 */
    public String getErrorMessage() {
        return errorMessage;
    }

    /**
     * setter per errorMessage
     * @param errorMessage 
     */
    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    /**
     * getter per la property totordine
     * @return double
     */
    public double getTotorder() {
        return totorder;
    }

  
    /**
     * getter per il numero elementi dell'ordine
     * @return int
     */
    public int getNorderelement() {
        return norderelement;
    }

    /**
     * getter per l'ordine
     * @return Ordine
     */
    public Ordine getOrdine() {
        return ordine;
    }

    /**
     * setter per la città
     * @param citta 
     */
    public void setCitta(String citta) {
        this.citta = citta;
    }

/**
 * setter per il cap
 * @param cap 
 */
    public void setCap(String cap) {
        this.cap = cap;
    }
/**
 * getter data ordine
 * @return Date
 */
    public Date getDataordine() {
        return dataordine;
    }

    /**
     * getter data consegna
     * @return 
     */
    public Date getDataconsegna() {
        return dataconsegna;
    }

    /**getter via
     * 
     * @return String
     */
    public String getVia() {
        return via;
    }

    /**
     * getter citta
     * @return 
     */
    public String getCitta() {
        return citta;
    }
/**
 * getter per il cap
 * @return 
 */
    public String getCap() {
        return cap;
    }

    /**
     * setter per la via
     * @param via 
     */
    public void setVia(String via) {
        this.via = via;
    }
    
    /**
     * getter per restituire la data dell'ordine come stringa in un formato
     * dd/MM/yyyy
     * @return String
     */
    public String getOrderDate()
    {
            SimpleDateFormat sd = new SimpleDateFormat("dd/MM/yyyy");
           String date = sd.format(ordine.data_ordine);
           return date;
            
    }
    
    /**
     * getter per restituire la data della consegna come stringa in un formato
     * dd/MM/yyyy
     * @return String
     */
    public String getConsegnaDate()
    {
            SimpleDateFormat sd = new SimpleDateFormat("dd/MM/yyyy");
            String date = sd.format(ordine.data_consegna);
           return date;
            
    }

    public Ordine[] getOrdini() {
        return ordini;
    }
    
     public Ordine getOrdini(int index) {
        return ordini[index];
    }
     
      public String getConsegnaDate(int i)
    {
            SimpleDateFormat sd = new SimpleDateFormat("dd/MM/yyyy");
            String date = sd.format(ordini[i].data_consegna);
           return date;
            
    }
      
       public String getOrderDate(int i)
    {
            SimpleDateFormat sd = new SimpleDateFormat("dd/MM/yyyy");
           String date = sd.format(ordini[i].data_ordine);
           return date;
            
    }

    public String getStato() {
        return stato;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }
  
    public Long getIdordine() {
        return idordine;
    }

    public void setIdordine(Long idordine) {
        this.idordine = idordine;
    }
    
    
}
