
<!--
    Document   : wishlist
    Created on : Febr 15, 2015, 5:47:06 PM
    Author     : Arturo Pesaro
-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="false"%>
<%@page buffer="12kb" %>
<%@page import="services.sessionservice.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>


<jsp:useBean id="WishlistManagement" scope="page" class="bflows.WishlistManagement"/>
<jsp:setProperty name="WishlistManagement" property="*"/>


<%   // Cookie[] cookies;
String lang = null;
       /*imposto la lingua controllando dalla request quella del browser*/
    if (request.getLocale().getLanguage().equals("it"))
        lang="ita";
    if (request.getLocale().getLanguage().equals("en"))
        lang="eng";
    if (request.getLocale().getLanguage().equals("fr"))
        lang="fra";
    if (request.getLocale().getLanguage().equals("sp"))
        lang="spa";
    
  Cookie[] cookies=null;
  cookies=request.getCookies();
  
//------------------------------------------------------------------------------------------------------------------------  
String message = null;

 WishlistManagement.setCookies(cookies);
 
  //controllo login   
  boolean loggedOn;   
  boolean loggVend=false; //da errore se non ha valore, false perchè qua non è ancora loggato l'utente
  boolean loggAdmin=false;
 if (Session.getCduser(cookies) != null) {
     loggedOn = true;
        lang=Session.getLingua(cookies);
      
     //per vedere se l'utente loggato è un venditore o compratore
     String tipo;
     tipo=Session.getTipo(cookies);
     
      if(Session.getTipo(cookies).equals(""))//se usertype è null è un' amministratore
      {loggAdmin= true;
      }else loggAdmin=false;    
     if (tipo.equals("V"))
     {loggVend=true;
     }else loggVend=false;
     }else loggedOn = false;
 
 String status=request.getParameter("status");
 
  if (status==null)
   status="view";
  
   else 
    status = request.getParameter("status");
         
   if (status.equals("add"))
        WishlistManagement.insertNewProdotto();
   else if(status.equals("remove"))
        WishlistManagement.RemoveProd();
  
   
 WishlistManagement.WishlistView();
  
 //numero prodotti nel carrello
       
    String nop=null;
  
  if(lang!=null){
  if (lang.equals("ita"))
     {
      nop="Nessun prodotto trovato";}
  if (lang.equals("eng"))
     {
      nop="No products found";}
  if (lang.equals("fra"))
     {
      nop="Aucun produit trouvé";}
  if (lang.equals("spa"))
     {
      nop="No hay productos encontrados";}
  }
    
  //gestione degli errori
  
  if (WishlistManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (WishlistManagement.getResult()==-2) {
    message=WishlistManagement.getErrorMessage();
  }
%>
<html>
      <head>
    <title>Wishlist</title>
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script type="text/javascript"  src="js/script.js"></script>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/slide.js"></script>
<script type="text/javascript" src="js/nav.js"></script>
<script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->
<%@ include file="top_panel.jsp" %>
</head>
<body>
  <div class="wrap">
	<div class="header">
	  <%@ include file="top_header.jsp" %>
          <%@include file="menu.jsp"%>
        </div>
        <div class="main">
          <div class="content">
    	      <%if (WishlistManagement.getProdotti().length==0) {%>
                 <p><%=nop%></p>
              <%}%>  
    	        <div class="section group">
                     <% for(int i=0;i<WishlistManagement.getProdotti().length;i++) {%>
                    <form name="pid<%=i%>" method="post" action="details.jsp">
                        <div class="section group">
			    <div class="cont-desc span_1_of_2">				
					<div class="grid images_3_of_2">
                                            <a href="javascript:dsubmit(<%=i%>);"><img src="images/<%=WishlistManagement.getProdotti(i).path%>" width="100" height="100" /></a>
					</div>
				 <div class="desc span_3_of_2">
					<a href="javascript:dsubmit(<%=i%>);"><h2><%=WishlistManagement.getProdotti(i).nome_p%></h2></a>
					<p><%=WishlistManagement.getProdotti(i).regione%></p>					
					<div class="price">
					 <p>Quantity: <span><%=WishlistManagement.getProdotti(i).quantita%></span>
                                         | Price: <span><%=WishlistManagement.getProdotti(i).prezzo%></span></p>
					</div>                     
                                 </div>  
                            </div> 
                        </div> 
                       <input type="hidden" name="productCode" value="<%=WishlistManagement.getProdotti(i).productCode%>"/>	
                    </form>
                   <div class="add-cart">
                      <form name="relement<%=i%>" method="post" action="wishlist.jsp">
                      <input type="hidden" name="productCode" value="<%=WishlistManagement.getProdotti(i).productCode%>"/>
                      <input type="hidden" name="status" value="remove"/>
                      <div class="button"><a href="javascript:rsubmit(<%=i%>)">Remove</a></div>
                      </form>
                     <div class="clear"></div>
		   </div>
                </div>
             </div>
          <%}%>                                     
 	</div>   
     </div>
<%@include file="footer.jsp" %>
