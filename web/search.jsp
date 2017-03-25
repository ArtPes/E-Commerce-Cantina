
<%@ page info="Cerca prodotto" %>
<%@ page contentType="text/html" %>
<%@ page session="false" %>
<%@ page buffer="30kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="services.sessionservice.*" %>

<jsp:useBean id="ProdottoManagement" scope="page" class="bflows.ProdottoManagement" />
<jsp:setProperty name="ProdottoManagement" property="*" />


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
  String status;
  
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

  
   boolean added = false;
   cookies = request.getCookies();
 
   String prezzo=null;   
   String qta=null;
   String nop=null;
  
  if(lang!=null){
  if (lang.equals("ita"))
     {prezzo="Prezzo";     
      qta="Quantità";
      nop="Nessun prodotto trovato";}
  if (lang.equals("eng"))
     {prezzo="Price";
      qta="Quantity";
      nop="No products found";}
  if (lang.equals("fra"))
     {prezzo="Prix";
      qta="Quantitè";
      nop="Aucun produit trouvé";}
  if (lang.equals("spa"))
     {prezzo="Precio";
      qta="Cantidad";
      nop="No hay productos encontrados";}
  }  

if (request.getParameter("search") == "")  //redirect ad home con search vuoto
      {response.sendRedirect("home.jsp");}  

 else {
      ProdottoManagement.ProdottoManagementView(); 
      } 
     

 if (ProdottoManagement.getResult()== -1) {
         throw new Exception("Errore nell'applicazione: consultare i logs");
     } else if (ProdottoManagement.getResult() == -2) {
         message = ProdottoManagement.getErrorMessage();
         /*se result = -2 l'errore è un recoverableerror
         quindi mantengo la connessione
         */
         status = "view";
         response.sendRedirect("home.jsp");
     }
     
%>

<html>

  <head>
    <title>Cantina Magna</title> 
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script type="text/javascript"  src="js/script.js"></script>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/slide.js"></script>
<script type="text/javascript" src="js/nav.js"></script>
<script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->   
<!-- ELEVATOR--> <!-- JS -->
<script src='js/elevator.js'></script>
<%@ include file="top_panel.jsp" %>
<!---alert-->
 <%if (message!=null) {%>
      <script>alert("<%=message%>");</script>
    <%}%>
</head>
<body>
  <div class="wrap">
	<div class="header">
	  <%@ include file="top_header.jsp" %>
          <%@include file="menu.jsp"%>
        </div>
	<div class="main">
         <div class="content">	
             <%if (ProdottoManagement.getProdotti().length==0) {%>
             <p><%=nop%></p>
             <%}%>     
    	        <div class="section group">
                     <% for(int i=0;i<ProdottoManagement.getProdotti().length;i++) {%>     
                     <form name="pid<%=i%>" method="post" action="details.jsp">
                       <div class="section group">
				<div class="cont-desc span_1_of_2">				
			         <div class="grid images_3_of_2">
                                  <a href="javascript:dsubmit(<%=i%>);"><img src="images/<%=ProdottoManagement.getProdotti(i).path%>" width="100" height="100" /></a>
				 </div>
				 <div class="desc span_3_of_2">
				   <a href="javascript:dsubmit(<%=i%>);"><h2><%=ProdottoManagement.getProdotti(i).nome_p%></h2></a>
				   <p><%=ProdottoManagement.getProdotti(i).regione%></p>					
				   <div class="price">
				     <p><%=qta%>: <span><%=ProdottoManagement.getProdotti(i).quantita%></span>
                                     |<%=prezzo%>: <span><%=ProdottoManagement.getProdotti(i).prezzo%> &#8364</span></p>
				   </div> 	                        
                                 </div>
 	                        </div>
                             <input type="hidden" name="productCode" value="<%=ProdottoManagement.getProdotti(i).productCode%>"/>	
                       </div>
                     </form><%}%>                              
	        </div>
         </div>
<div class="footerElv">
    <div class="do-the-thing">
      <div class="elevator">
          <img src="images/arrow_top.png" height="50">
          Back to Top
      </div>
    </div>
</div>
<script>//script per elevator!!
// Simple elevator usage.
          var elementButton = document.querySelector('.elevator');
            var elevator = new Elevator({
                element: elementButton,
                mainAudio: './music/elevator-music.mp3', //la musica è stata tolta
                endAudio:  './music/ding.mp3'
            });
</script>
</div>
 <%@include file="footer.jsp" %>
