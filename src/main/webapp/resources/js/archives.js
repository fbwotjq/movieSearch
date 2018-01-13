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

	$('#archives-tab-menu3').owlCarousel({
		loop:false,
		nav: false,
		dots:false,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		responsive : {
			0:{
				margin:25,
				autoWidth:true,
				items:2
			},
			1024:{
				margin:45,
				autoWidth:true
			}
		}
	})
	$('#archives-tab-menu4, #archives-tab-menu4_1, #archives-tab-menu4_2, #archives-tab-dep2-1').owlCarousel({
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
	$('#archives-tab-dep3-1').owlCarousel({
		loop:false,
		nav: true,
		dots:false,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		responsive : {
			0:{
				margin:20,
				autoWidth:true
			},
			1024:{
				margin:0,
				autoWidth:true
			}
		}
	})

	$('#archives-recomd-carousel').owlCarousel({
		loop:false,
		nav: true,
		dots:false,
		responsiveClass:true,
		responsive : {
			0:{
				items:2
			},
			1024:{
				items:4
			}
		}
	})
	$('#archives-keyvisual').owlCarousel({
		loop:false,
		nav: true,
		dots:false,
		responsiveClass:true,
		items:1
	})
	$('#archives-main-list1').owlCarousel({
		loop:false,
		nav: false,
		dots:false,
		margin:0,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		responsive : {
			0:{
				autoWidth:140
			},
			1024:{
				items:5
			},
			1280:{
				items:5
			}
		}
	})
	$('#archives-main-list2').owlCarousel({
		loop:false,
		nav: true,
		dots:false,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		responsive : {
			0:{
				margin:10,
				autoWidth:95
			},
			1024:{
				margin:20,
				autoWidth:true
			}
		}
	})
	setArchivesMainList2();
	$(window).on("load resize", function(){
		setArchivesMainList2();
	});

	function setArchivesMainList2()
	{
		if ( $("body").width() > 1024 )
			$(".mMArchives4 .owl-carousel .owl-stage-outer").css("padding-left", ( $("body").width() - $(".mMArchives4 .archives4bg").width() )/2 );
		else
			$(".mMArchives4 .owl-carousel .owl-stage-outer").css("padding-left", "15px" );
	}
	/* //slider */


});
