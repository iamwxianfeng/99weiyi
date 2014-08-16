(function(){
  W.ns("Chima.Admin");

  Chima.Admin = {
    newModel: function(){
      var html = "<tr>" + $("#models tr:last").html() + "</tr>";
      $("#models tr:visible:last").after(html);
    },
    // 更换 下拉框的options
    // select => select jquery object
    // newOptions => { key: value }
    changeUpSizeCategory: function(select,newOptions){
      var $select = select;
      var options;
      if($select.prop) {
        options = $select.prop('options');
      }
      else {
        options = $select.attr('options');
      }
      $('option', $select).remove();
      $.each(newOptions, function(val, text) {
        options[options.length] = new Option(text, val);
      });
    }

  };

// 设为量体师
  $(".set_measure").click(function(e){
    e.preventDefault();
    var url = $(this).attr("href");
    var tr = $(this).parents('tr');
    $.ajax({
      url: url,
      dataType: 'json',
      type: 'post',
      data: { role_id: 1 },
      success: function(data){
        if (data.ret_code ==1){
          tr.remove();
        }
      }
    });
  });

//设为管理员
   $(".set_admin").click(function(e){
    e.preventDefault();
    var url = $(this).attr("href");
    var tr = $(this).parents('tr');
    $.ajax({
      url: url,
      dataType: 'json',
      type: 'post',
      data: { role_id: 2 },
      success: function(data){
        if (data.ret_code ==1){
          tr.remove();
        }
      }
    });
  });

})();

