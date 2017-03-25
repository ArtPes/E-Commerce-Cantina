<%@ page info="Home Page" %>
<%@ page contentType="text/html" %>
<%@ page session="false" %>
<%@ page buffer="30kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="services.sessionservice.*" %>


<jsp:useBean id="ProdottoManagement" scope="page" class="bflows.ProdottoManagement" />
<jsp:setProperty name="ProdottoManagement" property="*" />


<%! String lang = null;%>
<%
    if (request.getLocale().getLanguage().equals("it"))
        lang="ita";
    if (request.getLocale().getLanguage().equals("en"))
        lang="eng";
    if (request.getLocale().getLanguage().equals("fr"))
        lang="fra";
    if (request.getLocale().getLanguage().equals("es"))
        lang="spa"; 
//------------------------------------------------------------------------------------------------------------------------  
   Cookie[] cookies;
   cookies=request.getCookies();//carico tutti i cookie dell'utente
   ProdottoManagement.setCookies(cookies);

   boolean added = false;
   //controllo login   
  boolean loggedOn;   
  boolean loggVend=false; //da errore se non ha valore, false perchè qua non è ancora loggato l'utente
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
    
  String status;
  if (request.getParameter("status") == null)
     {status = "view";}
  else {status = request.getParameter("status");}
  
  if (status.equals("search"))
    {response.sendRedirect("search.jsp");}
   
    ProdottoManagement.ProdottoManagementView();
    
    
%>

<html>
  <head>
    <title>Magna Cantina</title> 
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script><!-- per le slide cantina/uva/vino...-->
<script type="text/javascript"  src="js/script.js"></script>  <!-- per le slide cantina/uva/vino...-->
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/slide.js"></script>  <!-- per menu tendina login/logout-->
<script type="text/javascript" src="js/nav.js"></script> <!-- per menu tendina --> 
<script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->

<!--panel -->
<%@include file="top_panel.jsp" %>
</head>
 <body> 

  <div class="wrap">
	<div class="header"> 
         <%@include file="top_header.jsp" %>
            <!--lista di tutti i prodotti che si visualizza nella barra principale-->
         <%@include file="menu.jsp" %>
          <div class="header_bottom">
		<div class="header_bottom_left">
			<div class="section group">
		            <% for(int i=0;i<2;i++) { %>
                                <form name="pid<%=i%>" method="post" action="details.jsp">     
                                 <div class="listview_1_of_2 images_1_of_2">			
                                    <div class="listimg listimg_2_of_1">
                                    <a href="javascript:dsubmit(<%=i%>);"><img src="images/<%=ProdottoManagement.getProdotti(i).path%>" alt="" border="0" /></a>
				    </div>
				    <div class="text list_2_of_1">
				     <a href="javascript:dsubmit(<%=i%>);"><%=ProdottoManagement.getProdotti(i).nome_p%></a>
                                     <p><%=ProdottoManagement.getProdotti(i).regione%></p>
                                     <input type="hidden" name="productCode" value="<%=ProdottoManagement.getProdotti(i).productCode%>"/>
			             <div class="button"><span><a href="javascript:dsubmit(<%=i%>);">Details</a></span></div>
				    </div>
			         </div>
                                </form>
                            <%}%>          
			</div>
			<div class="section group">
                            <%for(int b=2;b<4;b++) { %>
                                <form name="pid<%=b%>" method="post" action="details.jsp">
                                <div class="listview_1_of_2 images_1_of_2">			
				        <div class="listimg listimg_2_of_1">
                                            <a href="javascript:dsubmit(<%=b%>);"><img src="images/<%=ProdottoManagement.getProdotti(b).path%>" alt="" border="0" /></a>
					</div>
				        <div class="text list_2_of_1">
                                            <a href="javascript:dsubmit(<%=b%>);"><%=ProdottoManagement.getProdotti(b).nome_p%></a>
                                          <p><%=ProdottoManagement.getProdotti(b).regione%></p>
                                          <input type="hidden" name="productCode" value="<%=ProdottoManagement.getProdotti(b).productCode%>"/>
					<div class="button"><span><a href="javascript:dsubmit(<%=b%>);">Details</a></span></div>
				        </div>
			             </div>			
                                 </form>
                            <%}%>
			</div>
		  <div class="clear"></div>
		</div>
		<div class="header_bottom_right_images">
		   <div id="slideshow">
	             <ul class="slides">
                      <li><a href="cantina.jsp" ><img src="images/1.jpg" height="342" width="636"/></a></li>
                      <li><a href="vino_cibo.jsp"><img src="images/2.jpg" height="342" width="636" /></a></li>
                      <li><a href="uva.jsp"><img src="images/3.jpg" height="342" width="636"/></a></li>
                     </ul>
		    <span class="arrow previous"></span>
		    <span class="arrow next"></span>
		   </div>
	        </div>
	       <div class="clear"></div>
        </div>	
       </div>
 <div class="main">
    <div class="content">
              <% if (lang!=null){%>
    		<div class="heading"> 
    		<%if (lang.equals("ita")) {%> <h3>Nuovi Prodotti</h3><%}%>
                <%if (lang.equals("eng")) {%> <h3>New Products</h3><%}%>
                <%if (lang.equals("fra")) {%> <h3>Nouveaux Produits</h3><%}%>
                <%if (lang.equals("spa")) {%> <h3>Nuevos Productos</h3><%}%>
    		<%} else %> <h3>New Products</h3>
                </div> 
	      <div class="section group">
                  <!-- session group -->
		        <% for(int c=4;c<8;c++) { %>
                            <form name="pid<%=c%>" method="post" action="details.jsp">
                                <div class="grid_1_of_4 images_1_of_4">					
                                     <div class="listimg listimg_2_of_1">
                                     <a href="javascript:dsubmit(<%=c%>);"><img src="images/<%=ProdottoManagement.getProdottiNew(c).path%>" alt="" border="0"/></a>									        
                                     </div>
                                     <div class="text list_2_of_1">
                                     <p><a href="javascript:dsubmit(<%=c%>);"><%=ProdottoManagement.getProdottiNew(c).nome_p%></a></p>
                                     </div>
			             <div class="button"><span><img src="images/cart.jpg" alt="" /><a href="javascript:dsubmit(<%=c%>);" class="cart-button">Add to Cart</a></span> </div>
                                     <div class="button"><span><a href="javascript:dsubmit(<%=c%>);" class="details">Details</a></span></div>
                                     <input type="hidden" name="productCode" value="<%=ProdottoManagement.getProdottiNew(c).productCode%>"/>				        
				</div>
			    </form> 
                        <%}%> <!--fine form prootti in basso -->
	       </div>
    </div>
 </div>
</div>   
<%@include file="footer.jsp" %>
