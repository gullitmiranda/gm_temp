/**
 * @license Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
  // Define changes to default configuration here. For example:
  config.language = 'pt-br';
  // Cor da interface do editor
  config.uiColor = '#FAFAFA';

  // PLUGINS - Seleção personalizada.
  config.plugins = 'dialogui,dialog,a11yhelp,basicstyles,bidi,blockquote,clipboard,button,panel,floatpanel,colorbutton,colordialog,templates,menu,contextmenu,resize,toolbar,elementspath,list,indent,enterkey,entities,popup,filebrowser,fakeobjects,floatingspace,listblock,richcombo,font,format,htmlwriter,horizontalrule,wysiwygarea,image,justify,link,liststyle,magicline,maximize,pagebreak,pastetext,pastefromword,preview,print,removeformat,save,selectall,showblocks,showborders,sourcearea,specialchar,menubutton,scayt,stylescombo,tab,table,tabletools,undo,wsc';

  /* Filebrowser routes */
  /* The location of an external file browser, that should be launched when "Browse Server" button is pressed. */
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";

  // The location of a script that handles file uploads in the Flash dialog.
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";

  // The location of a script that handles file uploads in the Image dialog.
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";

  // The location of a script that handles file uploads.
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";

  // Rails CSRF token
  config.filebrowserParams = function(){
    var csrf_token, csrf_param, meta,
        metas = document.getElementsByTagName('meta'),
        params = new Object();

    for ( var i = 0 ; i < metas.length ; i++ ){
      meta = metas[i];

      switch(meta.name) {
        case "csrf-token":
          csrf_token = meta.content;
          break;
        case "csrf-param":
          csrf_param = meta.content;
          break;
        default:
          continue;
      }
    }

    if (csrf_param !== undefined && csrf_token !== undefined) {
      params[csrf_param] = csrf_token;
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

    return url + ( ( url.indexOf( "?" ) != -1 ) ? "&" : "?" ) + queryString.join( "&" );
  };

  /* Integrate Rails CSRF token into file upload dialogs (link, image, attachment and flash) */
  CKEDITOR.on( 'dialogDefinition', function( ev ){
    // Take the dialog name and its definition from the event data.
    var dialogName = ev.data.name;
    var dialogDefinition = ev.data.definition;
    var content, upload;

    if (CKEDITOR.tools.indexOf(['link', 'image', 'attachment', 'flash'], dialogName) > -1) {
      content = (dialogDefinition.getContents('Upload') || dialogDefinition.getContents('upload'));
      upload = (content == null ? null : content.get('upload'));

      if (upload && upload.filebrowser['params'] == null) {
        upload.filebrowser['params'] = config.filebrowserParams();
        upload.action = config.addQueryString(upload.action, upload.filebrowser['params']);
      }
    }
  });

  /* The toolbar groups arrangement, optimized for two toolbar rows. */
  config.toolbarGroups = [
    { name: 'document',    groups: [ 'mode', 'document', 'doctools' ] },
    { name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
    { name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
    { name: 'links' },
    { name: 'insert' },
    { name: 'forms' },
    { name: 'tools' },
    { name: 'others' },
    '/',
    { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
    { name: 'styles' },
    { name: 'colors' },
    { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align' ] },
    { name: 'about' }
  ];

  // Remove some buttons, provided by the standard plugins, which we don't
  // need to have in the Standard(s) toolbar.
  // config.removeButtons = 'Underline,Subscript,Superscript';
};
