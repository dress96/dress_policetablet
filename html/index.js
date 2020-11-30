$(function () {
    /*function SetTablet(bool)
    {
        if (bool) {
            $("#content").show();
        } else {
            $("#content").hide();
        }
    }
    SetTablet(false);
    window.addEventListener("message",function(event)
    {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                SetTablet(true);
            } else {
                SetTablet(false);
            }
        }

    })

    document.onkeyup = function(data) {
        if (data.which == 27 ) 
        {
            $.post("http://stahl_policetablet/exit", JSON.stringify({}));
            return;
        }
    }*/
    $("#new-file input").keyup(function() {
        var form = $(this).parents("#new-file");
        var check = checkInput(form);
        if(check) {
            $("#createhistory").prop("disabled", false);
        }
        else {
            $("#createhistory").prop("disabled", true);
        }
    });
    $('.menu li:has(ul)').click(function(){
        if($(this).hasClass('active')) {
            $(this).removeClass('active');
            $(this).children('ul').slideUp();
        } else {        
            $('.menu li ul').slideUp();       
            $('.menu li').removeClass('active');
            $(this).addClass('active');
            $(this).children('ul').slideDown();
        }
    });
    $('#main-menu a').click(function(event){
        var url = $(this).attr("href");
        if (url != "#")
        {
            $('#main-page > .header-active').removeClass('header-active');
            url = url.replace('#','.');
            $(url).addClass('header-active');
        }
    });
});

  $('#createhistory').click(function(event) {
      event.preventDefault();

      let criminalNameValue = $('#name').val();
      let phoneNumberValue = $('#phone').val();
      let assentValue = $('#assent').val();
      let crimeInformationValue = $('#crimeinformation').val();
      let extraComentaryValue = $('#extracomentary').val();

      $.post("http://stahl_policetablet/add-history", JSON.stringify({
          criminalName: criminalNameValue,
          phoneNumber: phoneNumberValue,
          assent: assentValue,
          crimeInformation: crimeInformationValue,
          extraComentary: extraComentaryValue
      }));

      $('.new-tab').css("display","none");
      $('.criminal-history').css("display","block"); // Change when it create the criminal record in the table
  });

  function checkInput(obj) {
    var inputfill = true;
    obj.find("input").each(function() {
    var $this = $(this);
        if( $this.val().length <= 0 ) {
            inputfill = false;
            return false;
        }
    });
    if(inputfill == false) {
        return false;
    }
    else {
        return true;
    }
}