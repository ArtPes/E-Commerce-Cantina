/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package bflows;

import blogics.*;
//import blogics.Ordine;  da sviluppare!!!!!!!!!!!
import java.beans.*;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Cookie;
import services.databaseservice.DBService;
import services.databaseservice.DataBase;
import services.databaseservice.exception.NotFoundDBException;
import services.databaseservice.exception.ResultSetDBException;
import services.errorservice.EService;
import services.sessionservice.Session;

/**
 *
 * @author Arturo
 */
public class CouponManagement implements Serializable {
    
     private String errorMessage;
     private int result;
     private Cookie[] cookies;
     private String cduser;
     private String dinizio;
     private String dfine;
     private String importo;
     private int usato;
     private Coupon[] coupons;
     private Date data;
     private Long id;
     
     public CouponManagement(){}
     
    //visualizzare l'elenco dei coupon dato un cduser in fase di pagamento
     public void CouponView() {
        
        DataBase database = null;
        ArrayList<Coupon> couponss = new ArrayList<Coupon>(); //prodotti random

        try {
            database = DBService.getDataBase();
                 data = new Date();
                //restituisce la lista di coupon dell'utente corrente
                couponss = CouponService.getUserCoupon(database,String.valueOf(Session.getCduser(cookies)),data);
                coupons = new Coupon[couponss.size()];
                couponss.toArray(coupons);
       util.Debug.println("coupons.length = "+coupons.length);
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
   //amministratore vede tutti i coupon degli utenti
   public void TotCouponView() {
        
        DataBase database = null;
        ArrayList<Coupon> couponss = new ArrayList<Coupon>(); 

        try {
            database = DBService.getDataBase();
                 data = new Date();
                //restituisce la lista di coupon
                couponss = CouponService.getTotCoupon(database);
                coupons = new Coupon[couponss.size()];
                couponss.toArray(coupons);
       util.Debug.println("coupons.length = "+coupons.length);
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
     
    //metodo per inserimento di un coupon
     public void CouponManagementInsert()
     {
         DataBase database = null;
         try {
               database = DBService.getDataBase();
             java.util.Date di = new SimpleDateFormat("yyyy-MM-dd").parse(dinizio);
              java.util.Date df = new SimpleDateFormat("yyyy-MM-dd").parse(dfine);
              CouponService.insertNewCoupon(database, cduser,Double.parseDouble(importo), di, df, usato);
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
      
        } catch (ParseException ex) {
             Logger.getLogger(CouponManagement.class.getName()).log(Level.SEVERE, null, ex);
             setResult(EService.RECOVERABLE_ERROR);
             setErrorMessage("Inserire la data nel formato corretto");
         }finally {
          try { if(database!=null)
              database.close(); }
          catch (NotFoundDBException e) 
          { EService.logAndRecover(e); }
        }
     }
     
   /**
    * getter errorMessage
    * @return 
    */  
    public String getErrorMessage() {
        return errorMessage;
    }

    /**
     * setter errorMessage
     * @param errorMessage 
     */
    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    /**
     * getter per result
     * @return 
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
     * setter per i cookie
     * @param cookies 
     */
    public void setCookies(Cookie[] cookies) {
        this.cookies = cookies;
    }

    /**
     * getter per cduser
     * @return 
     */
    public String getCduser() {
        return cduser;
    }

    /**
     * setter per cduser
     * @param cduser 
     */
    public void setCduser(String cduser) {
        this.cduser = cduser;
    }

    /** setter per la data di inizio coupon
     * 
     * @param dinizio 
     */
    public void setDinizio(String dinizio) {
        this.dinizio = dinizio;
    }
    /**
     * setter per la data di fine coupon
     * @param dfine 
     */
    public void setDfine(String dfine) {
        this.dfine = dfine;
    }
    public String getImporto(){
        return this.importo;
    }
    public void setImporto(String importo) {
        this.importo = importo;
    }
    public void setUsato(int usato) {
        this.usato = usato;
    }
    public Coupon getCoupons(int index){
        return coupons[index];
    }
    public Coupon[] getCoupons() {
    return coupons;
    } 
    public void setCoupons(int index, Coupon coupons) {
    this.coupons[index] = coupons;
    }
    public void setCoupons(Coupon[] coupons) {
    this.coupons = coupons;
    }    

}
