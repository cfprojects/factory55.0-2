<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta name="Description" content="Information architecture, Web Design, Web Standards." />
	<meta name="Keywords" content="your, keywords" />
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name="Distribution" content="Global" />
	<meta name="Author" content="John Blayter - jblayter@gmail.com" />
	<meta name="Robots" content="index,follow" />
<cfoutput>
	#stylesheet("Envision")#
	#javascript("common")#
</cfoutput>
	<title>Factory55 Framework</title>
</head>
<body>
<!-- wrap starts here -->
<div id="wrap">
		
		<!--header -->
		<div id="header">			
				
			<h1 id="logo-text"><a href="#linkTo(controller='blogController',action='index')#">Factory 55</a></h1>		
			<p id="slogan">a framework without magic...</p>		
			
			<div id="header-links">
			<p>
				<cfoutput>
					<a href="#linkTo(controller='blogController',action='index')#">Home</a> | 
					<a href="#linkTo(controller='blogController',action='contact')#">Contact</a>
				</cfoutput>
			</p>		
		</div>		
						
		</div>
		
		<!-- menu -->	
		<div  id="menu">
			<ul>
				<cfoutput>
				<li><a href="#linkTo(controller='blogController',action='index')#">Home</a></li>
				<li><a href="http://factory55.riaforge.org/">Project Home</a></li>
				<li><a href="http://factory55.riaforge.org/wiki/">WIKI</a></li>
				<li><a href="http://factory55.riaforge.org/forums/forums.cfm?conferenceid=7C7701FF-BAAE-21BC-7A3D85ABA5033D59">Forums</a></li>
				<li class="last"><a href="#linkTo(controller='blogController',action='contact')#">Contact</a></li>		
				</cfoutput>
			</ul>
		</div>					
			
		<!-- content-wrap starts here -->
		<div id="content-wrap">
				
			<div id="sidebar">
			
				<!--- <h3>Search Box</h3>	
				<form action="#" class="searchform">
					<p>
					<input name="search_query" class="textbox" type="text" />
  					<input name="search" class="button" value="Search" type="submit" />
					</p>			
				</form>	 --->
				
				<cfoutput>
					<h3>Sidebar Menu</h3>
					<ul class="sidemenu">				
						<li><a href="#linkTo(controller='blogController',action='index')#">Home</a></li>
						<li><a href="http://factory55.riaforge.org/">Project Home</a></li>
						<li><a href="http://factory55.riaforge.org/wiki/">WIKI</a></li>
						<li><a href="http://factory55.riaforge.org/forums/forums.cfm?conferenceid=7C7701FF-BAAE-21BC-7A3D85ABA5033D59">Forums</a></li>
						<li><a href="#linkTo(controller='blogController',action='contact')#">Contact</a></li>
					</ul>
					<h3>Tags</h3>
					<ul class="sidemenu">				
						<cfloop query="rc.categories">
							<li><a href="#linkTo(controller='blogController',action='index',params={alias=rc.categories.alias})#">#rc.categories.name#</a></li>
						</cfloop>
					</ul>
				</cfoutput>		
			</div>
				
			<div id="main">
				<cfoutput>#local.pageContent#</cfoutput>

