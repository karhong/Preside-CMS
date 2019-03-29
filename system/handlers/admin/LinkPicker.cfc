component extends="preside.system.base.AdminHandler" {

	property name="presideObjectService" inject="presideObjectService";
	property name="linkPickerConfig"     inject="coldbox:setting:ckeditor.linkPicker";

	function index( event, rc, prc ) {
		var configCat = rc.linkPickerCategory ?: "default";
		if ( !linkPickerConfig.keyExists( configCat ) ) {
			configCat = "default";
		}

		prc.linkTypes = linkPickerConfig[ configCat ].types ?: [ "sitetreelink", "url", "email", "asset", "anchor" ];

		event.setLayout( "adminModalDialog" );
		event.setView( "admin/linkPicker/index" );
	}

	function getDefaultLinkText( event, rc, prc ) {
		var linkType = rc.type ?: "";
		var linkText = "";
		try {
			linkText = renderViewlet( event="admin.linkpicker.#linkType#.getDefaultLinkText", args=event.getCollectionWithoutSystemVars() );
		} catch( any e ) {
			linkText = "";
		}

		linkText = IsSimpleValue( local.linkText ?: {} ) ? linkText : "";

		event.renderData( data=linkText, type="text" );
	}

	function quickAddForm( event, rc, prc ) {
		if ( !hasCmsPermission( permissionKey="presideobject.link.add" ) ) {
			event.adminAccessDenied();
		}

		event.include( "/js/admin/specific/linkpicker/" );
		event.include( "/js/admin/specific/datamanager/quickAddForm/" );
		event.include( "/css/admin/specific/quickLinkForms/" );
		event.setView( view="/admin/linkpicker/quickAddForm", layout="adminModalDialog" );
	}

	function quickEditForm( event, rc, prc ) {
		var id     = rc.id     ?: "";

		if ( !hasCmsPermission( permissionKey="presideobject.link.edit" ) ) {
			event.adminAccessDenied();
		}

		prc.record = presideObjectService.selectData( objectName="link", filter={ id=id }, useCache=false );
		if ( prc.record.recordCount ) {
			prc.record = queryRowToStruct( prc.record );
		} else {
			prc.record = {};
		}

		event.include( "/js/admin/specific/linkpicker/" );
		event.include( "/js/admin/specific/datamanager/quickEditForm/" );
		event.include( "/css/admin/specific/quickLinkForms/" );
		event.setView( view="/admin/linkpicker/quickEditForm", layout="adminModalDialog" );
	}

}