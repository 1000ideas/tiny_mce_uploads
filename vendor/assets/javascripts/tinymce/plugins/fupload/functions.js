//
//= require tinymce/tiny_mce_popup
//= require tinymce/utils/mctabs
//= require tinymce/utils/form_utils
//= require jquery
//

function doInsert(src){
  var html = '<img src="'+src+'" />';
  tinyMCEPopup.editor.execCommand('mceInsertContent', false, html);
  tinyMCEPopup.close();
  return false;
}

function doInsertLink(src, name){
  var html = '<a href="'+src+'">'+name+'</a>';
  tinyMCEPopup.editor.execCommand('mceInsertContent', false, html);
  tinyMCEPopup.close();
  return false;
}

