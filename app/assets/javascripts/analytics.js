$(document).ready(function(){

    $.get("/analytics/tweets",function(data){
      if ($(".user-info").length)
        {
           var tweets =data.tweets
           $(".list-loading").hide();
            $(".list-holder").show();
           $.each(tweets,function(idx,value){


                  var divToAppend= "<li style='float:left;background-color:#fff;width:200px;height:200px; margin-left:10px; margin-bottom:10px;display: inline-block;'><a href='https://twitter.com/"+value.user.username+"/status/"+value.id+"'>"+value.tweet_text+"</a></li>"

                  $('.list-holder').append(divToAppend);
            });
           $.get("analytics/topuser",function(data){
                        var user = data.top_user;
                        var userDiv = "<div class='col-xs-12 text-center'><div class='row'><img height='100' width='100' src="+user.profile_image+"></div><div class='row' style='margin-top:20px;'><a href=https://twitter.com/@"+user.username+">"+user.name+"</a></div></div>";
                        $(".top-user").append(userDiv);
                        $(".top-user").show();
                        $(".user-loading").hide();

                        $.get("analytics/topdomains",function(data){

                            $(".domain-loading").hide();
                            $(".top-domains").show();
                            var domains = data.domains;
                            $.each(domains,function(idx,value){
                                    var fontSize =(domains.length-idx)*5;
                                    if (fontSize<=15)
                                      {
                                        fontSize=15;
                                      }
                                    var listToAppend= "<li style='display: inline-block;font-size:"+fontSize+"px'>"+value+"</li><br>";
                                    $('.top-domains').append(listToAppend);



                            });




                        });
                    });
        }

    });

});
