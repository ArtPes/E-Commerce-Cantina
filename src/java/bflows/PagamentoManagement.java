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


public class PagamentoManagement implements Serializable {
    
   private Pagamento pagamento;
   private Long idordine;
   private double impordine;
   private Coupon[] coupons;
   private Date data;
   private Cookie[] cookies;
   private String errorMessage;
   private int result;
   private String stato;
   private Long idcoupon;
  
  
    public PagamentoManagement() {}
    
    //inserimento di un pagamento
    public void PagamentoManagementInsert()
    {
        DataBase database = null;
        try {
            database = DBService.getDataBase();
            /*recupero il coupon*/
             double ipagamento = impordine;
            if (idcoupon != null){
            Coupon cp = CouponService.getCouponfromId(database,idcoupon); 
                ipagamento = ipagamento - cp.importo;
                /*faccio un check sull'importo pagamento*/
                if(ipagamento < 0)
                    ipagamento = 0;
                /*setto il coupon come usato*/
                cp.delete(database);
            }
            setStato("confermato");
            data = new Date();
            /*devo inserire il pagamento*/
           pagamento = PagamentoService.insertNewPagamento(database, data, idordine, impordine, stato);
           
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
      
        } catch (DuplicatedRecordDBException ex) {

          EService.logAndRecover(ex);
          setResult(EService.RECOVERABLE_ERROR);
          setErrorMessage("Errore sul pagamento! riprova");
          if(database!=null)
              database.rollBack();  

        } finally {
          try { if(database!=null)
                    database.close(); }
          catch (NotFoundDBException e) 
          { EService.logAndRecover(e); }
        }
    }

    public Pagamento getPagamento() {
        return pagamento;
    }

    public void setPagamento(Pagamento pagamento) {
        this.pagamento = pagamento;
    }

    public Long getIdordine() {
        return idordine;
    }

    public void setIdordine(Long idordine) {
        this.idordine = idordine;
    }

    public double getImpordine() {
        return impordine;
    }

    public void setImpordine(double impordine) {
        this.impordine = impordine;
    }

    public Coupon[] getCoupons() {
        return coupons;
    }
    
    public Coupon getCoupons(int index) {
        return coupons[index];
    }


    public void setCoupons(Coupon[] coupons) {
        this.coupons = coupons;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public Cookie[] getCookies() {
        return cookies;
    }

    public void setCookies(Cookie[] cookies) {
        this.cookies = cookies;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }
    
    private void setStato(String stato) {
        this.stato = stato;
    }

    public Long getIdcoupon() {
        return idcoupon;
    }

    public void setIdcoupon(Long idcoupon) {
        this.idcoupon = idcoupon;
    }
    
    
    
  
    
}
