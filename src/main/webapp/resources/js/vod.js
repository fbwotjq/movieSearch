$(document).ready(function(){
	
	if ( $("#wrap").width() > 1000 )
		$(".vod-movie .textBg").css("margin-left", ($("#wrap").width()-$(".footer-wrap").width())/2);
	else
		$(".vod-movie .textBg").css("margin-left", "0");
	$(window).on("load resize", function(){
		if ( $("#wrap").width() > 1000 )
			$(".vod-movie .textBg").css("margin-left", ($("#wrap").width()-$(".footer-wrap").width())/2);
		else
			$(".vod-movie .textBg").css("margin-left", "0");
	});
	
	/* slider */
	var fixOwl = function(){
        var $stage = $('.owl-stage'),
            stageW = $stage.width(),
            $el = $('.owl-item'),
            elW = 0;
        $el.each(function() {
            elW += $(this).width()+ +($(this).css("margin-right").slice(0, -2))
        });
        if ( elW > stageW ) {
            $stage.width( elW );
        };
    }
	$('#vod-visual-menu1').owlCarousel({
		loop:false,
		nav: true,
		dots:false,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		responsive : {
			0:{
				margin:5,
				autoWidth:170,
				items:2
			},
			1024:{
				margin:60,
				autoWidth:353,
				items:2
			},
			1280:{
				margin:60,
				autoWidth:353,
				items:3
			}
		}
	})
	$('#vod-movie-menu1, #vod-movie-menu1_1').owlCarousel({
		loop:false,
		nav: false,
		dots:false,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		responsive : {
			0:{
				margin:20,
				autoWidth:true
			},
			1024:{
				margin:30,
				autoWidth:true
			}
		}
	})
	$('#division-tab-menu1').owlCarousel({
		loop:false,
		nav: false,
		dots:false,
		autoWidth:true
	})
	$('#division-tab-menu2').owlCarousel({
		loop:false,
		nav: false,
		dots:false,
		autoWidth:true
	})
	$('#division-tab-menu3').owlCarousel({
		loop:false,
		nav: false,
		dots:false,
		autoWidth:true
	})
	/* //slider */

	if ( $(".mImage7").length )
	{
		$(".mImage7 li").each(function(e){
			if ( e == 0  || e == 1 | e == 2 | e == 3 )
			{
				$(this).addClass("pt0");
			}
		});
	}

});