<!--- 				<a name="TemplateInfo"></a>
				<h2><a href="index.html">Template Info</a></h2>
				
                <p><strong>Envision</strong> is a free, W3C-compliant, CSS-based website template
                by <a href="http://www.styleshout.com/">styleshout.com</a>. This work is
                distributed under the <a rel="license" href="http://creativecommons.org/licenses/by/2.5/">
                Creative Commons Attribution 2.5  License</a>, which means that you are free to
                use and modify it for any purpose. All I ask is that you give me credit by including a <strong>link back</strong> to
                <a href="http://www.styleshout.com/">my website</a>.
                </p>

                <p>
                You can find more of my free template designs at <a href="http://www.styleshout.com/">my website</a>.
                For premium commercial designs, you can check out
                <a href="http://www.dreamtemplate.com" title="Website Templates">DreamTemplate.com</a>.
                </p>
				
				<p class="post-footer align-right">					
					<a href="index.html" class="readmore">Read more</a>
					<a href="index.html" class="comments">Comments (7)</a>
					<span class="date">Oct 01, 2006</span>	
				</p>
			
				<a name="SampleTags"></a>
				<h2><a href="index.html">Sample Tags</a></h2>
				
				<h3>Code</h3>				
				<p><code>
				code-sample { <br />
				font-weight: bold;<br />
				font-style: italic;<br />				
				}		
				</code></p>	
				
				<h3>Example Lists</h3>
			
				<ol>
					<li>Here is an example</li>
					<li>of an ordered list</li>								
				</ol>	
							
				<ul>
					<li>Here is an example</li>
					<li>of an unordered list</li>								
				</ul>				
				
				<h3>Blockquote</h3>			
				<blockquote><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy 
				nibh euismod tincidunt ut laoreet dolore magna aliquam erat....</p></blockquote>
				
				<h3>Image and text</h3>
				<p><a href="http://getfirefox.com/"><img src="images/firefox-gray.jpg" width="100" height="120" alt="firefox" class="float-left" /></a>
				Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec libero. Suspendisse bibendum. 
				Cras id urna. Morbi tincidunt, orci ac convallis aliquam, lectus turpis varius lorem, eu 
				posuere nunc justo tempus leo. Donec mattis, purus nec placerat bibendum, dui pede condimentum 
				odio, ac blandit ante orci ut diam. Cras fringilla magna. Phasellus suscipit, leo a pharetra 
				condimentum, lorem tellus eleifend magna, eget fringilla velit magna id neque. Curabitur vel urna. 
				In tristique orci porttitor ipsum. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. 
				Donec libero.  				
				</p>
				
				<h3>Table Styling</h3>
							
				<table>
					<tr>
						<th class="first"><strong>post</strong> date</th>
						<th>title</th>
						<th>description</th>
					</tr>
					<tr class="row-a">
						<td class="first">04.18.2007</td>
						<td><a href="index.html">Augue non nibh</a></td>
						<td><a href="index.html">Lobortis commodo metus vestibulum</a></td>
					</tr>
					<tr class="row-b">
						<td class="first">04.18.2007</td>
						<td><a href="index.html">Fusce ut diam bibendum</a></td>
						<td><a href="index.html">Purus in eget odio in sapien</a></td>
					</tr>
					<tr class="row-a">
						<td class="first">04.18.2007</td>
						<td><a href="index.html">Maecenas et ipsum</a></td>
						<td><a href="index.html">Adipiscing blandit quisque eros</a></td>
					</tr>
					<tr class="row-b">
						<td class="first">04.18.2007</td>
						<td><a href="index.html">Sed vestibulum blandit</a></td>
						<td><a href="index.html">Cras lobortis commodo metus lorem</a></td>
					</tr>
				</table>
								
				<h3>Example Form</h3>
				<form action="#">			
				<p>			
				<label>Name</label>
				<input name="dname" value="Your Name" type="text" size="30" />
				<label>Email</label>
				<input name="demail" value="Your Email" type="text" size="30" />
				<label>Your Comments</label>
				<textarea rows="5" cols="5"></textarea>
				<br />	
				<input class="button" type="submit" />		
				</p>		
				</form>				
				<br /> --->	

			</div>
		
		<!-- content-wrap ends here -->	
		</div>
					
		<!--footer starts here-->
		<div id="footer">
			
            <p>
				<cfoutput>
					&copy; #year(now())# <strong>Your Company</strong>
		
		            &nbsp;&nbsp;&nbsp;&nbsp;
		
				    <a href="http://www.bluewebtemplates.com/" title="Website Templates">website templates</a> by <a href="http://www.styleshout.com/">styleshout</a>
		
		            &nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#linkTo(controller='blogController',action='index')#">Home</a> | 
					<a href="#linkTo(controller='blogController',action='contact')#">Contact</a> |
				
				    <!--- <a href="index.html">Home</a> |
		   	        <a href="index.html">Sitemap</a> |
			        <a href="index.html">RSS Feed</a> | --->
		            <a href="http://validator.w3.org/check?uri=referer">XHTML</a> |
				    <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a>
				</cfoutput>
	   	    </p>
				
		</div>	

<!-- wrap ends here -->
</div>

</body>
</html>