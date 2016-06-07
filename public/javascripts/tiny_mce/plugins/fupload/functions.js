
function doInsert(src){
  var html = '<img src="'+src+'" />';
  tinyMCEPopup.editor.execCommand('mceInsertContent', false, html);
  tinyMCEPopup.close();
  return false;
}

