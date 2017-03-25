<%-- 
    Document   : uva
    Created on : 2-gen-2015, 15.17.54
    Author     : arturo e riki
--%>

<%@ page info="Uva" %>
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
  boolean loggVend=false; //da errore se non ha valore, false perch� qua non � ancora loggato l'utente
  boolean loggAdmin=false;
 if (Session.getCduser(cookies) != null) {
     loggedOn = true;
          lang=Session.getLingua(cookies);
     //per vedere se l'utente loggato � un venditore o compratore
     String tipo;
     tipo=Session.getTipo(cookies);
     

      if(Session.getTipo(cookies).equals(""))//se usertype � null � un' amministratore
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
    	      <p><a href="home.jsp">Home</a> >> <a href="#">Vino e cibo</a></p>
    	    </div>
    	   <div class="clear"></div>
    	</div>
    	<div class="section group">
		<div class="cont-desc span_1_of_2">				
		     <div class="grid images_3_of_2">
			<img src="images/3.jpg" alt="" />
		     </div>
				<div class="desc span_3_of_2">
				      <% if (lang!=null){%>
                                      <%if (lang.equals("ita")) {%>
					<h2>Uva nella storia</h2>
					<p>Anticamente, l'uva era consigliata come potente antidoto contro lo stress psicofisico associato ad ansie,
                                preoccupazioni ed astenia, efficace soprattutto quando il succo d'uva veniva mescolato a rametti di rosmarino.
                                Attualmente, l'uva � stata rivalutata in chiave positiva: si � osservato che questo frutto � una vera e propria
                                risorsa a tutti gli effetti, il cui utilizzo spazia dall'ambito cosmetico al fitoterapico, dall'alimentare al medico.
                                ViteSimbolo dell'autunno e del dio Bacco, la pianta di vite, con i suoi grappoli d'uva, � da sempre gradita ed
                                apprezzata per merito della dolcezza dei suoi frutti organolettiche uniche, del buon apporto energetico-nutrizionale e,
                                soprattutto, delle virt� medicamentose legate alle preziose sostanze racchiuse negli acini e nelle foglie.
                                Origine, diffusione e variet�. � possibile scorgere la vite spontanea in numerose aree dell'Europa del Sud e dell'Asia occidentale;
                                globalmente, si annoverano numerosissime variet� di uva, oltre 8.000, di cui circa 1.600 sono coltivate nelle fasce climatiche
                                tipicamente temperate. Ad ogni modo, nonostante le innumerevoli variet�, una nota di merito spetta senza dubbio a Vitis vinifera,
                                dalla quale derivano tutti i vitigni italiani per uve da tavola ed uve da vino. Altra specie degna di esser menzionata � la Vitis labrusca,
                                tipicamente americana, coltivata in Italia - seppur marginalmente - come uva da tavola.Poniamo l'attenzione sulla specie pi� importante:
                                Vitis vinifera viene suddivisa in due grandi sottospecie, V. vinifera subsp. Vinifera (a sua volta catalogata in numerosissime cultivar)
                                e V. vinifera subsp. Sylvestris (sottospecie spontanea assai diffusa, anche se priva d'interesse agronomico).
                                        </p>					
                                      <%}%>
				      <%if (lang.equals("eng")) {%>
                                      	<h2>Grapes in the history</h2>
					<p>In ancient times, grapes were recommended as a powerful antidote to physical and psychological stress associated with anxiety,
                                concerns and asthenia, effective especially when the grape juice was mixed with rosemary sprigs.
                                Currently, the grapes were revalued in a positive light: it was observed that this fruit is a real
                                resource for all purposes, the use of which extends the scope to herbal cosmetic, from food to medical.
                                ViteSimbolo autumn and the god Bacchus, the vine plant, with its clusters of grapes, is always welcome and
                                appreciated for about the sweetness of its fruit unique organoleptic, good energy intake and nutritional,
                                above all, of the virtues medications related to the precious substances enclosed in the berries and leaves.
                                Origin, spread and variety. You can see the lives wild in many areas of southern Europe and western Asia;
                                globally, include many varieties of grapes, more than 8,000, of which about 1,600 are grown in climates
                                typically temperate. However, despite the countless varieties, a note about it no doubt Vitis vinifera,
                                from which derive all the Italian vines for table grapes and wine grapes. Other species worthy of being mentioned is the Vitis labrusca,
                                typically American, grown in Italy - albeit marginally - as grapes tavola.Poniamo attention to the most important species:
                                Vitis vinifera is divided into two major subspecies, V. vinifera subsp. Vinifera (in turn cataloged in numerous cultivars)
                                and V. vinifera subsp. Sylvestris (subspecies spontaneous widespread, although devoid of agronomic interest).
                                        </p>					
                                      <%}%>
                                      <%if (lang.equals("fra")) {%>
                                      	<h2>Raisin dans l'histoire</h2>
					<p>Dans les temps anciens, les raisins ont �t� recommand�s comme un puissant antidote au stress physique et psychologique associ�e � l'anxi�t�,
                                pr�occupations et asth�nie, efficaces surtout lorsque le jus de raisin a �t� m�lang� avec brins de romarin.
                                Actuellement, les raisins ont �t� r��valu�s dans une lumi�re positive: il a �t� observ� que ce fruit est un v�ritable
                                des ressources � toutes fins, dont l'utilisation se �tend la port�e de cosm�tiques � base de plantes, de la nourriture � un m�decin.
                                ViteSimbolo automne et le dieu Bacchus, le plant de vigne, avec ses grappes de raisins, est toujours le bienvenu et
                                appr�ci� pour environ la douceur de son organoleptique unique fruits, bon apport �nerg�tique et nutritionnel,
                                surtout, des m�dicaments vertus li�s aux substances pr�cieuses enferm�s dans des baies et des feuilles.
                                Origine, la propagation et la vari�t�. Vous pouvez voir la vie sauvage dans de nombreuses r�gions d'Europe du Sud et en Asie occidentale;
                                � l'�chelle mondiale, y compris de nombreuses vari�t�s de raisins, plus de 8000, dont environ 1600 sont cultiv�es dans les climats
                                g�n�ralement temp�r�. Cependant, malgr� les innombrables vari�t�s, une note � ce sujet aucun doute Vitis vinifera,
                                � partir de laquelle tirer toutes les vignes italiennes pour les raisins de table et raisins de cuve. D'autres esp�ces dignes d'�tre mentionn� est le labrusca Vitis,
                                typiquement am�ricain, cultiv� en Italie - quoique l�g�rement - les raisins tavola.Poniamo attention sur les esp�ces les plus importantes:
                                Vitis vinifera est divis� en deux sous-esp�ces principales, V. vinifera subsp. Vinifera (� son tour catalogu� dans de nombreux cultivars)
                                et V. vinifera subsp. Sylvestris (sous-esp�ce spontan�e r�pandue, bien que d�pourvus d'int�r�t agronomique).
                                        </p>					
                                      <%}%>
                                      <%if (lang.equals("spa")) {%>
                                      <h2>Uvas en la historia</h2>
					<p>En la antig�edad, las uvas fueron recomendados como un poderoso ant�doto contra el estr�s f�sico y psicol�gico asociado con la ansiedad,
                                preocupaciones y astenia, eficaces especialmente cuando el jugo de uva se mezcl� con ramitas de romero.
                                En la actualidad, las uvas se revalorizaron en una luz positiva: se observ� que esta fruta es una verdadera
                                de recursos a todos los efectos, la utilizaci�n de los cuales se extiende el �mbito de aplicaci�n de cosm�ticos a base de plantas, desde comida a un m�dico.
                                ViteSimbolo oto�o y el dios Baco, la planta de vid, con sus racimos de uvas, es siempre bienvenida y
                                apreciado por alrededor de la dulzura de sus frutos organol�ptica �nica, buena ingesta energ�tica y nutricional,
                                sobre todo, de los medicamentos virtudes relacionadas con las sustancias preciosas cerrados en las bayas y hojas.
                                Origen, difusi�n y variedad. Usted puede ver la vida silvestre en muchas zonas del sur de Europa y Asia occidental;
                                a nivel mundial, incluyen muchas variedades de uvas, m�s de 8.000, de los cuales unos 1.600 se cultivan en climas
                                normalmente templado. Sin embargo, a pesar de las innumerables variedades, una nota sobre el tema, sin duda, Vitis vinifera,
                                de la que derivan todas las vi�as italianas para las uvas de mesa y uvas de vino. Otras especies dignas de ser mencionado es la Vitis labrusca,
                                t�picamente americano, que se cultiva en Italia - aunque marginalmente - como uvas tavola.Poniamo atenci�n a las especies m�s importantes:
                                Vitis vinifera se divide en dos subespecies principales, V. vinifera subsp. Vinifera (a su vez catalogados en numerosos cultivares)
                                y V. vinifera subsp. Sylvestris (subespecie espont�nea generalizada, aunque carentes de inter�s agron�mico).
                                        </p>					
                                      <%}%>
                                      <%} else {%>
                                        <h2>Grapes in the history</h2>
					<p>In ancient times, grapes were recommended as a powerful antidote to physical and psychological stress associated with anxiety,
                                concerns and asthenia, effective especially when the grape juice was mixed with rosemary sprigs.
                                Currently, the grapes were revalued in a positive light: it was observed that this fruit is a real
                                resource for all purposes, the use of which extends the scope to herbal cosmetic, from food to medical.
                                ViteSimbolo autumn and the god Bacchus, the vine plant, with its clusters of grapes, is always welcome and
                                appreciated for about the sweetness of its fruit unique organoleptic, good energy intake and nutritional,
                                above all, of the virtues medications related to the precious substances enclosed in the berries and leaves.
                                Origin, spread and variety. You can see the lives wild in many areas of southern Europe and western Asia;
                                globally, include many varieties of grapes, more than 8,000, of which about 1,600 are grown in climates
                                typically temperate. However, despite the countless varieties, a note about it no doubt Vitis vinifera,
                                from which derive all the Italian vines for table grapes and wine grapes. Other species worthy of being mentioned is the Vitis labrusca,
                                typically American, grown in Italy - albeit marginally - as grapes tavola.Poniamo attention to the most important species:
                                Vitis vinifera is divided into two major subspecies, V. vinifera subsp. Vinifera (in turn cataloged in numerous cultivars)
                                and V. vinifera subsp. Sylvestris (subspecies spontaneous widespread, although devoid of agronomic interest).
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
