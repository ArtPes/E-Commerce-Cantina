<%-- 
    Document   : pagamento
    Created on : 17-apr-2015, 23.36.45
    Author     : Arturo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="false"%>
<%@page buffer="12kb" %>
<%@page import="services.sessionservice.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<jsp:useBean id="PagamentoManagement" scope="page" class="bflows.PagamentoManagement"/>
<jsp:setProperty name="PagamentoManagement" property="*"/>

<%   // Cookie[] cookies;
  String lang=null;
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

      String tot=null;

    PagamentoManagement.setCookies(cookies);
    String status;
    if (request.getParameter("status") == null )
        status = "view";
    else
        status = request.getParameter("status");

 if (status.equals("pagato")){
         PagamentoManagement.PagamentoManagementInsert();
         response.sendRedirect("finepagamento.jsp");}
  //gestione degli errori

    if (PagamentoManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (PagamentoManagement.getResult()==-2) {
    message=PagamentoManagement.getErrorMessage();
  }
%>
<html>
      <head>
    <title>Ordine</title>
  
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />  
<link rel="stylesheet" href="css/orderlist.css" type="text/css" media="all" /> 
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
            <!--lista di tutti i prodotti che si visualizza nella barra principale-->
        <%@include file="menu.jsp"%>
        </div>
        <div class="main">    
	</div>
</div>
<%@include file="footer.jsp" %>
