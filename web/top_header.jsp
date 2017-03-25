<%-- 
    Document   : top
    Created on : 5-mar-2015, 22.23.18
    Author     : Arturo & riki
--%>
<%  //numero prodotti nel carrello
    int qcart=Session.getCartItems(cookies).length;
    
    %>


	<div class="header_top">
			<div class="logo">
			<a href="home.jsp"><img src="images/logo1.png" alt="" /></a>
			</div>
			  <div class="header_top_right">
                             <div class="search_box"> <% String pnome=null; { %>
                                <form name="pnome<%=pnome%>" method="post" action="search.jsp">
                                    <a href="javascript:dsubmit(<%=pnome%>);"> <input name="search" type="text">
                                    <input type="submit" value="Cerca"></a>
                                </form> <%}%>
			     </div>
                        <% if(loggedOn==false) {%>  <!-- SE NON E' LOGGATO TI MANDA AL LOGIN-->
                          <div class="shopping_cart">
			      <div class="cart">
			        <a href="login.jsp" title="Login to add to cart" rel="nofollow" class="hvr-bubble-float-left">
			         <strong class="opencart"> </strong>  
                                   <% if (lang!=null){%>
                                   <%if (lang.equals("ita")) {%><span class="cart_title">Carrello</span><%}%>
                                 <%if (lang.equals("eng")) {%><span class="cart_title">Cart</span><%}%>
                                 <%if (lang.equals("fra")) {%><span class="cart_title">Chariot</span><%}%>
                                 <%if (lang.equals("spa")) {%><span class="cart_title">Carro</span><%}%>
                                  <%} else %> <span class="cart_title">Cart</span>
				</a>
			       </div>
			  </div>
                         <%}%>  
			 <% if(loggedOn==true && loggVend==false && loggAdmin==false ) {%>  <!--SE UTENTE E' COMPRATORE-->
			  <div class="shopping_cart">
			      <div class="cart">
			        <a href="cart.jsp" title="View my shopping cart" rel="nofollow">
			         <strong class="opencart"> </strong>
                                  <span class="no_prodotto">(<%=qcart%>)</span>
                                   <% if (lang!=null){%>
			         <%if (lang.equals("ita")) {%><span class="cart_title">Carrello</span><%}%>
                                 <%if (lang.equals("eng")) {%><span class="cart_title">Cart</span><%}%>
                                 <%if (lang.equals("fra")) {%><span class="cart_title">Chariot</span><%}%>
                                 <%if (lang.equals("spa")) {%><span class="cart_title">Carro</span><%}%>
                                  <%} else %> <span class="cart_title">Cart</span>
				</a>
			       </div>
			  </div>
                             <%}%>   
	           <div class="languages" title="language">
	    	     <div id="language" class="wrapper-dropdown" tabindex="1"><img src="images/<%=lang%>.png" title="Language" width="26" height="26" >
		     </div>
		 </div>
	    </div>                   
	  <div class="clear"></div>
        </div>