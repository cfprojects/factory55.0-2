<cfcomponent extends="com.factory55.core.baseController">

	<cffunction name="onControllerStart" output="false">
		<cfargument name="rc" type="struct" required="true">
		<cfset variables.cfc.blogService = getService("blogService")>
		<cfset rc.categories = variables.cfc.blogService.getCategories()>
		
	</cffunction>

	<cffunction name="index">
		<cfargument name="rc" type="struct" required="true">
		<cfset var local = structNew()>
		<cfset renderView("blog/entries.cfm",rc)>
	</cffunction>

	<cffunction name="contact">
		<cfargument name="rc" type="struct" required="true">
		<cfset var local = structNew()>
		<cfset renderView("blog/contact.cfm",rc)>
	</cffunction>
	
</cfcomponent>