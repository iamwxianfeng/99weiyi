$(function(){
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
        if (data.retCode ==1){
          alert('操作成功');
          tr.remove();
        }else{
          alert('操作失败');
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
        if (data.retCode ==1){
          alert('操作成功');
          tr.remove();
        }else{
          alert('操作失败');
        }
      }
    });
  });

});
