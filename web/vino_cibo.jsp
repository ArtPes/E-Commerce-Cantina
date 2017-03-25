<%-- 
    Document   : vino_cibo
    Created on : 2-gen-2015, 15.17.37
    Author     : arturo e riki
--%>
<%@ page info="Vino_Cibo" %>
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
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script type="text/javascript"  src="js/script.js"></script>
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/slide.js"></script>
<script type="text/javascript" src="js/nav.js"></script>
<script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->
<%@ include file="top_panel.jsp" %><!--panel -->
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
			 <img src="images/2.jpg" alt=""/>
		      </div>
				<div class="desc span_3_of_2">
                                      <% if (lang!=null){%>
                                      <%if (lang.equals("ita")) {%>
					<h2>Vino e Cibo</h2>
					<p>Ogni piatto ha il suo vino ideale di accompagnamento che va servito alla temperatura corretta.
                                            Occorre considerare le varie tipologie di vino, rosso e bianco, spumante, liquore, passito,
                                            bianco vivace, rosso di struttura, rosato, bianco morbido, aromatico, rosso di buon corpo,
                                            ognuna con il suo livello di invecchiamento ed importanza, per poter offrire un buon abbinamento
                                            cibo e vino in un menù. Gli abbinamenti tra vini e cibi sono numerosi e vari. Gli accordi devono 
                                            stabilirsi fra gli odori e i sapori del vino e del piatto gustato. Mai come oggi la considerazione
                                            degli alimenti è sempre più alta sulla scena mondiale. Ogni pretesto è buono per parlare di cibo e
                                            di vino, se si considera tutti i tipi e le mode di cucine che nascono ogni giorno: nouvelle cuisine,
                                            cucina tradizionale, cucina reinventata, fusion gastronomica, cucina finger food, cucina etnica...e via dicendo.
                                            Per l'importanza data oggi alla cucina è inevitabile riuscire ad accostare il vino giusto al cibo servito in tavola.
                                            Aldilà del gusto che è sempre strettamente personale, esistono delle considerazioni di base da valutare nella
                                            scelta di un vino da abbinare ad un alimento.
                                        </p>					
                                      <%}%>
				      <%if (lang.equals("eng")) {%>
                                      	<h2>Wine and Food</h2>
					<p>Each dish has its ideal wine to accompany it should be served at the correct temperature.
                                            Must consider the various types of wine, red and white, champagne, liquor, sweet,
                                            White lively, structured red, pink, white soft, aromatic, full-bodied red,
                                            each with its own level of aging and importance, in order to offer a good combination
                                            food and wine in a menu. The combinations between wines and foods are numerous and varied. Agreements must
                                            established between the smells and flavors of the wine and the dish tasted. Never before has the consideration
                                            food is increasingly high on the world stage. Any excuse is good to talk about food and
                                            of wine, if you consider all types of cuisines and fashions that are born every day: nouvelle cuisine,
                                            traditional cuisine, kitchen reinvented, Fusion gastronomic cuisine finger food, ethnic food ... and so on.
                                            For the importance given today to the kitchen is inevitable to be able to pull the right wine to the food served on the table.
                                            Beyond the taste that is always personal, there are some basic considerations to be evaluated in
                                            Choosing a wine to pair with food.
                                        </p>					
                                      <%}%>
                                      <%if (lang.equals("fra")) {%>
                                      	<h2>Vin et la Nourriture</h2>
					<p>Chaque plat a son vin idéal pour accompagner il devrait être servi à la bonne température.
                                            Doit tenir compte des différents types de vin, rouge et blanc, champagne, liqueur, doux,
                                            Animé blanc, structuré rouge, rose, blanc et doux, aromatique, rouge corsé,
                                            chacun avec son propre niveau de vieillissement et de l'importance, afin d'offrir une bonne combinaison
                                            nourriture et le vin dans un menu. Les combinaisons entre les vins et les aliments sont nombreux et variés. Les accords doivent
                                            établi entre les odeurs et les saveurs du vin et le plat goûté. Jamais avant l'examen
                                            alimentaire est de plus en plus haut sur la scène mondiale. Toute excuse est bonne pour parler de nourriture et
                                            de vin, si vous considérez tous les types de cuisines et des modes qui naissent chaque jour: la nouvelle cuisine,
                                            cuisine traditionnelle, cuisine réinventée, Fusion cuisine gastronomique finger food, aliments ethniques ... et ainsi de suite.
                                            Pour l'importance accordée aujourd'hui à la cuisine est inévitable d'être en mesure de tirer le bon vin à la nourriture servie sur la table.
                                            Au-delà du goût qui est toujours personnelle, il ya quelques considérations de base pour être évalués dans
                                            Choisir un vin à jumeler avec de la nourriture.
                                        </p>					
                                      <%}%>
                                      <%if (lang.equals("spa")) {%>
                                      <h2>Vino y Comida</h2>
					<p>Cada plato tiene su vino ideal para acompañar debería ser servido a la temperatura correcta.
                                            Debe tener en cuenta los diferentes tipos de vinos, rojo y blanco, champán, licores, dulces,
                                            Vivo blanco, estructurado rojo, rosa, blanco suave, aromático, con cuerpo de color rojo,
                                            cada uno con su propio nivel de envejecimiento y la importancia, con el fin de ofrecer una buena combinación
                                            comida y vino en un menú. Las combinaciones entre vinos y alimentos son numerosos y variados. Los acuerdos deben
                                            que se establece entre los olores y sabores del vino y el plato probado. Nunca antes la consideración
                                            la comida es cada vez más alto en el escenario mundial. Cualquier excusa es buena para hablar de comida y
                                            de vino, si se tiene en cuenta todos los tipos de cocina y modas que nacen todos los días: la nueva cocina,
                                            cocina tradicional, cocina reinventó, Fusión cocina gastronómica finger food, comida étnica ... y así sucesivamente.
                                            Por la importancia que se da hoy a la cocina es inevitable para poder sacar el mejor vino para la comida que se sirve en la mesa.
                                            Más allá del sabor que es siempre personal, hay algunas consideraciones básicas para ser evaluados en
                                            La elección de un vino para acompañar la comida.
                                        </p>					
                                      <%}%>
                                      <%} else {%>
                                        <h2>Wine and Food</h2>
					<p>Each dish has its ideal wine to accompany it should be served at the correct temperature.
                                            Must consider the various types of wine, red and white, champagne, liquor, sweet,
                                            White lively, structured red, pink, white soft, aromatic, full-bodied red,
                                            each with its own level of aging and importance, in order to offer a good combination
                                            food and wine in a menu. The combinations between wines and foods are numerous and varied. Agreements must
                                            established between the smells and flavors of the wine and the dish tasted. Never before has the consideration
                                            food is increasingly high on the world stage. Any excuse is good to talk about food and
                                            of wine, if you consider all types of cuisines and fashions that are born every day: nouvelle cuisine,
                                            traditional cuisine, kitchen reinvented, Fusion gastronomic cuisine finger food, ethnic food ... and so on.
                                            For the importance given today to the kitchen is inevitable to be able to pull the right wine to the food served on the table.
                                            Beyond the taste that is always personal, there are some basic considerations to be evaluated in
                                            Choosing a wine to pair with food.
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
