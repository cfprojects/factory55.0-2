<cfcomponent output="false">
	
	
	<!--- Defaults ------------------------------------------------------------>
	<cfset this.applicationPath		= "/app">
	<cfset this.cache				= true>
	<cfset this.configuration		= "production">
	<cfset this.isProduction		= true>
	<cfset this.frameworkDebug		= false>
	<!--- Defaults ------------------------------------------------------------>
	
	<cffunction name="getFrameworkDebug" output="false" access="public" returntype="boolean">
		<cfreturn this.frameworkDebug>
	</cffunction>
	
		
	<!--- Application Path ---------------------------------------------------->
	<cffunction name="getApplicationPath" output="false" access="public" returntype="string">
		<cfreturn this.applicationPath>
	</cffunction>
	<cffunction name="setApplicationPath" output="false" access="public" returntype="void">
		<cfargument name="applicationPath" type="string" required="true">
		<cfset this.applicationPath = arguments.applicationPath>
	</cffunction>
	<cffunction name="getApplicationFilePath" output="false" access="public" returntype="string">
		<cfreturn expandPath("/" & getApplicationPath())>
	</cffunction>
	<cffunction name="getCleanApplicationPath" output="false" access="public" returntype="string">
		<cfset var cleanPath = replace(getApplicationPath(),"/","")>
		<cfset cleanPath = replace(getApplicationPath(),"/",".","all")>
		<cfif left(cleanPath,1) IS ".">
			<cfset cleanPath = replace(cleanPath,".","")>
		</cfif>
		<cfreturn cleanPath>
	</cffunction>
	<cffunction name="getFileUploadPath" returntype="string" output="false">
		<cfset var uploadPath = "">
		<cfset uploadPath = getApplicationFilePath() & "/files/">
		<cfreturn uploadPath>
	</cffunction>
	<!--- Application Path ---------------------------------------------------->
	
	
	<!--- Configuration ------------------------------------------------------->
	<cffunction name="getConfiguration" output="false" access="public" returntype="string">
		<cfreturn this.configuration>
	</cffunction>
	<cffunction name="setConfiguration" output="false" access="public" returntype="void">
		<cfargument name="configuration" type="string" required="true">
		<cfset this.configuration = arguments.configuration>
	</cffunction>
	<!--- Configuration ------------------------------------------------------->	

	
	<!--- Cache --------------------------------------------------------------->
	<cffunction name="getCache" output="false" access="public" returntype="boolean">
		<cfreturn this.cache>
	</cffunction>
	<cffunction name="setCache" output="false" access="public" returntype="void">
		<cfargument name="cache" type="boolean" required="true">
		<cfset this.cache = arguments.cache>
	</cffunction>
	<!--- Cache --------------------------------------------------------------->
	
	
	<!--- Is Production ------------------------------------------------------->
	<cffunction name="getIsProduction" output="false" access="public" returntype="boolean">
		<cfreturn this.isProduction>
	</cffunction>
	<cffunction name="setIsProduction" output="false" access="public" returntype="void">
		<cfargument name="isProduction" type="boolean" required="true">
		<cfset this.isProduction = arguments.isProduction>
	</cffunction>
	<!--- Is Production ------------------------------------------------------->
	
	
	<!--- Configuration Variables --------------------------------------------->
	<cffunction name="setConfig" output="false" access="public" returntype="void">
		<cfargument name="name" type="string" required="true">
		<cfargument name="value" type="any" required="true">
		<cfset this[arguments.name] = arguments.value>
	</cffunction>
	<cffunction name="getConfig" output="false" access="public" returntype="any">
		<cfargument name="name" type="string" required="true">
		<cfif structKeyExists(this,arguments.name)>
			<cfreturn this[arguments.name]>
		<cfelse>
			<cfthrow type="factory55.error" detail="Variable #arguments.name# has not been set in the setup bean">
		</cfif>
	</cffunction>
	<!--- Configuration Variables --------------------------------------------->
	
	
</cfcomponent>