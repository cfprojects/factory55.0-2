<cfcomponent output="false" extends="com.factory55.framework">

	<cffunction name="initSetup" output="false" returntype="void">
		<cfargument name="setupBean" type="com.factory55.core.setupBean" required="true">
		<cfset this.settings = arguments.setupBean>
		<cfif NOT structKeyExists(this,"objectList")>
			<cfset initFramework()>
		</cfif>
	</cffunction>
	
</cfcomponent>