<cfif (NOT structKeyExists(application,"factory55.framework")) OR (variables.resetFramework IS true)>
	<cfscript>
	variables.setupBean = createObject("component","com.factory55.core.setupBean");
	variables.setupBean.setApplicationPath(variables.factory55.applicationPath);
	variables.setupBean.setConfiguration(variables.factory55.configuration);
	
	variables.config = createObject("component","#variables.setupBean.getCleanApplicationPath()#.conf.config");
	if(structKeyExists(variables.config,"initFramework")){
		variables.config.initFramework();
		}
	</cfscript>
	
	<cfinvoke component="#variables.config#" method="#variables.setupBean.getConfiguration()#">
		<cfinvokeargument name="setupBean" value="#variables.setupBean#">
	</cfinvoke>
	
	<cfscript>
	application.factory55.setupBean		= variables.setupBean;
	application.factory55.framework		= createObject("com.factory55.framework").initFramework();
	application.factory55.setupComplete = application.factory55.framework.setupFramework(setupBean=variables.setupBean);
	</cfscript>
</cfif>