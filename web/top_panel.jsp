<%-- 
    Document   : top_panel
    Created on : 14-mar-2015, 10.25.45
    Author     : arturo e riki
--%>

<div id="toppanel">
	<div id="panel">
		<div class="content clearfix">
			<div class="left">
				<h1>Cantina Magna</h1>
				</div>
			<div class="left">
				<!-- Login Form -->
				<form name="logonForm" action="home.jsp" method="post">
					<h1>Login</h1>    
                                        <label><a href="login.jsp"><img src="images/bt_login.png"></a></label>     
				</form>
			</div>
			<div class="left right">			
				<!-- Register Form -->
				<form name="sigupForm" action="home.jsp" method="post">
					<h1>Non sei ancora iscritto?</h1>				
                                        <label><a href="registration.jsp"><img src="images/bt_signup.png"></a></label>
                              	</form>
			</div>
		</div>
        </div> <!-- /login -->	
	<div class="tab">
		<ul class="login">
			<li class="left">&nbsp;</li>
                        <%if(loggedOn==false) {%>
                        <li><script type='text/javascript' src='js/greetings.js'></script> Ospite</li>
			<li class="sep">|</li>
			<li id="toggle"> 
                        <a id="open" class="open" href="#">Log In</a>
                        <%}%>
                        <%if(loggedOn==true && loggVend==true ) {%>  <!--SE UTENTE VENDITORE-->
                        <li><script type='text/javascript' src='js/greetings.js'></script> <%=Session.getCduser(cookies)%></li>
                        <li class="sep">|</li>
                        <li><a href="mod_user.jsp">Modify</a></li>
                        <li class="sep">|</li>
                        <li id="toggle">
                        <a href="viewprod_vend.jsp">Products  </a>
                           <li class="sep">|</li>
			<li id="toggle">  
                          <input type="hidden" name="status" value="logout"/>
                          <a name="Logout" id="close" class="close" href="logout.jsp">Logout</a>            
                        </li>
                        <%}%>
                        <% if(loggedOn==true && loggVend==false && loggAdmin==false ) {%>  <!--SE UTENTE E' COMPRATORE-->
                        <li><script type='text/javascript' src='js/greetings.js'></script> <%=Session.getCduser(cookies)%></li>
                        <li class="sep">|</li>
                        <li><a href="mod_user.jsp">Modify</a></li>
                        <li class="sep">|</li>
                        <li id="toggle">
                        <a href="wishlist.jsp">Wishlist</a>
                        <li class="sep">|</li>
			<li id="toggle">  
                        <a href="orderlist.jsp">Order List</a>
                        <li class="sep">|</li>
			<li id="toggle"> 
                          <input type="hidden" name="status" value="logout"/>
                          <a name="Logout" id="close" class="close" href="logout.jsp">Logout</a>            
                        </li>
                           <%}%>
                           <% if(loggedOn==true && loggAdmin==true ) {%>  <!--SE UTENTE E' AMMINISTRATORE-->
                        <li><script type='text/javascript' src='js/greetings.js'></script> <%=Session.getCduser(cookies)%></li>
                         <li class="sep">|</li>
                        <li><a href="mod_user.jsp">Modify</a></li>
                        <li class="sep">|</li>
			<li id="toggle">  
                        <a href="Aorderlist.jsp">Order List</a>
                        <li class="sep">|</li>
			<li id="toggle"> 
                        <a href="coupon.jsp">Coupon</a>
                        <li class="sep">|</li>
			<li id="toggle"> 
                        <a href="Auserlist.jsp">Users' List</a>
                        <li class="sep">|</li>
			<li id="toggle"> 
                          <input type="hidden" name="status" value="logout"/>
                          <a name="Logout" id="close" class="close" href="logout.jsp">Logout</a>            
                        </li>
                           <%}%>
                        <li id="toggle"><a id="close" style="display: none;" class="close" href="#">Chiudi</a></li>
			<li class="right">&nbsp;</li>
		</ul> 
	</div>
	
</div>