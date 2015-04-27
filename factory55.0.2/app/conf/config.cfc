<cfcomponent output="false">
	
	<cffunction name="initFramework" output="false">
		<!--- set constants between all configurations here --->
		<cfset this.dataSource			= "factory55_demo">
		<cfset this.defaultController	= "blogController">
		<cfset this.defaultAction		= "index">
	</cffunction>
	
	<cffunction name="development" output="false">
		<cfargument name="setupBean" required="true" type="com.factory55.core.setupBean">
		<cfset var local = structNew()>
		<cfset arguments.setupBean.setIsProduction(false)>
		<cfset arguments.setupBean.setConfig("defaultController",this.defaultController)>
		<cfset arguments.setupBean.setConfig("defaultAction",this.defaultAction)>
		<cfset arguments.setupBean.setConfig("dataSource",this.dataSource)>
	</cffunction>
	
	<cffunction name="production" output="false">
		<cfargument name="setupBean" required="true" type="com.factory55.core.setupBean">
		<cfset var local = structNew()>
		<cfset arguments.setupBean.setIsProduction(true)>
		<cfset arguments.setupBean.setConfig("defaultController",this.defaultController)>
		<cfset arguments.setupBean.setConfig("defaultAction",this.defaultAction)>
		<cfset arguments.setupBean.setConfig("dataSource",this.dataSource)>
	</cffunction>
	
</cfcomponent>