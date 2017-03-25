<%-- 
    Document   : Aorderlist
    Created on : 22-apr-2015, 10.46.24
    Author     : Arturo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="false"%>
<%@page buffer="12kb" %>
<%@page import="services.sessionservice.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>


<jsp:useBean id="ordineManagement" scope="page" class="bflows.OrdineManagement"/>
<jsp:setProperty name="ordineManagement" property="*"/>


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

     String dateO=null;
     String datD=null;
     String id=null;
  
  if(lang!=null){
  if (lang.equals("ita"))
     { dateO="Data Ordine";
       datD="Data Consegna";
       id="ID Ordine";
     }
  if (lang.equals("eng"))
     {dateO="Order Date";
      datD="Delivery Date";
      id="order's ID";
     }
  if (lang.equals("fra"))
     {dateO="Date de commande";
      datD="Livraison de la date";
      id="ID Ordre";
     }
  if (lang.equals("spa"))
     {dateO="Orden de la fecha";
      datD="Fecha de entrega";
      id="ID Orden";
     }
  }
    
  Cookie[] cookies=null;
  cookies=request.getCookies(); 

  
//------------------------------------------------------------------------------------------------------------------------   
String message = null;


 ordineManagement.setCookies(cookies);
 
  //controllo login   
  boolean loggedOn;   
  boolean loggVend=false; //da errore se non ha valore, false perchè qua non è ancora loggato l'utente
  boolean loggAdmin=true;
 if (Session.getCduser(cookies) != null) {
     loggedOn = true;
     lang=Session.getLingua(cookies);
     //per vedere se l'utente loggato è un venditore o compratore
     String tipo;
     tipo=Session.getTipo(cookies);
    if (tipo.equals("V"))
     {loggVend=true;
     }else loggVend=false;
 } else
     loggedOn = false;
 
 
    ordineManagement.setCookies(cookies);
    String status;
    if (request.getParameter("status") == null )
        status = "view";
    else
        status = request.getParameter("status");
   
    if(status.equals("change")){
       ordineManagement.AOrderModify();
       
    }
 
    ordineManagement.TotListOrderView();
  
  //gestione degli errori
  
  if (ordineManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (ordineManagement.getResult()==-2) {
    message=ordineManagement.getErrorMessage();
  }
%>
<html>
      <head>
    <title>order List</title>
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script type="text/javascript"  src="js/script.js"></script>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/slide.js"></script>
<script type="text/javascript" src="js/nav.js"></script>
<!--per la tabella-->
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/prototype/1.6.0.2/prototype.js"></script>
<script type="text/javascript" src="js/tablekit.js"></script>  
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
          <form name="changeStatus" action="Aorderlist.jsp" method="post">
            <table border="0"> 
             <tr>
               <td class="normal" width="100">Order ID</td>
               <td width="250">
               <input type="text" name="idordine" size="20" maxlength="50"/>
               </td>
             </tr>
             <tr>
               <td class="normal" width="100">Change status</td>
               <td width="250">
               <input type="radio" name="stato" value="In ritiro" checked="checked"/>In ritiro
               <input type="radio" name="stato" value="Consegnato"/>Consegnato
               <br><input type="radio" name="stato" value="Consegnato al corriere"/>Consegnato al corriere
               <br><input type="radio" name="stato" value="In viaggio"/>In viaggio
             </td>
             </tr>
             <tr>
               <td width="250">
               <input type="submit" value="Ok"/>
               <input type="reset" value="Annulla"/>
               </td>
             </tr>
            </table>
          <input type="hidden" name="status" value="change"/>
         </form>
       <div class="clear"></div>
         <table class="sortable resizable editable">
	   <thead>
	     <tr>
               <th class="sortfirstdesc" id="urgency"><%=id%></th>
               <th id="creation-date"><%=dateO%></th>
               <th id="time"><%=datD%></th>
               <th id="status">Status</th>
               <th id="cduser">User ID</th>
             </tr>
	   </thead>
	   <tfoot>
	     <tr>
               <td><%=id%></td>
               <td><%=dateO%></td>
               <td><%=datD%></td>
               <td>Status</td>
               <th id="cduser">User ID</th>
             </tr>
	   </tfoot>
	   <tbody>
              <% for(int i=0;i<ordineManagement.getOrdini().length;i++) { %>
		<tr id="N938747839">
                    <td><div class="urg2"><%=ordineManagement.getOrdini(i).idordine%></div></td>
                    <td><%=ordineManagement.getOrderDate(i)%></td>
                    <td><%=ordineManagement.getConsegnaDate(i)%></td>
                    <td><%=ordineManagement.getOrdini(i).stato%></td>
                    <td><%=ordineManagement.getOrdini(i).cduser%></td>
                 </tr>
                 <%}%>
	 </table>  
   </div>
</div>
<%@include file="footer.jsp" %>

