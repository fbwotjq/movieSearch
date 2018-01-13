$(document).ready(function(){
	
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
	var serviceTabMenu1 = $('#service-tab-menu1');
	serviceTabMenu1.owlCarousel({
		loop:false,
		dots:false,
		responsive : {
			0:{
				nav: true,
				margin:25,
				autoWidth:true
			},
			1024:{
				nav: false,
				margin:0
			}
		}
	});
	$('#service-tab-menu2').owlCarousel({
		loop:false,
		nav: true,
		dots:false,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		responsive : {
			0:{
				margin:18,
				autoWidth:true
			},
			1024:{
				margin:58,
				autoWidth:true
			}
		}
	})
	/* //slider */
	
	$(".mTab2 .more").on("click", function(){
		if ( $(".mTab3").hasClass("selected") )
		{
			$(this).removeClass("selected");
			$(".mTab3").hide().removeClass("selected");
		}
		else
		{
			$(this).addClass("selected");
			$(".mTab3").show().addClass("selected");
		}
	});

	
	$(".jsTabSer1").on("click", function(e){
		$(".mSer2").addClass("hidden");
		$( $(this).attr("href") ).removeClass("hidden");
		$(this).parent().parent().parent().children().children().children().removeClass("selected");
		$(this).addClass("selected");
		return false;
	});

	
});
