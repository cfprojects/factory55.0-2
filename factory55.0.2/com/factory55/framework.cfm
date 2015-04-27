
<cffunction name="initFramework" output="false" returntype="any">
	<!--- clear a shared scope for all the functions ---------------------->
	<cfset this.objectList = "beans,controllers,domain,enums,services">
	<cfreturn this>
</cffunction>

<cffunction name="setupFramework" output="false" returntype="boolean">
	<cfargument name="setupBean" type="com.factory55.core.setupBean" required="true">
	<cfset var local = structNew()>
	<!--- save settings --------------------------------------------------->
	<cfset this.settings = arguments.setupBean>
	<!--- set configuration variables ------------------------------------->
	<cflock name="objectLock" timeout="10" throwontimeout="true">
		<cfset application.factory55.controllers	= structNew()>
		<cfset application.factory55.enums			= structNew()>
		<cfset application.factory55.beans			= structNew()>
		<cfset application.factory55.domain			= structNew()>
		<cfset application.factory55.services		= structNew()>
	</cflock>
	<!--- load objects ---------------------------------------------------->
	<cfset loadObjects("enums")>
	<cfset loadObjects("beans")>
	<cfset loadObjects("domain")>
	<cfset loadObjects("services")>
	<cfset loadObjects("controllers")>
	<!--- init objects ---------------------------------------------------->
	<cfset initObjects("enums")>
	<cfset initObjects("beans")>
	<cfset initObjects("domain")>
	<cfset initObjects("services")>
	<cfset initObjects("controllers")>
	<!--- setup complete -------------------------------------------------->
	<cfreturn true>
</cffunction>

<cffunction name="initObjects" output="false" returntype="void">
	<cfargument name="objectType" type="string" required="true">
	<cfset var local = structNew()>
	<cfloop list="#structKeyList(application.factory55[arguments.objectType])#" index="local.i">
		<cfif isObject(application.factory55[arguments.objectType][UCASE(local.i)])>
			<cfset initObject(application.factory55[arguments.objectType][UCASE(local.i)])>
		<cfelse>
			<cftrace text="#local.i# is not an object">
		</cfif>
	</cfloop>
</cffunction>

<cffunction name="initObject" output="false" returntype="void" access="public">
	<cfargument name="object" type="any" required="true" hint="reference to the actual object">
	<cfif structKeyExists(arguments.object,"initSetup")>
		<cfinvoke component="#arguments.object#" method="initSetup">
			<cfinvokeargument name="setupBean" value="#this.settings#">
		</cfinvoke>
	</cfif>
	<cfif structKeyExists(arguments.object,"onInit")>
		<cfinvoke component="#arguments.object#" method="onInit"></cfinvoke>
	</cfif>
</cffunction>

<cffunction name="checkSetupComplete" output="false" returntype="boolean" access="public">
	<cfset var applicationSetupComplete = false>
	<cfif structKeyExists(application,"factory55")>
		<cfif structKeyExists(application.factory55,"setupComplete")>
			<cfset applicationSetupComplete = true>
		</cfif>
	</cfif>
	<cfreturn applicationSetupComplete>
</cffunction>

<cffunction name="loadObjects" output="true" access="public" returntype="any">
	<cfargument name="objectType" type="string" required="true">
	<cfargument name="objectName" type="string" required="false">
	<cfset var local = structNew()>
	<cfif NOT listFindNoCase(this.objectList,arguments.objectType)>
		<cfthrow type="factory55.error" detail="#arguments.objectType# is not a valid type to load.">
	</cfif>
	<cfset local.objectList = listObjects(arguments.objectType)>
	<cfif structKeyExists(arguments,"objectName")>
		<!--- load a single object --->
		<cfif arrayLen(structFindKey(local.objectList,arguments.objectName))>
			<cfset local.item = local.objectList[arguments.objectName]>
			<cfset local.returnObject = loadObject(arguments.objectName,local.item["path"],arguments.objectType)>
		<cfelse>
			<cfthrow type="factory55.error" detail="Could not find a #arguments.objectType# named #arguments.objectName#">
		</cfif>
	<cfelse>
		<cfif this.settings.getFrameworkDebug()>
			<cftrace text="loading objects of type #arguments.objectType#">
		</cfif>
		<cfloop collection="#local.objectList#" item="local.i">
			<cfset local.item = local.objectList[local.i]>
			<cfset loadObject(local.i,local.item["path"],arguments.objectType)>
		</cfloop>
		<cfset local.returnObject = false>
	</cfif>
	<cfreturn local.returnObject>
