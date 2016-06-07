(function() {
    tinymce.create('tinymce.plugins.FUpload', {
      init : function(ed, url) {
        ed.addCommand('mceFUpload', function() {
          ed.windowManager.open({
            file : url + '/dialog.htm', //sciezka z zawartoscia okna
            width : 560,
            height : 400
          });
        });

        ed.addButton('fupload', {
          title : 'Wstaw kod na strone',
          cmd : 'mceFUpload',
          image : url + '/img/fupload.png'
        });
      }
    });

    tinymce.PluginManager.add('fupload', tinymce.plugins.FUpload);
})();