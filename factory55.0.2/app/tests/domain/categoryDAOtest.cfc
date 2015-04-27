<cfcomponent extends="com.factory55.core.baseMxUnit" description="Base Test that all test for the Factory55 framework extends">
	
	<cffunction name="getCategories" returntype="void" access="public">
		<cfset var local = structNew()>
		<cfset local.categoryDAO = getService("blogService")>
		<cfset local.categories = local.categoryDAO.getCategories()>
		<cfset assertIsQuery(local.categories)>
	</cffunction>
	
</cfcomponent>