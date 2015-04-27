<!--- $Id: baseEnum.cfc,v 1.1.2.1 2010/07/26 17:09:06 pandleigh Exp $ --->
<cfcomponent hint="base enum" output="false">

	<cfset setBaseSignature("")>
	<cfset variables.cfc.enumArray = arrayNew(1)>

	<cffunction name="addItem" output="false" returntype="void" access="public" description="adds items to the enum collection">
		<cfargument name="key" type="string" required="true">
		<cfargument name="value" type="any" required="false">
		<cfset var local = structNew()>
		<cfset local.keySignature = getBaseSignature() & arguments.key>
		<cfset this[arguments.key] = local.keySignature>
		<cfif structKeyExists(arguments,"value")>
			<cfset this["_" & arguments.key] = arguments.value>
		</cfif>
		<cfset arrayAppend(variables.cfc.enumArray,arguments.key)>
	</cffunction>
	
	<cffunction name="getValue" output="false" access="public" returntype="any" description="gets the value of the enum or a specific value from a complex data type">
		<cfargument name="key" type="string" required="true">
		<cfargument name="complexKeyName" type="string" required="false" hint="If you are storing a complex value for the enum and want a specific item back. Pass the structure key name.">
		<cfset var local = structNew()>
		<cfif structKeyExists(arguments,"complexKeyName")>
			<cfset local.returnValue = this["_" & arguments.key][arguments.complexKeyName]>
		<cfelse>
			<cfif structKeyExists(this,"_" & replace(arguments.key,getBaseSignature(),""))>
				<cfset local.returnValue = this["_" & replace(arguments.key,getBaseSignature(),"")]>
			<cfelse>
				<cfset local.returnValue = this[arguments.key]>
			</cfif>
		</cfif>
		<cfreturn local.returnValue>
	</cffunction>
	
	<cffunction name="getName" output="false" access="public" returntype="any" description="returns the name of the enum without the base signature">
		<cfargument name="key" type="string" required="true">
		<cfreturn replace(arguments.key,getBaseSignature(),"")>
	</cffunction>
	
	<cffunction name="getEnums" output="false" access="public" returntype="struct" description="returns a structure (in a random order) of only the enums and their respective values. No custom methods are returned.">
		<cfset var local = structNew()>
		<cfset local.returnEnums = structNew()>
		<cfloop list="#arrayToList(variables.cfc.enumArray)#" index="local.i">
			<cfset local.returnEnums[local.i] = getValue(local.i)>
		</cfloop>
		<cfreturn local.returnEnums>
	</cffunction>
	
	<cffunction name="toList" output="false" access="public" description="retuns the enum keys in a list in the order that they were added in">
		<cfreturn arrayToList(variables.cfc.enumArray)>
	</cffunction>
	
	<cffunction name="toArray" output="false" access="public" description="returns the enum keys in an array in the order that they were added in">
		<cfreturn variables.cfc.enumArray>
	</cffunction>
	
	<cffunction name="getBaseSignature" access="public" output="false" returntype="string" description="gets the name of the base signature">
		<cfreturn variables.cfc.baseSignature>
	</cffunction>
	
	<cffunction name="setBaseSignature" access="public" output="false" returntype="void" description="gets the name of the base signature">
		<cfargument name="baseSignature" type="string" required="true">
		<cfset variables.cfc.baseSignature = arguments.baseSignature>
	</cffunction>
	
</cfcomponent>