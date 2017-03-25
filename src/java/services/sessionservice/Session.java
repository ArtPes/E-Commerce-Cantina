/*
 * Session.java
 *
 */

package services.sessionservice;

import java.util.*;
import javax.servlet.http.*;

//import util.*;
import services.errorservice.*;
import services.databaseservice.*;
import services.databaseservice.exception.*;

import blogics.*;
import util.Conversion;
import util.CartItem;

public class Session {


  
  public Session() {}
  
  
  //passo l'utente
  public static Cookie[] createCookie(DataBase database, User user) 
  throws NotFoundDBException,ResultSetDBException {
      
    Cookie[] cookies=new Cookie[3];
    Cookie cookie;      
   
    
     cookie=new Cookie("cduser",user.cduser);
     cookies[0]=cookie;
         
     cookie=new Cookie("tipo",user.tipo);
     cookies[1]=cookie;
     
     cookie=new Cookie("lingua",user.lingua);
     cookies[2]=cookie;
          

       
    for (int i=0; i<cookies.length; i++) {
      cookies[i].setPath("/");
    }
    
    return cookies;
  }
  
  
  public static Cookie[] useCookieCart(Cookie[] cookies,
          String productCode,String qta){
      
      /*Controllo se esiste il cookie del carrello
      se non esiste lo creo
      se non esiste ho solo due cookie
      */
      if (cookies.length == 3){
          /*non esiste il carrello
          quindi creo il cookie di carello e inserisco il
          prodotto nel carello
          */
          /*
          cambio tutto il procedimento basandomi su due cookie e non 
          3 di base
          */
          Cookie[] ucookies = new Cookie[4];
          ucookies[0] = cookies[0];
          ucookies[1] = cookies[1];
          ucookies[2] = cookies[2];
          /*il cookie di carello avrà il name cart
          e come value idprodotto*qta
          ogni prodotto inserito verrà poi separato con
          un altro token #
          */
          ucookies[3] = new Cookie("cart",productCode+"*"+qta+"#");
          util.Debug.println("cookie cart creato");
          for (int i=0;i < ucookies.length;i++)
              ucookies[i].setPath("/");
          return ucookies;
      } else {
          /*se il cookie di carrello esiste già gli aggiungo il prodotto
          utilizzo l'utility StringBuilder
          */
          /*provo a controllare la presenza del prodotto
          eventualmente modificherò gli append
          */
          
          /*cookies.length vale 3*/
          util.Debug.println("Il carrello esiste già");
          for (int i=0; i<cookies.length;i++) {
              if (cookies[i].getName().equals("cart")) {
                  CartItem[] items = getCartItems(cookies);
                  
                  for(int j=0; j < items.length; j++)
                  {
                      /*se prodotto già presente nel carrello*/
                      if(items[j].getProductCode().equals(Long.valueOf(productCode)))
                          //aggiorno la quantità
                      {
                          items[j].setQta(Integer.parseInt(qta));
                          cookies[i] = Conversion.CartItemstoCookie("cart",items);
                          return cookies;
                      }
                              
                  }
                  /*prodotto non presente nel carrello*/
                  StringBuilder cartprod = new StringBuilder(cookies[i].getValue());
                  cartprod.append(productCode).append("*").append(qta).append("#");
                  /*sovrascrivo il cookie carrello*/
                  cookies[i] = new Cookie("cart",cartprod.toString());
                  util.Debug.println(cartprod.toString());
              }
                    cookies[i].setPath("/"); 
              }
          return cookies;
      }
  }
  
  /**
   * Rimuove dal cookie del carrello il prodotto che corrisponde
   * ad productCode
   * @param cookies cookie di sessione
   * @param productCode id del prodotto che si vuole rimuovere dal carrello
   * @return Cookie[] array contenente i nuovi cookie di sessione
   */
  public static Cookie[] removeCartProduct(Cookie[] cookies, Long productCode)
  {
      
      CartItem[] items;
      Cookie[] ncookies;
            CartItem[] nitems;
            items = Session.getCartItems(cookies);
            nitems = new CartItem[items.length-1];
            int j=0;
            for (int i=0;i < items.length;i++)
            {
                if (!(items[i].getProductCode().equals(productCode)))
                {
                    util.Debug.println("productCode: "+productCode);
                    nitems[j] = new CartItem(items[i].getProductCode(),items[i].getQta());
                    j++;
                }
            }
            ncookies = new Cookie[cookies.length];
            for(int i=0; i < cookies.length; i++)
            {
                if (cookies[i].getName().equals("cart"))
                {
                    ncookies[i] = Conversion.CartItemstoCookie("cart", nitems);
                    ncookies[i].setPath("/");
                } else {
                    ncookies[i] = cookies[i];
                    ncookies[i].setPath("/");
                }
            }
            return ncookies;
  }
  
  
  
  
  /**
   * Rimuove il carrello cancellando il relativo cookie
   * @param cookies di sessione
   * @return i cookies di sessione senza il carrello
   */
  public static Cookie[] removeCart(Cookie cookies[])
    {
         for (Cookie cookie : cookies) {
             if (cookie.getName().equals("cart")) {
          cookie.setMaxAge(0);
          cookie.setPath("/");
             }
              else
               cookie.setPath("/");
      }
    
    return cookies;
        
        
    }
 
  
  public static String getValue(Cookie cookies[], String name, int position) {    //da mettere a posto
    
    int i;
    boolean found=false;
    String value=null;
    /*array list cookie list*/
   
   if (cookies != null) { 
    for (i=0;i<cookies.length && !found;i++)
      if (cookies[i].getName().equals(name)) {
          //cl CookieList
         ArrayList  cl = util.Conversion.tokenizeString(cookies[i].getValue(), "#");
          value = (String)cl.get(position);
        found=true;
      }        
   }
   /*altrimenti ritorno un value false*/
    return value;
  }
  
    public static String getValue(Cookie cookies[],String name) 
  {
      String cvalue = null;
      boolean found = false;
      if ( cookies != null) {
          for (int i = 0;i < cookies.length && !found; i++) 
              if (cookies[i].getName().equals(name)) 
              {
                  cvalue = cookies[i].getValue();
                  found = true;
                         
              }
      }
      
      return cvalue;
  }
  
  public static CartItem[] getCartItems(Cookie[] cookies) {
      
      ArrayList<String> cartelements = Conversion.tokenizeString(getValue(cookies,"cart"), "#");
      CartItem[] citems = new CartItem[cartelements.size()];
      for (int i = 0; i < cartelements.size(); i++) 
      {
          citems[i] = Conversion.tokenizeCartItem(cartelements.get(i),"*");
      }
      
      return citems;
  }
  
  
  
  public static Cookie[] deleteCookie(Cookie[] cookies) {
    
      for (Cookie cookie : cookies) {
          cookie.setMaxAge(0);
          cookie.setPath("/");
      }
    
    return cookies;
  }  
  
  public static void showCookies(Cookie[] cookies){
    
    util.Debug.println("Cookie presenti:" + cookies.length);
    int i;
    for (i=0;i< cookies.length;i++)
      util.Debug.println("Nome:" + cookies[i].getName() + " Valore:" +cookies[i].getValue());
  }
  
   public static String getCduser(Cookie[] cookies) {
    return getValue(cookies, "cduser", 0);
  }

  public static String getTipo(Cookie[] cookies) {
    return getValue(cookies, "tipo");
  }
  
  public static String getLingua(Cookie[] cookies) {
    return getValue(cookies, "lingua");
  }


}



