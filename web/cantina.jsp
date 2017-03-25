<%--
    Document   : cantina
    Created on : 2-gen-2015, 15.17.15
    Author     : arturo e riki
--%>
<%@ page info="Cantina" %>
<%@ page contentType="text/html" %>
<%@ page session="false" %>
<%@ page buffer="30kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="services.sessionservice.*" %>

<%! String lang=null;%>
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
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script type="text/javascript"  src="js/script.js"></script>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/slide.js"></script>
<script type="text/javascript" src="js/nav.js"></script>
  
<script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->
  
<%@ include file="top_panel.jsp" %>
 <!--panel -->
</head>
<body>
  <div class="wrap">
	<div class="header">
           <%@include file="top_header.jsp" %>
           <!--lista di tutti i prodotti che si visualizza nella barra principale-->
           <%@include file="menu.jsp" %>
	    <div class="main">
               <div class="content">
    	           <div class="content_top">
    		      <div class="back-links">
    		        <p><a href="home.jsp">Home</a> >> <a href="#">Vino e cibo</a></p>
    	              </div>
    		      <div class="clear"></div>
    	            </div>
    	              <div class="section group">
			 <div class="cont-desc span_1_of_2">				
			    <div class="grid images_3_of_2">
		              <img src="images/1.jpg" alt=""/>
		            </div>
				<div class="desc span_3_of_2">
                                    <% if (lang!=null){%>
                                      <%if (lang.equals("ita")) {%>
					<h2>Cantina ideale</h2>
					<p>Non tutti dispongono di un locale sotterraneo da adibire a cantina.
                                            In questi casi possiamo ricorrere ad un ripostiglio adeguatamente 
                                            sistemato perchè le condizioni abituali delle abitazioni possono 
                                            accelerare i processi di invecchiamento del vino. La prima regola
                                            è quella di avvicinarsi il più possibile alle condizioni della cantina ideale:
                                            temperatura intorno ai 15 gradi, buio e silenzio. Si consiglia di isolare
                                            le pareti o almeno di mettere le bottiglie in contenitori di polistirolo,
                                            in alternativa potete utilizzare anche una vecchia "libreria" in legno
                                            (naturalmente la soluzione migliore sarebbe quella di un condizionatore
                                            che mantenga temperatura ed umidità sotto controllo). Altra regola da non
                                            sottovalutare è quella di eliminare tutte le cose che producono odori forti,
                                            dalle vernici ai salumi a causa della capacità del vino di assorbirli.
                                            Nel posizionare le bottiglie facciamo attenzione a disporle in basso,
                                            vicino al pavimento.
                                        </p>					
                                    <%}%>
				    <%if (lang.equals("eng")) {%>
                                      	<h2>Ideal Cantina</h2>
					<p>Not everyone has a basement suitable for use in the cellar.
                                            In these cases, we can resort to a storeroom adequately
                                            arranged because the usual conditions of housing can
                                            accelerate the aging process of wine. The first rule
                                            is to get as close as possible to the ideal conditions of the cellar:
                                            temperature around 15 degrees, dark and silent. Insulate
                                            the walls or at least put the bottles in polystyrene containers,
                                            alternatively you can also use an old "library" of wood
                                            (Of course the best solution would be an air conditioner
                                            that maintains temperature and humidity control). Another rule to not
                                            underestimate is to eliminate all the things that produce strong odors,
                                            from paints to meats due to the ability of the wine to absorb them.
                                            In place the bottles we are careful to place them at the bottom,
                                            close to the floor.
                                        </p>					
                                    <%}%>
                                    <%if (lang.equals("fra")) {%>
                                      	<h2>Idéal Cave</h2>
					<p>Pas tout le monde a un sous-sol adapté pour une utilisation dans la cave.
                                            Dans ces cas, nous pouvons recourir à un cellier adéquate
                                            arrangé parce que les conditions habituelles de logement peut
                                            accélérer le processus de vieillissement du vin. La première règle
                                            est de se rapprocher le plus possible des conditions idéales de la cave:
                                            température autour de 15 degrés, sombres et silencieux. Isoler
                                            les murs ou au moins mettre les bouteilles dans des contenants de polystyrène,
                                            Sinon, vous pouvez également utiliser un vieux «bibliothèque» de bois
                                            (Bien sûr, la meilleure solution serait un climatiseur
                                            qui maintient la température et de l'humidité). Une autre règle de ne pas
                                            sous-estimer est d'éliminer toutes les choses qui produisent des odeurs fortes,
                                            des peintures à viandes en raison de la capacité du vin à les absorber.
                                            En lieu et place les bouteilles nous prenons soin de les placer au fond,
                                            près du sol.
                                        </p>					
                                    <%}%>
                                    <%if (lang.equals("spa")) {%>
                                      <h2>Bodega Ideales</h2>
					<p>No todo el mundo tiene un sótano adecuado para su uso en el sótano.
                                            En estos casos, podemos recurrir a un trastero adecuadamente
                                            arreglado porque las condiciones habituales de la vivienda puede
                                            acelerar el proceso de envejecimiento del vino. La primera regla
                                            es llegar lo más cerca posible de las condiciones ideales de la bodega:
                                            temperatura alrededor de 15 grados, oscuros y silenciosos. Aislar
                                            las paredes o al menos poner las botellas en los contenedores de poliestireno,
                                            alternativamente, también puede utilizar un viejo "biblioteca" de madera
                                            (Por supuesto, la mejor solución sería un acondicionador de aire
                                            que mantiene la temperatura y de la humedad). Otra regla que no
                                            subestimar es la eliminación de todas las cosas que producen olores fuertes,
                                            de las pinturas a las carnes debido a la capacidad del vino de absorberlos.
                                            En lugar de las botellas que tienen el cuidado de colocarlos en la parte inferior,
                                            cerca del suelo.
                                        </p>					
                                    <%}%>
                                    <%} else {%>
                                        <h2>Ideal Cantina</h2>
					<p>Not everyone has a basement suitable for use in the cellar.
                                            In these cases, we can resort to a storeroom adequately
                                            arranged because the usual conditions of housing can
                                            accelerate the aging process of wine. The first rule
                                            is to get as close as possible to the ideal conditions of the cellar:
                                            temperature around 15 degrees, dark and silent. Insulate
                                            the walls or at least put the bottles in polystyrene containers,
                                            alternatively you can also use an old "library" of wood
                                            (Of course the best solution would be an air conditioner
                                            that maintains temperature and humidity control). Another rule to not
                                            underestimate is to eliminate all the things that produce strong odors,
                                            from paints to meats due to the ability of the wine to absorb them.
                                            In place the bottles we are careful to place them at the bottom,
                                            close to the floor.
                                        </p><%}%>
					<div class="share">
				          <p>Share:</p>
					    <ul>
					      <li><a href="#" class="hvr-buzz"><img src="images/youtube.png" alt=""></a></li>
					      <li><a href="#" class="hvr-buzz"><img src="images/facebook.png" alt=""></a></li>
					      <li><a href="#" class="hvr-buzz"><img src="images/twitter.png" alt=""></a></li>
			    		    </ul>
					</div>
			        </div>		
	                </div>
                    <%@ include file="categorie.jsp" %>
                </div>
            </div>
        </div>
    </div>   
</div>
<%@include file="footer.jsp" %>
