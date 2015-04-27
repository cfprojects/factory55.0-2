<cfcomponent output="false">

	<cffunction name="onInit">
		<cfset convertPropertiesToThis()>
	</cffunction>

	<cffunction name="onMissingMethod" output="false">
		<cfargument name="MissingMethodName" type="string" required="true">
		<cfargument name="MissingMethodArguments" type="struct" required="true">
		<cfset var local = structNew()>
		<cfset local.variableName = getThisName(arguments.missingMethodName)>
		<cfif NOT structKeyExists(this,local.variableName)>
			<cfthrow type="factory55.error" detail="#local.variableName# has not been defined as a property in the bean">
		<cfelse>
			<cfif left(arguments.missingMethodName,3) IS "get">
				<cfreturn this[local.variableName]>
			<cfelseif left(arguments.missingMethodName,3) IS "set">
				<cfset this[local.variableName] = arguments.missingMethodArguments.1>
				<cfreturn/>			
			<cfelse>
				<cfthrow type="factory55.error" detail="#arguments.missingMethodName# is not a getter or setter">
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="getThisName" access="private" output="false" description="Converts the setter or getter name to the THIS name">
		<cfargument name="missingMethodName" type="string" required="true">
		<cfreturn replaceList(arguments.missingMethodName,"get,set",",")>
	</cffunction>

	<cffunction name="convertPropertiesToThis" access="private" output="false" description="Converts properties into THIS scope">
		<cfset var local = structNew()>
		<cfset local.properties = getMetaData(this).properties>
		<cfloop from="1" to="#arrayLen(local.properties)#" index="local.i">
			<cfset local.property	= local.properties[local.i]>
			<cfset local.paramName = ucase(local.property.name)>
			<cfif structKeyExists(local.property,"default")>
				<cfset this[local.paramName] = local.property.default>
			<cfelse>
				<cfswitch expression="#local.properties[local.i].type#">
					<cfcase value="string">
						<cfset this[local.paramName] = "">
					</cfcase>
					<cfcase value="boolean">
						<cfset this[local.paramName] = false>
					</cfcase>
					<cfcase value="numeric">
						<cfset this[local.paramName] = 0>
					</cfcase>
					<cfcase value="struct">
						<cfset this[local.paramName] = structNew()>
					</cfcase>
					<cfcase value="array">
						<cfset this[local.paramName] = arrayNew(1)>
					</cfcase>
				</cfswitch>
			</cfif>
		</cfloop>
	</cffunction>
	
</cfcomponent>