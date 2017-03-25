<%-- 
    Document   : uva
    Created on : 2-gen-2015, 15.17.54
    Author     : arturo e riki
--%>

<%@ page info="Contacts" %>
<%@ page contentType="text/html" %>
<%@ page session="false" %>
<%@ page buffer="30kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="services.sessionservice.*" %>




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
%>

<html>

  <head>
    <title>Cantina Magna</title>
    <meta name="14" content="11"/> 
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script type="text/javascript"  src="js/script.js"></script>
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/slide.js"></script>
<script type="text/javascript" src="js/nav.js"></script>
<script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->
<%@ include file="top_panel.jsp" %>
  </head>

<body>
  <div class="wrap">
	<div class="header">
      <%@ include file="top_header.jsp"%>
            <!--lista di tutti i prodotti che si visualizza nella barra principale-->
      <%@include file="menu.jsp" %>
   <div class="main">
    <div class="content">
    	<div class="content_top">
    		<div class="back-links">
    		<p><a href="home.jsp">Home</a> >> <a href="#">Contact us</a></p>
    	    </div>
    		<div class="clear"></div>
    	</div>
    	<div class="section group">
				<div class="cont-desc span_1_of_2">				
			          <div class="grid images_3_of_2">
			            <img src="images/contact.png" alt="" />
				  </div>
				  <div class="desc span_3_of_2">
				  Admin: 
                                  <br><h2> Arturo Pesaro</h2> 
                                  pesaro@pesaro.ve
                                  <br><h2> Riccardo Galvani</h2> 
                                  galvani@gmail.uk
			          </div>		
	                        </div>
   <%@ include file="categorie.jsp" %>
 	</div>
    </div>
  </div>
</div>
</div>
 <%@include file="footer.jsp" %>
