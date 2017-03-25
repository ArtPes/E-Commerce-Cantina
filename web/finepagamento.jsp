
<!--
    Document   : cart
    Created on : April 26, 2015, 19:04:28
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
  
  if(lang!=null){
  if (lang.equals("ita"))
     {tot="Grazie mille per aver fatto acquisti su Magna Cantina!!";
      }
  if (lang.equals("eng"))
     {tot="Many thanks for making purchases on Magna Cantina !!";
     }
  if (lang.equals("fra"))
     {tot="Merci beaucoup pour faire des achats sur Magna Cantina !!";
     }
  if (lang.equals("spa"))
     {tot="Muchas gracias por hacer compras en Magna Cantina !!";
     }
  }
 
 //elimino il carrello
 
    Session.removeCart(cookies);
       
    for (int i=0; i<ProdottoManagement.getCookies().length;i++)
         response.addCookie(ProdottoManagement.getCookies(i));
      
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
            <div class="heading"> 
                <h4><%=tot%></h4> 
            </div>
<div class="clear"></div>            
<%@include file="footer.jsp" %>
