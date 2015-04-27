<!---
This assumes that you have a mapping to ColdDoc or you have a colddoc folder in the root of your site.
 --->
<cfscript>
	generatePath = "/docs";	

	colddoc = createObject("component", "colddoc.ColdDoc").init();

	strategy = createObject("component", "colddoc.strategy.api.HTMLAPIStrategy").init(expandPath(generatePath), "MyApplication : Factory55 - 0.1");
	colddoc.setStrategy(strategy);
	variables.documentArray = arrayNew(1);
	variables.documentArray[1] = {inputDir=expandPath("/com"),inputMapping="com"};
	variables.documentArray[2] = {inputDir=expandPath("/app"),inputMapping="app"};
	colddoc.generate(variables.documentArray);
</cfscript>

<cfoutput>
<h1>Done!</h1>
<a href="#generatePath#">Documentation</a>
</cfoutput>