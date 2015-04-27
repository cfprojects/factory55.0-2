<cfcomponent extends="com.factory55.core.baseDomain" output="false">

	<cffunction name="getCategories" output="false" returntype="query">
		<cfset var local = structNew()>
		<cfquery datasource="#this.settings.datasource#" name="local.categories">
			SELECT
				id,
				name,
				alias
			FROM 
				categories
			ORDER BY
				name
		</cfquery>
		<cfreturn local.categories>
	</cffunction>

	<cffunction name="getCategoryByAlias" output="false" returntype="app.beans.com.blayter.blog.categoryBean">
		<cfargument name="alias" type="string">
		<cfset var local = structNew()>
		<cfset local.categoryBean = newBean("categoryBean")>
		<cfquery datasource="#this.settings.datasource#" name="local.category">
			SELECT
				id,
				name,
				alias
			FROM 
				categories
			WHERE
				alias = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.alias#">
		</cfquery>
		<cfscript>
			local.categoryBean.setId(local.category.id);
			local.categoryBean.setName(local.category.name);
			local.categoryBean.setAlias(local.category.alias);
		</cfscript>
		<cfreturn local.categoryBean>
	</cffunction>

</cfcomponent>