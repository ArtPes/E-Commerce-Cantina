
<!--
    Document   : cart
    Created on : April 8, 2015, 10:15:51 AM
    Author     : richardus
-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="false"%>
<%@page buffer="12kb" %>
<%@page import="services.sessionservice.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>


<jsp:useBean id="ProdottoManagement" scope="page" class="bflows.ProdottoManagement"/>
<jsp:setProperty name="ProdottoManagement" property="*"/>


<%   
      // Cookie[] cookies;
  String lang = null;
       /*imposto la lingua controllando dalla request quella del browser*/
    if (request.getLocale().getLanguage().equals("it"))
        lang="ita";
    if (request.getLocale().getLanguage().equals("en"))
        lang="eng";
    if (request.getLocale().getLanguage().equals("fr"))
        lang="fra";
    if (request.getLocale().getLanguage().equals("es"))
        lang="spa";
   
  Cookie[] cookies=null;
  cookies=request.getCookies();

//------------------------------------------------------------------------------------------------------------------------   
    
String message = null;

 ProdottoManagement.setCookies(cookies);
 
  //controllo login   
  boolean loggedOn;   
  boolean loggVend=false; //da errore se non ha valore, false perchè qua non è ancora loggato l'utente
  boolean loggAdmin=false;
 if (Session.getCduser(cookies) != null) {
     loggedOn = true;
     //per vedere se l'utente loggato è un venditore o compratore
     lang=Session.getLingua(cookies);
     String tipo;
     tipo=Session.getTipo(cookies);
     

      if(Session.getTipo(cookies).equals(""))//se usertype è null è un' amministratore
      {loggAdmin= true;
      }else loggAdmin=false;    
     if (tipo.equals("V"))
     {loggVend=true;
     }else loggVend=false;
     }else loggedOn = false;
 
    String tot=null;
   String num=null;
   String prezzo=null;
   String qta=null;
  
  if(lang!=null){
  if (lang.equals("ita"))
     {tot="Totale Carrello";
      num="N° prodotti";
      prezzo="Prezzo";
      qta="Quantità";
      }
  if (lang.equals("eng"))
     {tot="Price";
      num="N° products";
      prezzo="Price";
     qta="Quantity";
     }
  if (lang.equals("fra"))
     {tot="Total dans le panier";
      num="N° prodotte";
      prezzo="Prix";
     qta="Quantitè";
     }
  if (lang.equals("spa"))
     {tot="Total en el carrito";
      num="N° prodottos";
      prezzo="Precio";
     qta="Cantidad";
     }
  }
 
 String status=request.getParameter("status");
 
  if (status==null)
   status="view";
   else 
    status = request.getParameter("status");

   if (status.equals("add"))
   {
        ProdottoManagement.AddCart();       
         for (int i=0; i<ProdottoManagement.getCookies().length;i++)
        response.addCookie(ProdottoManagement.getCookies(i));
   }
   else if(status.equals("remove")){
        ProdottoManagement.RemoveCartElement();
         /*riscrivo i cookies sulla header http*/
          for (int i=0; i<ProdottoManagement.getCookies().length;i++)
          response.addCookie(ProdottoManagement.getCookies(i));}
   
   if (status.equals("buy")){           
       ProdottoManagement.Buy();
       Session.removeCart(cookies);
       
    for (int i=0; i<ProdottoManagement.getCookies().length;i++)
        response.addCookie(ProdottoManagement.getCookies(i));
        response.sendRedirect("ordine.jsp");}
   
   if (status.equals("rmcart")){
       Session.removeCart(cookies);
       
    for (int i=0; i<ProdottoManagement.getCookies().length;i++)
         response.addCookie(ProdottoManagement.getCookies(i));
         response.sendRedirect("home.jsp");}
     
 ProdottoManagement.ProdottoManagementView();
     
  //gestione degli errori
  
  if (ProdottoManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (ProdottoManagement.getResult()==-2) {
    message=ProdottoManagement.getErrorMessage();
  }
%>
<html>
      <head>
    <title>Shopping Cart</title>
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script type="text/javascript"  src="js/script.js"></script>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/slide.js"></script>
<script type="text/javascript" src="js/nav.js"></script>  
<script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->

<%@ include file="top_panel.jsp" %>
 <!--panel -->
</head>
<body>
  <div class="wrap">
    <div class="header">
	<%@ include file="top_header.jsp" %>
        <!--lista di tutti i prodotti che si visualizza nella barra principale--> 
        <%@include file="menu.jsp"%>
    </div>
    <div class="main">
      <div class="content">
    	 <div class="section group">
              <% for(int c=0;c<ProdottoManagement.getProductscart().length;c++) {%>
                <div class="section group">
		    <div class="cont-desc span_1_of_2">				
			<div class="grid images_3_of_2">
			 <img src="images/<%=ProdottoManagement.getProductscart(c).path%>" alt="" height="100" />
			</div>
			<div class="desc span_3_of_2">
			  <h2><%=ProdottoManagement.getProductscart(c).nome_p%></h2>
		          <p><%=ProdottoManagement.getProductscart(c).regione%></p>					
			  <div class="price">
                            <p><%=qta%>: <span><%=ProdottoManagement.getCitems(c).getQta()%></span></p>
			    <p><%=prezzo%>: <span><%=ProdottoManagement.getProductscart(c).prezzo%></span></p>
			  </div>
			  <div class="add-cart">
                            <form name="relement<%=c%>" method="post" action="cart.jsp">
                                <input type="hidden" name="productCode" value="<%=ProdottoManagement.getProductscart(c).productCode%>"/>
                                <input type="hidden" name="status" value="remove"/>
                                <div class="button"><a href="javascript:rsubmit(<%=c%>)" class="hvr-skew">Remove</a></div>
                            </form>
                            <div class="clear"></div>
		           </div>
			</div>
                    </div>
 	        </div>
              <%}%> 
              <span class="no_prodotto">(<%=tot%>: <%=ProdottoManagement.getTotcart()%>€)</span>
              <span class="no_prodotto">(<%=num%>: <%=ProdottoManagement.getNcartelements()%>)</span>
          </div>
          <div class="add-cart">
            <form name="rmcart" method="post" action="cart.jsp">
              <div class="button"><a href="javascript:document.rmcart.submit();">
              <img src="images/delete_cart.png" height="100" align="left" alt="Delete Cart"></a></div>
              <input type="hidden" name="status" value="rmcart"/>
            </form>
            <form name="buy" method="post" action="ordine.jsp">
	      <div class="button" ><a href="javascript:document.buy.submit();" ><img src="images/buy_now.png" height="140" align="right" class="hvr-bounce-in" ></a><!--tasto a dx perchè maggior parte non è mancina--></div>
              <input type="hidden" name="status" value="buy"/>
              <input type="hidden" name="totcart" value="<%=ProdottoManagement.getTotcart()%>"/>
            </form>         
      </div>
     </div>
    </div>
  </div>           
<div class="clear"></div>            
<%@include file="footer.jsp" %>
