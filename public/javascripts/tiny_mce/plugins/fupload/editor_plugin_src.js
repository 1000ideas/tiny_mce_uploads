
(function() {
  var each = tinymce.each;

  tinymce.create('tinymce.plugins.TemplatePlugin', {
    init : function(ed, url) {
      var t = this;

      t.editor = ed;

      // Register commands
      ed.addCommand('mceTemplate', function(ui) {
        ed.windowManager.open({
          file : '/tiny_mce_uploads/attachments/new/',
          width : '360px',
          height : '130px',
          inline : 1
        }, {
          plugin_url : url
        });
      });

      ed.addCommand('mceInsertTemplate', t._insertTemplate, t);

      // Register buttons
      ed.addButton('fupload', {title : 'Загрузить файл', cmd : 'mceTemplate', image : url + '/img/fupload.png' });

      ed.onPreProcess.add(function(ed, o) {
        var dom = ed.dom;

        each(dom.select('div', o.node), function(e) {
          if (dom.hasClass(e, 'mceTmpl')) {
            each(dom.select('*', e), function(e) {
              if (dom.hasClass(e, ed.getParam('fupload_mdate_classes', 'mdate').replace(/\s+/g, '|')))
                e.innerHTML = t._getDateTime(new Date(), ed.getParam("fupload_mdate_format", ed.getLang("fupload.mdate_format")));
            });

            t._replaceVals(e);
          }
        });
      });
    },

    getInfo : function() {
      return {
        longname : 'File upload plugin',
        author : 'Alexey Nayden',
        authorurl : 'http://www.evilmartians.ru',
        infourl : 'http://github.com/evilmartians/tinymce_fileupload',
        version : tinymce.majorVersion + "." + tinymce.minorVersion
      };
    },

    _insertTemplate : function(ui, v) {
      var t = this, ed = t.editor, h, el, dom = ed.dom, sel = ed.selection.getContent();

      h = v.content;

      each(t.editor.getParam('fupload_replace_values'), function(v, k) {
        if (typeof(v) != 'function')
          h = h.replace(new RegExp('\\{\\$' + k + '\\}', 'g'), v);
      });

      el = dom.create('div', null, h);

      // Find fupload element within div
      n = dom.select('.mceTmpl', el);
      if (n && n.length > 0) {
        el = dom.create('div', null);
        el.appendChild(n[0].cloneNode(true));
      }

      function hasClass(n, c) {
        return new RegExp('\\b' + c + '\\b', 'g').test(n.className);
      };

      each(dom.select('*', el), function(n) {
        // Replace cdate
        if (hasClass(n, ed.getParam('fupload_cdate_classes', 'cdate').replace(/\s+/g, '|')))
          n.innerHTML = t._getDateTime(new Date(), ed.getParam("fupload_cdate_format", ed.getLang("fupload.cdate_format")));

        // Replace mdate
        if (hasClass(n, ed.getParam('fupload_mdate_classes', 'mdate').replace(/\s+/g, '|')))
          n.innerHTML = t._getDateTime(new Date(), ed.getParam("fupload_mdate_format", ed.getLang("fupload.mdate_format")));

        // Replace selection
        if (hasClass(n, ed.getParam('fupload_selected_content_classes', 'selcontent').replace(/\s+/g, '|')))
          n.innerHTML = sel;
      });

      t._replaceVals(el);

      ed.execCommand('mceInsertContent', false, el.innerHTML);
      ed.addVisual();
    },

    _replaceVals : function(e) {
      var dom = this.editor.dom, vl = this.editor.getParam('fupload_replace_values');

      each(dom.select('*', e), function(e) {
        each(vl, function(v, k) {
          if (dom.hasClass(e, k)) {
            if (typeof(vl[k]) == 'function')
              vl[k](e);
          }
        });
      });
    },

    _getDateTime : function(d, fmt) {
        if (!fmt)
          return "";

        function addZeros(value, len) {
          var i;

          value = "" + value;

          if (value.length < len) {
            for (i=0; i<(len-value.length); i++)
              value = "0" + value;
          }

          return value;
        }

        fmt = fmt.replace("%D", "%m/%d/%y");
        fmt = fmt.replace("%r", "%I:%M:%S %p");
        fmt = fmt.replace("%Y", "" + d.getFullYear());
        fmt = fmt.replace("%y", "" + d.getYear());
        fmt = fmt.replace("%m", addZeros(d.getMonth()+1, 2));
        fmt = fmt.replace("%d", addZeros(d.getDate(), 2));
        fmt = fmt.replace("%H", "" + addZeros(d.getHours(), 2));
        fmt = fmt.replace("%M", "" + addZeros(d.getMinutes(), 2));
        fmt = fmt.replace("%S", "" + addZeros(d.getSeconds(), 2));
        fmt = fmt.replace("%I", "" + ((d.getHours() + 11) % 12 + 1));
        fmt = fmt.replace("%p", "" + (d.getHours() < 12 ? "AM" : "PM"));
        fmt = fmt.replace("%B", "" + this.editor.getLang("fupload_months_long").split(',')[d.getMonth()]);
        fmt = fmt.replace("%b", "" + this.editor.getLang("fupload_months_short").split(',')[d.getMonth()]);
        fmt = fmt.replace("%A", "" + this.editor.getLang("fupload_day_long").split(',')[d.getDay()]);
        fmt = fmt.replace("%a", "" + this.editor.getLang("fupload_day_short").split(',')[d.getDay()]);
        fmt = fmt.replace("%%", "%");

        return fmt;
    }
  });

  // Register plugin
  tinymce.PluginManager.add('fupload', tinymce.plugins.TemplatePlugin);
})();

