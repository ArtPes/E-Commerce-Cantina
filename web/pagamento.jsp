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
     String id=null;
     String invia=null;
  
  if(lang!=null){
  if (lang.equals("ita"))
     {tot="Totale";
      id="ID Ordine";
      invia="Invia";
      }
  if (lang.equals("eng"))
     {tot="Price";
      id="Order's ID";
      invia="Send";
     }
  if (lang.equals("fra"))
     {tot="Total";
      id="ID Ordre";
      invia="Envoyer";
     }
  if (lang.equals("spa"))
     {tot="Total";
      id="ID Orden";
      invia="Enviar";
     }
  }
 
    CouponManagement.setCookies(cookies);
    CouponManagement.CouponView();
        
  //gestione degli errori
  
    if (CouponManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (CouponManagement.getResult()==-2) {
    message=CouponManagement.getErrorMessage();
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
         <form name="pagamento" action="checkpagamento.jsp" method="post">
                <div class="section group">
		        <div class="cont-desc span_1_of_2">				
					<div class="grid images_3_of_2">
					<img src="images/money.png" alt="" />
					</div>
				<div class="desc span_3_of_2">
					<h2>Pagamento: <%=id%> <%=request.getParameter("idordine")%> </h2>
					<p><%=tot%>: <%=request.getParameter("impordine")%> &#8364 </p>					
					<div class="price">
                                        <p>Metodo Pagamento:<br>
                                          <input type="radio" name="carta" value="visa" ><img src="images/visa.png" alt="" height="30"/>
                                          <input type="radio" name="carta" value="master"><img src="images/master.png" alt="" height="30"/>
                                          <input type="radio" name="carta" value="aura"><img src="images/aura.png" alt="" height="40"/>
                                          <input type="radio" name="carta" value="poste"><img src="images/poste.png" alt="" height="30"/>
                                          <input type="radio" name="carta" value="american"><img src="images/american.jpg" alt="" height="30"/>
                                        </p>
                                        <p>Inserire Nome intestatario carta:
                                            <input type="text" name="nome"  size="20" maxlength="50"/>
                                        </p>
                                        <p>Inserire surname intestatario carta:
                                            <input type="text" name="cogn"  size="20" maxlength="50"/>
                                        </p>
                                        <p>Inserire CVV:
                                            <input type="text" name="cvv"  size="20" maxlength="50"/>   
                                        </p>
                                        <p>Scegliere tipo spedizione:<br>
                                          <input type="radio" name="posta" value="Prioritaria">Posta Prioritaria<br>
                                          <input type="radio" name="posta" value="Raccomandata">Posta Raccomandata<br>
                                          <input type="radio" name="posta" value="Assicurata">Posta Assicurata<br>
                                          <input type="radio" name="posta" value="Ordinario">Pacco Ordinario<br>
                                        </p>
                                        <p>Scegli il coupon da usare:<br>
                                            <input type="radio" name="coupon" checked="checked" value="0"/> 0 &#8364
                                            <%for(int i=0;i<CouponManagement.getCoupons().length;i++){%>
                                            <input type="radio" name="coupon" value="<%=CouponManagement.getCoupons(i).importo%>"/><%=CouponManagement.getCoupons(i).importo%> &#8364
                                            <input type="hidden" name="idcoupon" value="<%=CouponManagement.getCoupons(i).id%>"/>
                                            <%}%>
                                            <%if (CouponManagement.getCoupons().length == 0){%><!--VALORI A 0 IN ASSENZA DI COUPON PER EVITARE NULL-->
                                            <input type="hidden" name="idcoupon" value="0"/>
                                            <input type="hidden" name="coupon" value="0"/>
                                            <p>Nessun coupon utilizzabile<br><p>
                                            <%}%>   
                                        <div class="clear"></div>
                                        <input type="button" value="<%=invia%>" onClick="insertpagamento()"/>
                                        <input type="reset"  value="Annulla" onClick="removeordine()"/>
					</div>
			        </div>				
	                </div>							
 	        </div>
            <input type="hidden" name="idordine" value="<%=request.getParameter("idordine")%>"/>
            <input type="hidden" name="impordine" value="<%=request.getParameter("impordine")%>"/>    
            <input type="hidden" name="status" value="ok">                               
        </form>
     </div>
</div>
<%@include file="footer.jsp" %>
