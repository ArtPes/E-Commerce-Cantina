
<%@ page contentType="text/html" %>
<%@ page session="false" %>
<%@ page buffer="30kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="services.sessionservice.*" %>

<jsp:useBean id="ProdottoManagement" scope="page" class="bflows.ProdottoManagement" />
<jsp:setProperty name="ProdottoManagement" property="*" />

<%! String lang = null;%>
<%
       // Cookie[] cookies;
       //imposto la lingua controllando dalla request quella del browser
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
    
  ProdottoManagement.setCookies(cookies);
  
  String quantita=null;
  String cart;
   
  //controllo login   
  boolean loggedOn;   
  boolean loggVend=false; 
  boolean loggAdmin=false;
 if (Session.getCduser(cookies) != null) {
     loggedOn = true;
     //imposto la lingua dell'user
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
  String offerte=null;
  
  if(lang!=null){
  if (lang.equals("ita"))
     {prezzo="Prezzo";
      qta="Quantità";
     offerte="Offerte";}
  if (lang.equals("eng"))
     {prezzo="Price";
     qta="Quantity";
     offerte="Offers";}
  if (lang.equals("fra"))
     {prezzo="Prix";
     qta="Quantitè";
     offerte="Offres";}
  if (lang.equals("spa"))
     {prezzo="Precio";
     qta="Cantidad";
     offerte="Ofertas";}
  }
 
String status;
if (request.getParameter("status") == null) {
    status = "view";
} else {
      status = request.getParameter("status");
}

    ProdottoManagement.ProdottoManagementView();//vedere vini in banner
    ProdottoManagement.ProdottoDetailsView();//vedere i dettagli(nme,regione,prezzo,qta) di un determinato prodotto
    ProdottoManagement.ProdottoDetails();//vedere la descrizione nella lingua dell'utente
  
 
if (loggedOn) 
    ProdottoManagement.setCookies(cookies);

/*l'aggiunta dei prodotti al carrello è possibile solo se si è loggati e compratore
 if (loggedOn==true && loggVend==false && loggAdmin==false) {
    
     if (request.getParameter("cart") != null)
     {
        cart = request.getParameter("cart");
        if (cart.equals("add")) {
        ProdottoManagement.AddCart();
        added = true;
        for (int i=0; i<ProdottoManagement.getCookies().length;i++)
        response.addCookie(ProdottoManagement.getCookies(i));
       
        } 
     }ProdottoManagement.UserViewProduct();//inserire il prodotto visto nella tabella "visuallizza"
 }*/
   
String message = null;
 if (ProdottoManagement.getResult()== -1) {
         throw new Exception("Errore nell'applicazion: consultare i logs");
     } else if (ProdottoManagement.getResult() == -2) {
         message = ProdottoManagement.getErrorMessage();
         /*se result = -2 l'errore è un recoverableerror
         quindi mantengo la connessione
         */
         status = "view";
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
<%@ include file="top_panel.jsp" %>
 <!--panel -->
 <%if (message!=null) {%>
      <script>alert("<%=message%>");</script>
    <%}%>
    
</head>
<body>
  <div class="wrap">
	<div class="header">
	<%@ include file="top_header.jsp" %>
            <!--lista di tutti i prodotti che si visualizza nella barra principale-->
        <%@include file="menu.jsp"%>
        </div>
	 <div class="main">
             <div class="content">
    	        <div class="section group">
				<div class="cont-desc span_1_of_2">				
					<div class="grid images_3_of_2">
					<img src="images/<%=ProdottoManagement.getProdotto().path%>" alt="" />
					</div>
				<div class="desc span_3_of_2">
					<h2><%=ProdottoManagement.getProdotto().nome_p%></h2>
					<p><%=ProdottoManagement.getProdotto().regione%></p>					
					<div class="price">
						<p><%=qta%>: <span><%=ProdottoManagement.getProdotto().quantita%></span></p>
                                                <p><%=prezzo%>: <span><%=ProdottoManagement.getProdotto().prezzo%> &#8364</span></p>
					</div>
					<div class="share">
					    <p>Share Product :</p>
					    <ul>
					    	<li><a href="#" class="hvr-buzz"><img src="images/youtube.png" alt=""></a></li>
					    	<li><a href="#" class="hvr-buzz"><img src="images/facebook.png" alt=""></a></li>
					    	<li><a href="#" class="hvr-buzz"><img src="images/twitter.png" alt=""></a></li>
			    		    </ul>
					</div>
                                <% if(loggedOn==false){%>    <!--SE NON E' LOGGATO REINDIRIZZA AL LOGIN-->  
                                   <div class="add-cart">
                                     <div class="button"><a href="login.jsp" class="hvr-wobble-to-top-right">Add to Cart</a></div>
			             <div class="clear"></div>
				</div>       
				<div class="add-cart">
                                     <div class="button"><a href="login.jsp" class="hvr-wobble-bottom">Add to Wishlist</a></div>
			             <div class="clear"></div>
				</div><%}%>                                          
                               <!--lascio il controllo login per evitare errori-->  
                               <% if(loggedOn==true && loggVend==false && loggAdmin==false){%>
                                <div class="add-cart">
                                     <form name="cart" method="post" action="cart.jsp">
                                       <div class="button"><a href="javascript:document.cart.submit();" class="hvr-wobble-to-top-right">Add to Cart</a></div>
                                       
                                       <tr>
                                       <td class="normal" width="10"><%=qta%></td>
                                         <td width="25"><input type="text" name="qta" size="3" maxlength="50" value="1"/></td>
                                       </tr>
                                       <input type="hidden" name="productCode" value="<%=ProdottoManagement.getProdotto().productCode%>"/>
                                       <input type="hidden" name="userCode" value="<%=Session.getCduser(cookies)%>"/>
                                       <input type="hidden" name="status" value="add"/>
                                     </form>
			             <div class="clear"></div>
				</div>        
				<div class="add-cart">
                                     <form name="awl" method="post" action="wishlist.jsp">
                                       <div class="button"><a href="javascript:document.awl.submit();" class="hvr-wobble-bottom">Add to Wishlist</a></div>
                                       <input type="hidden" name="productCode" value="<%=ProdottoManagement.getProdotto().productCode%>"/>
                                       <input type="hidden" name="status" value="add"/>
                                     </form>
			             <div class="clear"></div>
				</div>
                                   <%}%>
			</div>
			<div class="product-desc">
		         <% if (lang!=null){%>
                          <%if (lang.equals("ita")) {%><h2>Dettagli del Prodotto</h2><%}%>
                          <%if (lang.equals("eng")) {%> <h2>Product Details</h2><%}%>
                          <%if (lang.equals("fra")) {%> <h2>Les détails du Produit</h2><%}%>
                          <%if (lang.equals("spa")) {%> <h2>Detalles del Producto</h2><%}%>
                          <%} else %> <h2>Product Details</h2>
                      
                        <%=ProdottoManagement.getDettagli().adettagli%>
	                </div>				
	             </div>
   <%@ include file="categorie.jsp" %>
                       <% if(Session.getCduser(cookies)!=null && Session.getTipo(cookies).equals("C")){ %>
                       <!-- solo se l'utente è loggato si vedono i consigliati-->
                           <form name="forms" method="post" action="details.jsp">
                            <div class="rightsidebar span_3_of_1">
				<h2><%=offerte%></h2>
                                <input type="image" src="images/<%=ProdottoManagement.getProductsuv().path%>" height="150">
                                 <p><%=ProdottoManagement.getProductsuv().nome_p%></p>
				 <p><%=ProdottoManagement.getProductsuv().regione%></p>					
			         <div class="price">
                                    <p><%=prezzo%>: <span><%=ProdottoManagement.getProductsuv().prezzo%> Euro</span></p>
			         </div>             
                                 <input type="hidden" value="<%=ProdottoManagement.getProductsuv().productCode%>" name="productCode">
 		            </div>
                           </form>
                       <%}%>
 	</div>
     </div>
  </div>
</div>
<%@include file="footer.jsp" %>
