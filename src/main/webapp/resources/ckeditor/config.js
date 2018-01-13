/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.toolbar = [['Font', 'FontSize']
			    ,['BGColor', 'TextColor']
			    ,['Bold', 'Italic', 'Strike', 'Superscript', 'Subscript', 'Underline', 'RemoveFormat']
			    ,['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
			    ,['NumberedList', 'BulletedList']
		];

	config.protectedSource.push( /<ins[\s|\S]+?<\/ins>/g);
	config.allowedContent = true;

	config.language = 'ko';
    config.filebrowserUploadUrl = '/common/attachFileEditor?fileType=image';
    config.filebrowserImageUploadUrl = '/common/attachFileEditor?fileType=image';
    config.filebrowserFlashUploadUrl = '/common/attachFileEditor?fileType=flash';

    config.extraPlugins = 'autogrow,colordialog,tableresize';
    config.autoGrow_minHeight = 300;
    config.autoGrow_maxHeight = 600;
    config.enterMode = CKEDITOR.ENTER_BR;
    config.fillEmptyBlocks = false;

    // Rails CSRF token
    config.filebrowserParams = function(){
    	var	csrf_token = document.getElementById('csrf_token').value,
      	  	csrf_param = document.getElementById('csrf_param').value,
      	  	params = new Object();

    	var editorType;
    	try {
    		editorType = document.getElementById('editorType').value;
    	}catch (e) {

    	}


    	//console.log('csrf_token === ' + csrf_token);
    	//console.log('csrf_param === ' + csrf_param);

    	if (csrf_param !== undefined && csrf_token !== undefined) {
    		params[csrf_param] = csrf_token;
    	}

    	if (editorType !== undefined) {
    		params["editorType"] = editorType;
    	}
    	return params;
    };

    config.addQueryString = function( url, params ){
    	var queryString = [];

    	if ( !params ) {
    		return url;
    	} else {
    		for ( var i in params )
    			queryString.push( i + "=" + encodeURIComponent( params[ i ] ) );
       	}
    	//console.log('csrf_url === ' + url + ( ( url.indexOf( "?" ) != -1 ) ? "&" : "?" ) + queryString.join( "&" ));
    	return url + ( ( url.indexOf( "?" ) != -1 ) ? "&" : "?" ) + queryString.join( "&" );
    };

    // Integrate Rails CSRF token into file upload dialogs (link, image, attachment and flash)
    CKEDITOR.on( 'dialogDefinition', function( ev ){
    	// Take the dialog name and its definition from the event data.
    	var dialogName = ev.data.name;
    	var dialogDefinition = ev.data.definition;
    	var content, upload;

    	if (CKEDITOR.tools.indexOf(['link', 'image', 'attachment', 'flash'], dialogName) > -1) {
    		content = (dialogDefinition.getContents('Upload') || dialogDefinition.getContents('upload'));
    		upload = (content == null ? null : content.get('upload'));

    		if (upload && upload.filebrowser && upload.filebrowser['params'] === undefined) {
    			upload.filebrowser['params'] = config.filebrowserParams();
    			upload.action = config.addQueryString(upload.action, upload.filebrowser['params']);
    		}
    	}
    });

    CKEDITOR.dtd.$removeEmpty['i'] = false;

    /*
     * img style change
     */
    CKEDITOR.on('instanceReady', function (ev) {
    	ev.editor.dataProcessor.htmlFilter.addRules({
	        elements:{
	            $: function (element) {
	                if (element.name == 'img') {
	                	/*
	                    var style = element.attributes.style;

	                    if (style) {
	                        var match = /(?:^|\s)width\s*:\s*(\d+)px/i.exec(style),
	                            width = match && match[1];

	                        match = /(?:^|\s)height\s*:\s*(\d+)px/i.exec(style);
	                        var height = match && match[1];

	                        if (width) {
	                            element.attributes.style = element.attributes.style.replace(/(?:^|\s)width\s*:\s*(\d+)px;?/i, '');
	                            element.attributes.width = width;
	                        }

	                        if (height) {
	                            element.attributes.style = element.attributes.style.replace(/(?:^|\s)height\s*:\s*(\d+)px;?/i, '');
	                            element.attributes.height = height;
	                        }
	                    }
	                    */
		                if (element.attributes.style)
		                    delete element.attributes.style;
		                if (element.attributes.width)
		                    delete element.attributes.width;
		                if (element.attributes.height)
		                    delete element.attributes.height;
	                }

	                return element;
	            }
	        }
	    });
	});

};
