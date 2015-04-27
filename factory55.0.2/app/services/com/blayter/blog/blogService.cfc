<cfcomponent extends="com.factory55.core.baseService" output="false">
	
	<cffunction name="getCategories">
		<cfset var local = structNew()>
		<cfset local.categoryDAO = getDomain("categoryDAO")>
		<cfreturn local.categoryDAO.getCategories()>
	</cffunction>
	
	<cffunction name="getRecentEntries">
		<cfset var local = structNew()>
		<cfset local.entryDAO = getDomain("entryDAO")>
		<cfreturn local.entryDAO.getRecentEntries(released=true)>
	</cffunction>
	
	
	
</cfcomponent>