</cffunction>

<cffunction name="listObjects" output="false" access="public" returntype="struct">
	<cfargument name="type" type="string" required="true">
	<cfargument name="filter" type="string" required="false" default="*.cfc">
	<cfset var local = structNew()>
	<cfif NOT listFindNoCase(this.objectList,arguments.type)>
		<cfthrow type="factory55.error" detail="#arguments.type# is not a valid type to list.">
	</cfif>
	<cfif NOT isDefined("request.factory55.listServices.#arguments.type#")>
		<cfset local.scanPath = "#this.settings.getApplicationFilePath()#/#arguments.type#/">
		<cfdirectory action="list" directory="#local.scanPath#" filter="#arguments.filter#" recurse="true" name="local.serviceFiles">
		<cfset request.serviceFiles[arguments.type] = structNew()>
		<cfset request.serviceFiles[arguments.type].path = local.scanPath>
		<cfset request.serviceFiles[arguments.type].files = local.serviceFiles>
		<cfset request.serviceFiles[arguments.type].filter = local.arguments.filter>
		<cfset local.returnData = structNew()>
		<cfloop query="local.serviceFiles">
			<cfset local.serviceName = UCASE(spanExcluding(local.serviceFiles.name,"."))>
			<cfset local.servicePath = this.settings.getCleanApplicationPath() & replace(replace(local.serviceFiles.directory,this.settings.getApplicationFilePath(),""),"\",".","all") & "." & local.serviceName>
			<cfset local.serviceDate = dateMask(local.serviceFiles.dateLastModified)>
			<cfif structKeyExists(local.returnData,local.serviceName)>
				<cfthrow type="factory55.error" detail="A #arguments.type# already exists with the name of #local.serviceName#. Please rename your #arguments.type#.">
			<cfelse>
				<cfset local.returnData[local.serviceName]		= structNew()>
				<cfset local.returnData[local.serviceName].path = local.servicePath>
				<cfset local.returnData[local.serviceName].date = local.serviceDate>
			</cfif>
		</cfloop>
		<cfif arguments.filter IS "*.cfc">
			<cfset request.factory55.listServices[arguments.type] = local.returnData>
		</cfif>
	<cfelse>
		<cfset local.returnData = request.factory55.listServices[arguments.type]>
	</cfif>
	<cfreturn local.returnData>
</cffunction>

<cffunction name="dateMask" output="false" returntype="string">
	<cfargument name="dateToMask" required="true" type="date">
	<cfset var maskedDate = "">
	<cfset maskedDate = dateFormat(arguments.dateToMask,"MM/DD/YYYY") & " " & timeFormat(arguments.dateToMask,"HH:MM:SS")>
	<cfreturn maskedDate>
</cffunction>

<cffunction name="loadObject" output="true" returntype="any" access="public" description="loads the object">
	<cfargument name="objectName" type="string" required="true">
	<cfargument name="objectPath" type="string" required="true">
	<cfargument name="objectType" type="string" required="true">
	<cfset var local = structNew()>
	<cfif this.settings.getCache() IS true>
		<cfif checkCache(arguments.objectName,arguments.objectType) IS false>
			<cflock name="objectLock" timeout="10" throwontimeout="true">
				<cfset application.factory55[arguments.objectType][UCASE(arguments.objectName)] = createObject("component",arguments.objectPath)>
				<cfset initObject(application.factory55[arguments.objectType][UCASE(arguments.objectName)])>
				<cfset local.dateName = UCASE(arguments.objectName) & "_date">
				<cfset application.factory55[arguments.objectType][local.dateName] = dateMask(now())>
			</cflock>
			<cfif this.settings.getFrameworkDebug()>
				<cftrace text="loaded object from CFC #arguments.objectType# #arguments.objectName#">
			</cfif>
		<cfelse>
			<cfif this.settings.getFrameworkDebug()>
				<cftrace text="loaded object from reference #arguments.objectType# #arguments.objectName#">
			</cfif>
		</cfif>
		<cfset local.object = application.factory55[arguments.objectType][UCASE(arguments.objectName)]>
		
	<cfelse>
		<cfset local.object = createObject("component",arguments.objectPath)>
	</cfif>
	<cfreturn local.object>
</cffunction>

<cffunction name="checkCache" output="false" returntype="boolean" access="public">
	<cfargument name="objectName" type="string" required="true">
	<cfargument name="objectType" type="string" required="true">
	<cfset var local = structNew()>
	<cfset local.foundObject = false>
	<cfif isDefined("application") AND structKeyExists(application,"factory55") AND structKeyExists(application.factory55[arguments.objectType],UCASE(arguments.objectName))>
		<cfif this.settings.getIsProduction() IS false>
			<cfif this.settings.getFrameworkDebug()>
				<cftrace text="Checking #arguments.objectName# in cache because this is not production">
			</cfif>	
			<!--- check object age --->
			<cfset local.dateName = UCASE(arguments.objectName) & "_DATE">			
			<cfset local.objectDate = application.factory55[arguments.objectType][local.dateName]>
			<cfset local.objectFileName = arguments.objectName & ".cfc">
			<cfset local.objectList = listObjects(arguments.objectType,local.objectFileName)>
			<cfif dateCompare(local.objectList[UCASE(arguments.objectName)].date,local.objectDate) IS 1>
				<cfset local.foundObject = false>
			<cfelse>
				<cfset local.foundObject = true>
			</cfif>
			<cfif this.settings.getFrameworkDebug()>
				<cftrace text="#arguments.objectName# objectList = #local.objectList[UCASE(arguments.objectName)].date#">
				<cftrace text="#arguments.objectName# cache = #local.objectDate#">
			</cfif>
		<cfelse>
			<cfset local.foundObject = true>
		</cfif>
	</cfif>
	<cfif this.settings.getFrameworkDebug()>
		<cftrace text="#arguments.objectName# cache check was #local.foundObject#">
	</cfif>
	<cfreturn local.foundObject>
</cffunction>

<cffunction name="getObject" output="false" returntype="any" access="public">
	<cfargument name="objectName" type="string" required="true">
	<cfargument name="objectType" type="string" required="true">
	<cfset var local = structNew()>
	<cfif this.settings.getFrameworkDebug()>
		<cftrace text="#arguments.objectName# loaded">
	</cfif>
	<cfif checkCache(arguments.objectName,arguments.objectType) IS false>
		<!--- reload object --->
		<cfset local.objectReturn = loadObjects(arguments.objectType,arguments.objectName)>
	<cfelse>
		<cfset local.objectReturn = application.factory55[arguments.objectType][UCASE(arguments.objectName)]>
	</cfif>
	<cfreturn local.objectReturn>
</cffunction>

<cffunction name="getParams" output="false" access="public" returntype="struct">
	<cfset var local = structNew()>
	<cfif this.settings.getFrameworkDebug()>
		<cftrace text="created params from url and form scope">
	</cfif>
	<cfset local.params = structNew()>
	<cfset structAppend(local.params,url,true)>
	<cfset structAppend(local.params,form,true)>
	<cfreturn local.params>
</cffunction>

<cffunction name="getControllerAndAction" output="false" access="public" returntype="struct">
	<cfargument name="params" type="struct" required="true">
	<cfset var local = structNew()>
	<cfset local.returnStruct.controller 	= this.settings.getConfig("defaultController")>
	<cfset local.returnStruct.action		= this.settings.getConfig("defaultAction")>
	<cfif structKeyExists(arguments.params,"action")>
		<cfif listLen(arguments.params.action,".") IS 2>
			<cfset local.returnStruct.controller 	= listGetAt(arguments.params.action,1,".")>
			<cfset local.returnStruct.action		= listGetAt(arguments.params.action,2,".")>
			<cfif this.settings.getFrameworkDebug()>
				<cftrace text="the controller is set to #local.returnStruct.controller#">
				<cftrace text="the action is set to #local.returnStruct.action#">
			</cfif>
		<cfelseif listLen(arguments.params.action,".") IS 1>
			<cfset local.returnStruct.controller 	= arguments.params.action>
			<cfif this.settings.getFrameworkDebug()>
				<cftrace text="the controller is set to #local.returnStruct.controller#">
			</cfif>
		</cfif>
	</cfif>
	<cfset request.factory55.controller = duplicate(local.returnStruct.controller)>
	<cfset request.factory55.action		= duplicate(local.returnStruct.action)>
	<cfif this.settings.getFrameworkDebug()>
		<cftrace text="controller set to #local.returnStruct.controller# and the action set to #local.returnStruct.action#">
	</cfif>
	<cfreturn local.returnStruct>
</cffunction>

<!------------------------------------------------------------------------->
<!--- public functions ---------------------------------------------------->
<!------------------------------------------------------------------------->

<cffunction name="processRequest" output="true" returntype="any">
	<cfset var local = structNew()>
	<!--- check to see if the app is running --->
	<cfif checkSetupComplete() IS false>
		<cfthrow type="factory55.error" detail="The applicaion is not setup. Please run the init or setup methods before the processRequest">
	</cfif>
	<cfset local.rc			= structNew()>
	<cfset local.rc.params	= getParams()>
	<cfset local.actionInfo = getControllerAndAction(local.rc.params)>
	
	<cfset local.controllerObject = getController(local.actionInfo.controller)>
	<cfif structKeyExists(local.controllerObject,local.actionInfo.action)>
		<cfsavecontent variable="local.content">

			
			<!------------------------------------------------------------->
			<!--- onRequestStart ------------------------------------------>
			<cfif checkCache("ApplicationController","controllers") IS true>
				<cfset local.applicationController = getController("ApplicationController")>
				<cfif structKeyExists(local.applicationController,"onRequestStart")>
					<cfinvoke component="#local.applicationController#" method="onRequestStart">
						<cfinvokeargument name="rc" value="#local.rc#">
					</cfinvoke>	
				</cfif>
			</cfif>
			<!--- onRequestStart ------------------------------------------>
			<!------------------------------------------------------------->


			<!------------------------------------------------------------->
			<!--- onControllerStart --------------------------------------->				
			<cfif structKeyExists(local.controllerObject,"onControllerStart")>
				<cfinvoke component="#local.controllerObject#" method="onControllerStart">
					<cfinvokeargument name="rc" value="#local.rc#">
				</cfinvoke>
			</cfif>
			<!--- onControllerStart --------------------------------------->				
			<!------------------------------------------------------------->


			<!------------------------------------------------------------->
			<!--- Action -------------------------------------------------->				
			<cfinvoke component="#local.controllerObject#" method="#local.actionInfo.action#">
				<cfinvokeargument name="rc" value="#local.rc#">
			</cfinvoke>
			<!--- Action -------------------------------------------------->				
			<!------------------------------------------------------------->


			<!------------------------------------------------------------->
			<!--- onControllerEnd --------------------------------------->				
			<cfif structKeyExists(local.controllerObject,"onControllerEnd")>
				<cfinvoke component="#local.controllerObject#" method="onControllerEnd">
					<cfinvokeargument name="rc" value="#local.rc#">
				</cfinvoke>
			</cfif>
			<!--- onControllerEnd --------------------------------------->				
			<!------------------------------------------------------------->


			<!------------------------------------------------------------->
			<!--- onRequestEnd -------------------------------------------->				
			<cfif structKeyExists(local,"applicationController")>
				<cfif structKeyExists(local.applicationController,"onRequestEnd")>
					<cfinvoke component="#local.applicationController#" method="onRequestEnd">
						<cfinvokeargument name="rc" value="#local.rc#">
					</cfinvoke>	
				</cfif>
			</cfif>
			<!--- onRequestEnd -------------------------------------------->				
			<!------------------------------------------------------------->
			
	
		</cfsavecontent>
		<cfoutput>#local.content#</cfoutput>
	<cfelse>
		<cfthrow type="factory55.error" detail="The action #local.actionInfo.action# was not found in the #local.actionInfo.controller# controller">	
	</cfif>
</cffunction>

<cffunction name="getEnum" output="false" returntype="any">
	<cfargument name="enumName" type="string" required="true">
	<cfreturn getObject(arguments.enumName,"enums")>
</cffunction>

<cffunction name="getDomain" output="false" returntype="any">
	<cfargument name="domainName" type="string" required="true">
	<cfreturn getObject(arguments.domainName,"domain")>
</cffunction>

<cffunction name="getService" output="false" returntype="any">
	<cfargument name="serviceName" type="string" required="true">
	<cfreturn getObject(arguments.serviceName,"services")>
</cffunction>

<cffunction name="getController" output="false" returntype="any">
	<cfargument name="controllerName" type="string" required="true">
	<cfif not findNoCase("controller",arguments.controllerName)>
		<cfset arguments.controllerName = arguments.controllerName & "Controller">
	</cfif>
	<cfreturn getObject(arguments.controllerName,"controllers")>
</cffunction>

<cffunction name="getBean" output="false" returntype="any">
	<cfargument name="beanName" type="string" required="true">
	<cfreturn duplicate(getObject(arguments.beanName,"beans"))>
</cffunction>

<cffunction name="newBean" output="false" returntype="any">
	<cfargument name="beanName" type="string" required="true">
	<cfreturn getBean(arguments.beanName)>
</cffunction>

<!------------------------------------------------------------------------->
<!--- public functions ---------------------------------------------------->
<!------------------------------------------------------------------------->
