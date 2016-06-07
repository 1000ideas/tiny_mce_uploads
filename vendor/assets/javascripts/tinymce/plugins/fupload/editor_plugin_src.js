(function() {
    tinymce.create('tinymce.plugins.FUpload', {
      init : function(ed, url) {
        ed.addCommand('mceFUpload', function() {
          ed.windowManager.open({
            file : '/tiny_mce_uploads/attachments/list.html', 
            width : 570,
            height : 400,
	    inline : 1
          });
        });

        ed.addButton('fupload', {
          title : 'Dodaj obrazek/plik do strony',
          cmd : 'mceFUpload',
          image : url + '/img/fupload.png'
        });
      }
    });
    tinymce.PluginManager.add('fupload', tinymce.plugins.FUpload);
})();
