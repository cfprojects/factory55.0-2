<cfcomponent output="false" extends="com.factory55.framework">
	
	<cffunction name="initSetup" output="false" returntype="void">
		<cfargument name="setupBean" type="com.factory55.core.setupBean" required="true">
		<cfset this.settings = arguments.setupBean>
		<cfif NOT structKeyExists(this,"objectList")>
			<cfset initFramework()>
		</cfif>
	</cffunction>
	
	<cffunction name="renderView" output="true">
		<cfargument name="template" type="string" required="true">
		<cfargument name="rc" type="struct" required="false">
		<cfargument name="layout" type="string" required="false" default="layout.cfm">
		<cfset render("view",arguments.template,arguments.rc,arguments.layout)>
	</cffunction>
	
	<cffunction name="renderTemplate" output="true">
		<cfargument name="template" type="string" required="true">
		<cfargument name="rc" type="struct" required="false">
		<cfset render("template",arguments.template,arguments.rc)>
	</cffunction>

	<cffunction name="renderAsJson" output="true">
		<cfargument name="rc" type="struct" required="false">
		<cfcontent reset="true" type="application/x-javascript"><cfoutput>#serializeJSON(arguments.rc)#</cfoutput>
	</cffunction>
	
	<cffunction name="render" output="true" access="private">
		<cfargument name="type" type="string" required="true">
		<cfargument name="template" type="string" required="true">
		<cfargument name="requestContext" type="struct" required="false">
		<cfargument name="layout" type="string" required="false" default="layout.cfm">
		<cfset var local = structNew()>
		<cfset var rc = arguments.requestContext>
		<cfsavecontent variable="local.pageContent">
			<cfinclude template="/#this.settings.getCleanApplicationPath()#/views/#arguments.template#">
		</cfsavecontent>
		<cfif arguments.type IS "view">
			<cfinclude template="/#this.settings.getCleanApplicationPath()#/views/#arguments.layout#">
		<cfelse>
			<cfsetting showdebugoutput="false">
			<cfoutput>#local.pageContent#</cfoutput>
		</cfif>
	</cffunction>
	
	<cffunction name="linkTo" output="false" access="public">
		<cfargument name="controller" type="string" required="false">
		<cfargument name="action" type="string" required="false">
		<cfargument name="params" type="struct" required="false">
		<cfset var local = structNew()>
		<cfif not structKeyExists(arguments,"controller")>
			<cfset arguments.controller	= request.factory55.controller>
		</cfif>
		<cfif not structKeyExists(arguments,"action")>
			<cfset arguments.action		= request.factory55.action>
		</cfif>
		<cfset local.url = cgi.script_name & "?action=" & arguments.controller & "." & arguments.action>
		<cfif structKeyExists(arguments,"params")>
			<cfloop collection="#arguments.params#" item="local.item">
				<cfset local.url = local.url & "&" & lcase(local.item) & "=" & arguments.params[local.item]>
			</cfloop>
		</cfif>
		<cfreturn local.url>
	</cffunction>

	<cffunction name="redirect" output="false" access="public">
		<cfargument name="controller" type="string" required="false">
		<cfargument name="action" type="string" required="false">
		<cfargument name="params" type="struct" required="false">
		<cfset var redirectTo = "">
		<cfset redirectTo = linkTo(argumentCollection=arguments)>
		<cflocation url="#redirectTo#">
	</cffunction>
	
	<cffunction name="stylesheet" output="false" access="public">
		<cfargument name="cssName" type="string" required="true">
		<cfset var local = structNew()>
		<cfset local.css = '<link rel="stylesheet" type="text/css" href="/#this.settings.getCleanApplicationPath()#/assets/css/#arguments.cssName#.css"></link>'>
		<cfreturn local.css>		
	</cffunction>
	
	<cffunction name="javascript" output="false" access="public">
		<cfargument name="jsName" type="string" required="true">
		<cfset var javaScript = structNew()>
		<cfset javaScript = '<script type="text/javascript" src="/#this.settings.getCleanApplicationPath()#/assets/js/#arguments.jsName#.js"></script>'>
		<cfreturn javaScript>		
	</cffunction>
	
</cfcomponent>