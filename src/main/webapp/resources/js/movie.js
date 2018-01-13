$(document).ready(function(){
	$(window).on("load resize", function(){
		if ( $(".mWork").length > 0)
		{
			$(".mWork .text").css("margin-top", -($(".mWork .text").height()/2));
		}
	});
	
	$(".mMTab1 .list .sel a").on("click", function(){
		if ( $(this).parent().next(".ls").height() > 0 )
		{
			$(this).parent().next(".ls").animate({"height": "0"});
			$(this).removeClass("selected");
		}
		else
		{
			$(".mMTab1 .list .ls").css("height","0");
			$(this).parent().next(".ls").animate({"height": $(this).parent().next().children("ul").innerHeight() });
			$(this).addClass("selected");
		}

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
	$('#movie-endpublish-menu').owlCarousel({
		loop:false,
		nav: false,
		dots:false,
	    responsive:{
			0:{
				margin:18,
				autoWidth:true
			},
			1024:{
				margin:10,
				autoWidth:true
			}
		}
	})
	$('#movie-recomd-carousel').owlCarousel({
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
				margin:30,
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
	$('#movie-image4-carousel').owlCarousel({
		loop:false,
		nav: true,
		dots:false,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		responsive : {
			0:{
				margin:5,
				autoWidth:170
			}
		}
	})
	/* //slider */

});
