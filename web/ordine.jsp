
<!--
    Document   : orderlist
    Created on : Apr 15, 2015, 5:47:06 PM
    Author     : Arturo
-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="false"%>
<%@page buffer="12kb" %>
<%@page import="services.sessionservice.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<jsp:useBean id="OrdineManagement" scope="page" class="bflows.OrdineManagement"/>
<jsp:setProperty name="OrdineManagement" property="*"/>


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
     String citta=null;
     String via=null;
     String cap=null;
     String invia=null;
     String annulla=null;
  
  if(lang!=null){
  if (lang.equals("ita"))
     {tot="Totale Carrello";
      citta="Citta'";
      via="Via";
      cap="Cap";
      invia="Invia";
      annulla="Annulla";
      }
  if (lang.equals("eng"))
     {tot="Price";
      citta="City";
      via="Street";
      cap="Cap";
      invia="Send";
      annulla="Cancel";
     }
  if (lang.equals("fra"))
     {tot="Total dans le panier";
      citta="Ville";
      via="Rue";
      cap="Cap";
      invia="Envoyer";
      annulla="Annule";
     }
  if (lang.equals("spa"))
     {tot="Total en el carrito";
      citta="Ciudad";
      via="Vìa";
      cap="Cap";
      invia="Enviar";
      annulla="Cancelas";
     }
  }
 
    OrdineManagement.setCookies(cookies);
    String status;
    if (request.getParameter("status") == null )
        status = "view";
    else
        status = request.getParameter("status");

      OrdineManagement.OrderTot();//vedo il tot del carrello
      
      if (status.equals("insert"))
  {
     OrdineManagement.addOrdine();
      response.sendRedirect("checkordine.jsp");
  }  
  //gestione degli errori
  
  if (OrdineManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (OrdineManagement.getResult()==-2) {
    message=OrdineManagement.getErrorMessage();
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
       <form name="insertForm" action="ordine.jsp" method="post">
       <table border="0"> 
        <tr>
          <td class="normal" width="100"><%=citta%></td>
          <td width="250">
            <input type="text" name="citta" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=cap%></td>
          <td width="250">
            <input type="text" name="cap" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=via%></td>
          <td width="250">
            <input type="text" name="via" size="20" maxlength="50"/>
          </td>
        </tr>
         <tr>
          <td class="normal" width="100"><%=tot%> &#8364</td>
          <td width="250">
              <input type="text" name="tot" readonly="true" value="<%=OrdineManagement.getTotorder()%>" size="20" maxlength="50"/>
          </td>
        </tr> 
        <tr>
          <td class="normal" width="100">&#160;</td>
          <td width="250">
            <input type="button" value="<%=invia%>" onClick="insertordine()"/>
          </td>
        </tr>
      </table>
      <input type="hidden" name="status" value="insert"/>
    </form> 
          <form name="remove" action="cart.jsp" method="post">
    <table border="0">
     <tr>
       <td class="normal" width="100">&#160;</td>
       <td width="250">  
        <input type="button" name="impordine" value="<%=annulla%>" onClick="removeordine()"/>
       </td>
     </tr>
    </table>
    </form>
 </div>
</div>
<%@include file="footer.jsp" %>
