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
  
  Double totale=null;
  Double a= Double.valueOf(request.getParameter("impordine"));
  Double b=0.0;
  
     if (Double.valueOf(request.getParameter("coupon"))!=null)
        b= Double.valueOf(request.getParameter("coupon"));
    
  totale=a-b; 
    
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
  
  if(lang!=null){
  if (lang.equals("ita"))
     {tot="Totale";
      id="ID Ordine";
 
      }
  if (lang.equals("eng"))
     {tot="Price";
      id="order's ID";
     }
  if (lang.equals("fra"))
     {tot="Total";
      id="ID Ordre";
     }
  if (lang.equals("spa"))
     {tot="Total";
      id="ID Orden";
     }
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
<script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI,GRANDE ARTI -->
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
        <form name="pagamento" action="pagamentoOK.jsp" method="post">
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
                                           <img src="images/<%=request.getParameter("carta")%>.png" alt="" height="30" />
                                        </p>
                                        <p>Inserire Nome intestatario carta:
                                            <input readonly="readonly" type="text" value="<%=request.getParameter("nome")%>" name="name" size="20" maxlength="50"/>
                                        </p>
                                        <p>Inserire surname intestatario carta:
                                            <input readonly="readonly" type="text" value="<%=request.getParameter("cogn")%>" name="cogn" size="20" maxlength="50"/>
                                        </p>
                                        <p>Inserire CVV:
                                            <input readonly="readonly" type="text" value="<%=request.getParameter("cvv")%>" name="cvv" size="20" maxlength="50"/>
                                        </p>
                                        <p>Scegliere tipo spedizione:<br>
                                          <%=request.getParameter("posta")%>
                                        </p>
                                        <p>Scelto il coupon da usare: <%=request.getParameter("coupon")%> &#8364 <br>
                                        <p><%=tot%>: <%=totale%> &#8364</p> 
                                        <div class="clear"></div>   
                                        <div class="button1"><a href="javascript:document.pagamento.submit();">Conferma</a></div>
                                        
					</div>
			        </div>				
	                </div>							
 	        </div>
          <input type="hidden" name="idordine" value="<%=request.getParameter("idordine")%>">                               
          <input type="hidden" name="impordine" value="<%=totale%>">
          <input type="hidden" name="status" value="pagato">  
        </form>
    <form name="remove" action="checkordine.jsp" method="post">
     <tr>
       <td class="normal" width="100">&#160;</td>
       <td width="250">  
        <input type="button" name="impordine" value="annulla" onClick="removeordine()"/>
        <input type="hidden" name="status" value="remove"/>
        <input type="hidden" name="totcart" value="<%=request.getParameter("idcoupon")%>"/>
       </td>
     </tr>
    </form>                                    
  </div>
</div>
<%@include file="footer.jsp" %>