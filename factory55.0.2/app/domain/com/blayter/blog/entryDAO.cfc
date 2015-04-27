<cfcomponent extends="com.factory55.core.baseDomain" output="false">

	<cffunction name="getRecentEntries" output="false" returntype="query">
		<cfargument name="maxEntries" type="numeric" required="false" default="10">
		<cfargument name="released" type="boolean" required="false" default="true">
		<cfset var local = structNew()>
		<cfquery datasource="#this.settings.datasource#" name="local.categories">
			SELECT
				id,
				title,
				alias,
				body,
				morebody,
				allowComments,
				released,
				views,
				datePosted
			FROM 
				entries
			WHERE
				1 = 1
				<cfif arguments.released IS true>
						AND
					released = true
				</cfif>
			ORDER BY
				datePosted DESC
		</cfquery>
		<cfreturn local.categories>
	</cffunction>

</cfcomponent>