<%-- 
    Document   : Coupon
    Created on : 22-apr-2015, 10.49.24
    Author     : Arturo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="false"%>
<%@page buffer="12kb" %>
<%@page import="services.sessionservice.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>


<jsp:useBean id="CouponManagement" scope="page" class="bflows.CouponManagement"/>
<jsp:setProperty name="CouponManagement" property="*"/>


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

 CouponManagement.setCookies(cookies);
 
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
 
     String dateO=null;
     String datD=null;
     String id=null;
  
  if(lang!=null){
  if (lang.equals("ita"))
     { dateO="Data Inizio";
       datD="Data Fine";
       id="ID User";
     }
  if (lang.equals("eng"))
     {dateO="Final Date";
      datD="Start Date";
      id="User's ID";
     }
  if (lang.equals("fra"))
     {dateO="Date de commande";
      datD="Livraison de la date";
      id="ID User";
     }
  if (lang.equals("spa"))
     {dateO="Orden de la fecha";
      datD="Fecha de entrega";
      id="ID User";
     }
  }
 
 CouponManagement.setCookies(cookies);
 
 String status=request.getParameter("status");
  if (status==null) status="view";
   
      if (status.equals("insert"))
       {
        CouponManagement.CouponManagementInsert();
        response.sendRedirect("coupon.jsp");
       }
      CouponManagement.TotCouponView();
 
  
  //gestione degli errori
  
  if (CouponManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (CouponManagement.getResult()==-2) {
    message=CouponManagement.getErrorMessage();
  }
%>
<html>
      <head>
    <title>Order List</title>
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/orderlist.css" type="text/css" media="all" />
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
         <form name="insertForm" action="coupon.jsp" method="post">
            <table border="0"> 
               <tr>
                 <td class="normal" width="100">UserID</td>
                 <td width="250">
                 <input type="text" name="cduser" size="20" maxlength="50"/>
                 </td>
               </tr>
               <tr>
                 <td class="normal" width="100">Importo</td>
                 <td width="250">
                 <input type="text" name="importo" size="20" maxlength="50"/>
                 </td>
               </tr>
               <tr>
                 <td class="normal" width="100">Data Inizio</td>
                 <td width="250">
                 <span>Inserisci data inizio validità coupon </span><input type="date" name="dinizio"/>
                 </td>
               </tr>
               <tr>
                 <td class="normal" width="100">Data fine</td>
                 <td width="250">
                 <span>Inserisci data fine validità coupon </span><input type="date" name="dfine"/>
                 </td>
               </tr>           
               <tr>
                 <td class="normal" width="100">&#160;</td>
                 <td width="250">
                 <input type="button" value="invia" onClick="insertcoupon()"/>
                 <input type="button" value="annulla" onClick="backForm.submit()"/>
                 </td>
               </tr>
            </table>
           <input type="hidden" name="status" value="insert"/>
           <input type="hidden" name="usato" value="0"/>
         </form>
         <form name="backForm" method="post" action="coupon.jsp">
            <input type="hidden" name="status" value="view"/>
         </form>
        <div class="clear"></div>   
         <table class="sortable resizable editable">
	      <thead>
	         <tr>
                     <th class="sortfirstdesc" id="urgency"><%=id%></th>
                     <th id="importo">Importo</th>
                     <th id="creation-date"><%=dateO%></th>
                     <th id="time"><%=datD%></th>
                     <th id="status">Status</th>
	      </thead>
	      <tfoot>
	         <tr>
                     <td><%=id%></td>
                     <th id="importo">Importo</th>
                     <td><%=dateO%></td>
                     <td><%=datD%></td>
                     <td>Status</td>
	      </tfoot>
	      <tbody>
               <% for(int i=0;i<CouponManagement.getCoupons().length;i++) { %>
		 <tr id="N938747839">
                    <td><div class="urg2"><%=CouponManagement.getCoupons(i).cduser%></div></td>
                    <td><%=CouponManagement.getCoupons(i).importo%></td>
                    <td><%=CouponManagement.getCoupons(i).data_inizio%></td>
                    <td><%=CouponManagement.getCoupons(i).data_fine%></td>
                    <td><%=CouponManagement.getCoupons(i).usato%></td>
                 </tr>
                 <%}%>
	 </table>      
  </div>
</div>
<%@include file="footer.jsp" %>


