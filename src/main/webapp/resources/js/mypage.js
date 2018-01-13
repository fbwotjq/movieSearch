$(document).ready(function(){

	if ( $(".mImage7").length )
	{
		$(".mImage7 li").each(function(e){
			if ( e == 0  || e == 1 | e == 2 | e == 3 )
			{
				$(this).addClass("pt0");
			}
		});
	}


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
	$('#archives-tab-menu3').owlCarousel({
		loop:false,
		nav: false,
		dots:false,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		responsive : {
			0:{
				margin:28,
				autoWidth:true,
				items:2
			},
			1024:{
				margin:45,
				autoWidth:true
			}
		}
	})
	$('#archives-tab-menu4, #archives-tab-menu4_2, #archives-tab-dep2-1').owlCarousel({
		loop:false,
		nav: false,
		dots:false,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		responsive : {
			0:{
				margin:20,
				autoWidth:true,
			},
			1024:{
				margin:30,
				autoWidth:true
			}
		}
	})
	$('#archives-tab-dep3-1').owlCarousel({
		loop:false,
		nav: true,
		dots:false,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		responsive : {
			0:{
				margin:20,
				autoWidth:true,
			},
			1024:{
				margin:0,
				autoWidth:true
			}
		}
	})
	/* //slider */


	$(document).on("click", "#jsCategory .iMinus", function(){
		//$(this).parent().parent().hide();
		//return false;
	});
	$("#jsCategory .iAdd").on("click", function(){
		//$(this).parent().parent().parent().children(".clone").children("input[type='text']").val( $(this).parent().prev().val() );
		//$( $(this).parent().parent().parent().children(".clone") ).clone().appendTo( $(this).parent().parent().parent() ).show().removeClass("clone");
	});


});
