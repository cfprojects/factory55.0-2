<cfcomponent extends="mxunit.framework.TestCase" description="Base Test that all test for the Factory55 framework extends">
	
	<cfinclude template="/com/factory55/framework.cfm">
	
	<cffunction name="setup" returntype="void" access="public" hint="initial startup of the framework for used by the tests">
	
		<!--- Used in the setup of the test --->
		<cfset var local = structNew()>
		<cfset application = structNew()>
		
		<cfinclude template="/factory55Settings.cfm">
		
		<cfscript>
		local.setupBean = createObject("component","com.factory55.core.setupBean");
		local.setupBean.setApplicationPath(variables.factory55.applicationPath);
		local.setupBean.setConfiguration(variables.factory55.configuration);
		
		local.config = createObject("component","#local.setupBean.getCleanApplicationPath()#.conf.config");
		if(structKeyExists(local.config,"initFramework")){
			local.config.initFramework();
			}
		</cfscript>
		
		<cfinvoke component="#local.config#" method="#local.setupBean.getConfiguration()#">
			<cfinvokeargument name="setupBean" value="#local.setupBean#">
		</cfinvoke>
		
		<cfscript>
		initFramework();
		setupFramework(setupBean=local.setupBean);
		</cfscript>
		
	</cffunction>

</cfcomponent>