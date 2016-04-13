<cfscript>
	crumbs      = event.getAdminBreadCrumbs();
	nCrumbs     = ArrayLen( crumbs );
	environment = controller.getSetting( "environment" );	
</cfscript>

<cfoutput>
	<div id="breadcrumbs" class="breadcrumbs">
		<script type="text/javascript">
			try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
		</script>

		<cfif environment NEQ "live">
			<div class="row">
				<p class="text-center alert alert-danger">#translateResource( "cms:environment.alert" )#</p>
			</div>
		</cfif>
		<ul class="breadcrumb">
			<cfloop from="1" to="#nCrumbs#" index="i">
				<li<cfif i eq nCrumbs> class="active"</cfif>>
					<cfif i eq 1>
						<i class="fa fa-home"></i>
					</cfif>
					<cfif i eq nCrumbs>
						#crumbs[i].title#
					<cfelse>
						<a href="#crumbs[i].link#"<cfif i eq nCrumbs-1> data-global-key="u"</cfif>>#crumbs[i].title#</a>
					</cfif>
				</li>
			</cfloop>
		</ul>
	</div>
</cfoutput>