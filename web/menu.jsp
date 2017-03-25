<%-- 
    Document   : menu
    Created on : 18-nov-2014, 14.58.05
    Author     : arturo e riki
--%>

<%
  String categorie=null;
  String rosso=null;
  String bianco=null;
  String rose=null;
  
 if(lang!=null){
  if (lang.equals("ita"))
     {categorie="Categorie";
      rosso="Rosso";
      bianco="Bianco";
      rose="Rosè";}
  if (lang.equals("eng"))
     {categorie="Categories";
      rosso="Red";
      bianco="White";
      rose="Rose";}
  if (lang.equals("fra"))
     {categorie="Categories";
      rosso="Rouge";
      bianco="Blanc";
      rose="Rose";}
  if (lang.equals("spa"))
     {categorie="Categorías";
      rosso="Rojo";
      bianco="Blanco";
      rose="Rosa";}
  }    
%>

<%@ page session="false" %>
<% util.Debug.println("lang in menu= "+lang);%>

	<div class="menu">
	  <ul id="dc_mega-menu-orange" class="dc_mm-orange">
	   <li><a href="home.jsp">Home</a></li>
           <li><a  href="#"><p><%=categorie%></p></a>
   	            <ul>             
                      <form name="formR" method="post" action="search.jsp" >
                        <li>
                            <a href="javascript:submitR();"/><%=rosso%></a><input type="hidden" name="search" value="R"/>
                        </li>
                      </form>
                      <form name="formW" method="post" action="search.jsp" >
                        <li>
                            <a href="javascript:submitW();"/><%=bianco%></a><input type="hidden" name="search" value="W"/>
                        </li>
                      </form>
                      <form name="formO" method="post" action="search.jsp" >
                        <li>
                            <a href="javascript:submitO();"/><%=rose%></a><input type="hidden" name="search" value="O"/>
                        </li>
                      </form>                     
    		    </ul>
           </li>
          <% if (lang!=null){%>
   <%if (lang.equals("ita")) {%><li><a href="cantina.jsp">Cantina</a></li><%}%>
   <%if (lang.equals("eng")) {%><li><a href="cantina.jsp">Cellar</a></li><%}%>
   <%if (lang.equals("fra")) {%><li><a href="cantina.jsp">Cave</a></li><%}%>
   <%if (lang.equals("spa")) {%><li><a href="cantina.jsp">Bodega</a></li><%}%>
    <%} else %> <li><a href="cantina.jsp">Cellar</a></li>
    
          <% if (lang!=null){%>
   <%if (lang.equals("ita")) {%><li><a href="uva.jsp">Uva</a></li><%}%>
   <%if (lang.equals("eng")) {%><li><a href="uva.jsp">Grapes</a></li><%}%>
   <%if (lang.equals("fra")) {%><li><a href="uva.jsp">Raisin</a></li><%}%>
   <%if (lang.equals("spa")) {%><li><a href="uva.jsp">Uvas</a></li><%}%>
    <%} else %> <li><a href="uva.jsp">Cellar</a></li>
    
           <% if (lang!=null){%>
   <%if (lang.equals("ita")) {%><li><a href="vino_cibo.jsp">Vino e Cibo</a></li><%}%>
   <%if (lang.equals("eng")) {%><li><a href="vino_cibo.jsp">Wine and Food</a></li><%}%>
   <%if(lang.equals("fra")) {%><li><a href="vino_cibo.jsp">Vin et la Nourriture</a></li><%}%>
   <%if(lang.equals("spa")) {%><li><a href="vino_cibo.jsp">Vino y Comida</a></li><%}%>
    <%} else %> <li><a href="vino_cibo.jsp">Wine and Food</a></li>
    
           <% if (lang!=null){%>
   <%if (lang.equals("ita")) {%><li><a href="search.jsp">Tutti i prodotti</a><input type="hidden" name="search" value="ALL"/></li><%}%>
   <%if (lang.equals("eng")) {%><li><a href="search.jsp">All products</a><input type="hidden" name="search" value="ALL"/></li><%}%>
   <%if (lang.equals("fra")) {%><li><a href="search.jsp">Tous les produits</a><input type="hidden" name="search" value="ALL"/></li><%}%>
   <%if (lang.equals("spa")) {%><li><a href="search.jsp">Todos los productos</a><input type="hidden" name="search" value="ALL"/></li><%}%>
    <%} else %> <li><a href="uva.jsp">All products</a></li>

         <% if (lang!=null){%>
   <%if (lang.equals("ita")) {%><li><a href="contacts.jsp">Contattaci</a></li><%}%>
   <%if (lang.equals("eng")) {%><li><a href="contacts.jsp">Contact us</a></li><%}%>
   <%if(lang.equals("fra")) {%><li><a href="contacts.jsp">Contactez nous</a></li><%}%>
   <%if(lang.equals("spa")) {%><li><a href="contacts.jsp">Contáctenos</a></li><%}%>
    <%} else %> <li><a href="vino_cibo.jsp">Wine and Food</a></li>                                                                                                                                         
                                           
  <div class="clear"></div>
</ul>
      
</div>