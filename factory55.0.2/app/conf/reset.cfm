<!--- customize to match your logic on resetting the framework --->
<cfset variables.resetFramework = false>
<cfif structKeyExists(url,"initapp")>
	<cfset variables.resetFramework = true>
</cfif>