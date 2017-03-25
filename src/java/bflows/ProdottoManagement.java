
package bflows;

import blogics.*;
import java.util.*;
import javax.servlet.http.Cookie;
import services.databaseservice.*;
import services.databaseservice.exception.*;
import services.errorservice.*;
import services.logservice.*;
import services.sessionservice.Session;
import util.CartItem;


public class ProdottoManagement implements java.io.Serializable{
    
  private int result;
  private String errorMessage;
  private Prodotto[] prodotti;
  private Prodotto[] prodottiV;   //prodotti del venditore
  private Prodotto[] prodottiNew; //prodotti appena inseriti
  private Prodotto[] aVprodotti;  //prodotti del venditore
  private String nome_p;
  private String regione;
  private String type_p;
  private Long productCode;
  private String cduser;
  private Double prezzo; 
  private String path;  
  private String adettagli;
  private Long quantita;
  private Prodotto prodotto;
  private Cookie[] cookies; 
  private Wishlist[] wishlists;
  private Prodotto[] productscart; //prodotti del carrello
  private Prodotto productsuv; //prodotti secondo i gusti del compratore
  private double totcart;
  int ncartelements;
  private int qta;
  private CartItem[] citems;
  private String search;
  private Dettagli dettaglii; 
  private Dettagli[] dettaglis;
  private String lingua;
  private Visualizza lv;
  private Long TOTALE;
    
//RESTITUISCE I VARI ARRAY DI PRODOTTI NEW, DEL VENDITORE, LA LISTA "VISUALIZZA"....
public void ProdottoManagementView() throws DuplicatedRecordDBException {
        
        DataBase database = null;
         
        ArrayList aproductsofs = new ArrayList();
        ArrayList aproductspush = new ArrayList();
        ArrayList awishlists =new ArrayList();
        ArrayList<Prodotto> aprodotti = new ArrayList<Prodotto>(); //prodotti random
        ArrayList<Prodotto> newprodotti = new ArrayList<Prodotto>();//prodotti ordine decrescente
        ArrayList<Prodotto> aVprodotti = new ArrayList<Prodotto>(); //prodotti venditore
        ArrayList<Prodotto> sprodotti = new ArrayList<Prodotto>();//search
        ArrayList<Dettagli> sdettagli = new ArrayList<Dettagli>();//search dettagli
        
    
        try {
            database = DBService.getDataBase();
                
                //restituisce la lista di prodotti random
                aprodotti = prodottoService.getProdotti(database);
                prodotti = new Prodotto[aprodotti.size()];
                aprodotti.toArray(prodotti);
                //prodotti ordinati in ordine decrescente->maggiore to minore
                newprodotti = prodottoService.getProdottiNew(database);
                prodottiNew = new Prodotto[newprodotti.size()];
                newprodotti.toArray(prodottiNew);
                
                //LISTA PRODOTTI DI UN DETERMINATO COMPRATORE
                if(Session.getCduser(cookies)!=null && Session.getTipo(cookies).equals("C")){
                /*prelevo l' ultima visualizzazione*/
                lv = VisualizzaService.getUltimeVisualizzazioni(database,String.valueOf(Session.getCduser(cookies)));
                if(lv!=null)//se ha già delle visualizzazioni le facico vedere
                    {
                     productsuv = prodottoService.getProdotto(database,lv.productCode);
                    }
                else{//se non ne ha metto un prodotto random in evidenza
                    productCode=new Long(1);
                    productsuv = prodottoService.getProdotto(database,productCode);
                    }
                }
                //LISTA PRODOTTI DI UN DETERMINATO VENDITORE
                if(Session.getCduser(cookies)!=null)
                {
        
                    /*prodottiV è l'array dei prodotti del venditore
                    si stava redifinendo l'array prodotti che contiene tutti
                    quelli presenti nel db
                    */
                    aVprodotti = prodottoService.getProdottiV(database,String.valueOf(Session.getCduser(cookies)));
                    prodottiV = new Prodotto[aVprodotti.size()];
                    aVprodotti.toArray(prodottiV);

                
                /** totale carrello e elementi carrello*/
                citems = Session.getCartItems(cookies);
                 if (citems != null) {
                 /*prendo gli elementi che ci sono nel carrello e faccio il totale
                 */
                 totcart = 0;
                 ncartelements = 0;
                 productscart = new Prodotto[citems.length];
                 //visualizza totale carrello e quantità prodotti nel cart.jsp
                 for (int i = 0; i < citems.length;i++) {
                     productscart[i] = prodottoService.getProdotto(database,citems[i].getProductCode());
                     util.Debug.println("quantita: "+citems[i].getQta()+ " prezzo: "+productscart[i].prezzo);
                     totcart += citems[i].getQta()*productscart[i].prezzo; 
                     ncartelements += citems[i].getQta();
                    }
                }
                    
              }//blocco operazioni autente autenticato
              //array prodotti da search o tipi
                if (search!=null){
                if (search.length() > 1)
                {
                sprodotti = prodottoService.searchProdotti(database,search);
                prodotti = new Prodotto[sprodotti.size()];
                sprodotti.toArray(prodotti);
                //inizializzo anche i relativi dettagli che avranno i rispettivi indici dei prodotti
                //dettagli per search
                sdettagli = DettagliService.getDettagliSearch(database, search);
                dettaglis = new Dettagli[sdettagli.size()];
                sdettagli.toArray(dettaglis);
                
                }
                else
                {   
                sprodotti = prodottoService.searchProdottiType(database,search); //ricerca vino per tipo
                prodotti = new Prodotto[sprodotti.size()];
                sprodotti.toArray(prodotti);
                //dettagli per ricerca con tipo
                sdettagli = DettagliService.getDettagliSearchType(database, search);
                dettaglis = new Dettagli[sdettagli.size()];
                sdettagli.toArray(dettaglis);
                }
             }           
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
//RESTITUISCE I DETTAGLI(nome,prezzo,regione...) DEL PRODOTTO SCELTO
public void ProdottoDetailsView() {      
        DataBase database = null;
        try {
            database = DBService.getDataBase();
            prodotto = prodottoService.getProdotto(database, productCode);
          
                util.Debug.println("Codice prodotto: "+productCode);
                util.Debug.println("Nome prodotto: "+prodotto.nome_p);
                

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
//RESTITUISCE I DETTAGLI DEL PRODOTTO
public void ProdottoDetails() {
        
        DataBase database = null;
        //preleva la lingua dal cookie personale dell'utente
        if(Session.getCduser(cookies)!=null)
        {
        lingua=Session.getLingua(cookies);
        }else lingua="eng";
        try {
            database = DBService.getDataBase();
            dettaglii = DettagliService.getDettagli(database, productCode,lingua);
            
          if(dettaglii==null) //se non trova i dettagli del prodotto nella lingua dell'utente, cerca se ci sono in altre lingue
          {
               lingua="eng";
               database = DBService.getDataBase();
               dettaglii = DettagliService.getDettagli(database, productCode,lingua);
          }
          
          if(dettaglii==null)
          {
               lingua="spa";
               database = DBService.getDataBase();
               dettaglii = DettagliService.getDettagli(database, productCode,lingua);
          }
          
          if(dettaglii==null)
          {
               lingua="ita";
               database = DBService.getDataBase();
               dettaglii = DettagliService.getDettagli(database, productCode,lingua);
          }
          
          if(dettaglii==null)
          {
               lingua="fra";
               database = DBService.getDataBase();
               dettaglii = DettagliService.getDettagli(database, productCode,lingua);
          }
          
          if(dettaglii==null) //dettaglio speciale se non trova i dettagli in altre lingue
          {
               productCode=0l;
               lingua="special";
               database = DBService.getDataBase();
               dettaglii = DettagliService.getDettagli(database, productCode,lingua);
          }
              
          
          if(dettaglii==null) //se manca il messaggio speciale
                util.Debug.println("Dettagli è null");
                util.Debug.println("Codice prodotto: "+productCode);
                

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
//quando si compra un prodotto, scala la quantità 
public void Buy(){DataBase database = null;
        try {
            database = DBService.getDataBase();
            Prodotto prodotto = prodottoService.getProdotto(database,productCode);
            if ( database==null ) {
                setResult(EService.RECOVERABLE_ERROR);
                setErrorMessage("login");
            } 
            else 
            { citems = Session.getCartItems(cookies);
                 if (citems != null) 
                 {
                 /*prendo gli elementi che ci sono nel carrello e faccio il totale
                 */
                 productscart = new Prodotto[citems.length];
                 for (int i = 0; i < citems.length;i++) 
                 {
                     productscart[i] = prodottoService.getProdotto(database,citems[i].getProductCode());
                     qta = citems[i].getQta();
                     prodottoService.ReduceQtaProd(database, productscart[i].productCode, productscart[i].quantita, qta);     
                 }
                 }
            }
        
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
//AGGIUNGE UN PRODOTTO AL CARRELLO
public void AddCart(){
        //controllo presenza e quantità del prodotto
        DataBase database = null;
        try {
            database = DBService.getDataBase();
            /*da modificare getDetails in getProdotto, evito una duplicazione di funzione*/
            Prodotto prodotto = prodottoService.getProdotto(database,productCode);
            
             if ( database==null ) {
                setResult(EService.RECOVERABLE_ERROR);
                setErrorMessage("login");           
            } 
                
            if ( qta > prodotto.quantita ) {
                setResult(EService.RECOVERABLE_ERROR);
                setErrorMessage("Quantità richiesta non disponibile. Max: "+prodotto.quantita);
           
            } else {
                cookies = Session.useCookieCart(cookies,String.valueOf(productCode),String.valueOf(qta));
            }
            database.commit();
           
        } catch (NotFoundDBException e) {
            EService.logAndRecover(e);
            setResult(EService.UNRECOVERABLE_ERROR);
        } catch (ResultSetDBException ex) {
            EService.logAndRecover(ex);
             setResult(EService.UNRECOVERABLE_ERROR);
        } finally {
            try { if(database!=null)
                        database.close();}
            catch(NotFoundDBException e) { EService.logAndRecover(e);}
        }

      }
//RIMUOVE UN PRODOTTO DAL CARRELLO    
public void RemoveCartElement(){
        //rimuovo il prodotto del carrello dai cookies
          //creando un nuovo array di oggetti items senza l'item non voluto
        if (productCode != null)
        {
           cookies = Session.removeCartProduct(cookies, productCode);    
        }
      }
//INSERIRE UN PRODOTTO NEL DB
public void ProdottoManagementInsert() {
    
    DataBase database = null;    
    Prodotto prodotto;
    
    try {
      
      database=DBService.getDataBase();
      
      prodotto=prodottoService.insertNewprodotto(database,nome_p,regione,type_p,quantita,prezzo,path,cduser);            
      
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
//CANCELLARE UN PRODOTTO DAL DB   
public void ProdottoManagementDelete() {
    
    DataBase database = null;
    Prodotto prodotto;
    Dettagli dettagli = null;
    try {
      
      database=DBService.getDataBase();
            
      prodotto=prodottoService.getProdotto(database, productCode);
      dettagli=DettagliService.getDettagli(database,productCode,Session.getLingua(cookies));//prende la lingua dell'utente perchè sicuramente esisterà una descrizione in quella lingua
      prodotto.delete(database);
      dettagli.deleteDettagli(database);
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
//MODIFICARE UN PRODOTTO NEL DB  
public void ProdottoManagementModify() {
    
    DataBase database=null;    
    Prodotto prodotto;
    prodotto=null;
    
    try {
      
      database=DBService.getDataBase();
      
      prodotto=prodottoService.getProdotto(database,productCode);
      
      prodotto.productCode=productCode;
      prodotto.prezzo=prezzo;
      prodotto.quantita=quantita;
      
      prodotto.update(database);
      
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
      setErrorMessage("prodotto inserito e' gia' esistente.");
      database.rollBack();  
            
    } finally {
      try { database.close(); }
      catch (NotFoundDBException e) { EService.logAndRecover(e); }
    }
    
  }   
//INSERIRE LE PREFERENZE SUI PRODOTTI DI UN DETERMINATO UTENTE  
public void UserViewProduct() {
        
        DataBase database = null;
        try {
            database = DBService.getDataBase();
            String cduser = String.valueOf(Session.getCduser(cookies));
            VisualizzaService.insertNewView(database, productCode,cduser);
            if (database != null)
            database.commit();
        }
        
        catch(NotFoundDBException e) {
            EService.logAndRecover(e);
            setResult(EService.UNRECOVERABLE_ERROR);
            if ( database != null)
            database.rollBack();
        }
        
        catch(DuplicatedRecordDBException e) {
            EService.logAndRecover(e);
            setResult(EService.RECOVERABLE_ERROR);
            if (database != null)
                database.rollBack();    
        }
        catch(ResultSetDBException e) {
            EService.logAndRecover(e);
            setResult(EService.UNRECOVERABLE_ERROR);
            if (database != null)
                database.rollBack();
        }
        
        finally 
        { 
            try{
                if (database != null)
                database.close();
            }
            
            catch (NotFoundDBException e) {
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
   //restituisce i prodotti index VENDITORE
  public Prodotto getProdottiV(int index) {
    return this.prodottiV[index];
  }
     //restituisce i prodotti
  public Prodotto[] getProdottiV() {
    return this.prodottiV;
  } 
//setta l'iesimo  prodotto
  public void setProdottiV(int index, Prodotto prodotti) {
    this.prodottiV[index] = prodotti;//-----------------------------------FORSE NON VA BENE!!!!!!!!!!!!!
  }
  //setta prodotti
  public void setProdottiV(Prodotto[] prodotti) {
    this.prodottiV = prodottiV;
  } 
   //restituisce i prodotti index 
  public Prodotto getProdottiNew(int index) {
    return this.prodottiNew[index];
  }
   //restituisce i prodotti
  public Prodotto[] getProdottiNew() {
    return this.prodottiNew;
  } 
//setta l'iesimo  prodotto
  public void setProdottiNew(int index, Prodotto prodotti) {
    this.prodottiNew[index] = prodotti;
  }
  //setta prodotti
  public void setProdottiNew(Prodotto[] prodottiNew) {
    this.prodottiNew = prodotti;
  } 
  //restituisce la regione
  public String getRegione() {
    return this.regione;
  }
  //setta regione  
  public void setRegione(String regione) {
    this.regione = regione;
  }
  //restituisce prezzo
   public Double getPrezzo() {
    return this.prezzo;
  }
  //setta prezzo 
  public void setPrezzo(Double prezzo)
  {
      this.prezzo = prezzo;
  }
  //restituisce nome_p   
   public String getNome_p() {
    return this.nome_p;
  }
   //setta nome_p
  public void setNome_p(String nome_p) {
    this.nome_p = nome_p;
  }

  public String getType_p() {
    return this.type_p;
  }
  public void setType_p(String type_p) {
    this.type_p = type_p;
  }
  public String getPath() {
    return this.path;
  }
  public void setPath(String path) {
    this.path = path;
  }
  public String getADettagli() {
    return this.adettagli;
  }
  public void setADettagli(String adettagli) {
    this.adettagli = adettagli;
  }
  public Long getQuantita() {
    return this.quantita;
  }
  public void setQuantita(Long quantita) {
    this.quantita = quantita;
  }
    //restituisce CDUSER   
   public String getCduser() {
    return this.cduser;
  }
   //setta CDUSER  
  public void setCduser(String cduser) {
    this.cduser = cduser;
  }
  
   public String getSearch() {
    return this.search;
  }
   //setta search
  public void setSearch(String search) {
    this.search = search;
  }

  public void setProdotto(Prodotto prodotto) {
    this.prodotto = prodotto;
  }
  public Prodotto getProdotto() {
      
    return this.prodotto;
  }
  public void setDettagli(Dettagli dettaglii) {
    this.dettaglii = dettaglii;
  }
  public Dettagli getDettagli() {
      
    return this.dettaglii;
  }

  public Long getProductCode() {
        return productCode;
    }

  public void setProductCode(Long productCode) {
        this.productCode = productCode;
    }
   public Wishlist[] getWishlists() {
        return wishlists;
    }
      public Wishlist getWishlists(int index) {
        return wishlists[index];
    }

    public Prodotto[] getProductscart() {
        return productscart;
    }
    
    public Prodotto getProductscart(int index) {
        return productscart[index];
    } 
   
      public int getNcartelements() {
        return this.ncartelements;
    }
    public double getTotcart() {
        return this.totcart;
    }
    public CartItem getCitems(int index)
    {
        return this.citems[index];
    }
    public CartItem[] getCitems()
    {
        return this.citems;
    }
        public Cookie[] getCookies()
    {
        return this.cookies;
    }
    public Cookie getCookies(int index)
    {
        return this.cookies[index];
    }
    public void setCookies(Cookie[] cookies) 
    {
        this.cookies = cookies;
    }
    public void setCookies(int index,Cookie cookie)
    {
        this.cookies[index] = cookie;
    }

    public Dettagli[] getDettaglis() {
        return dettaglis;
    }
    
    public Dettagli getDettaglis(int index){
        return dettaglis[index];
    }
    
    public void setQta(int qta) {
        this.qta=qta;
    }
    public Prodotto getProductsuv() {
        return this.productsuv;
    }
    public void setProductsuv(Prodotto productsuv) {
        this.productsuv=productsuv;
    }
  
}
