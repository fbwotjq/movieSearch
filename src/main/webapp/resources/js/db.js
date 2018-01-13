$(document).ready(function(){
	
	$(".mImage8 .gImg1 .txt .mTxt1 .ellipsis").css("margin-right", $(".mImage8 .gImg1 .txt .mTxt1 .cnt").width()+3);
	$(window).on("load resize", function(){
		$(".mImage8 .gImg1 .txt .mTxt1 .ellipsis").css("margin-right", $(".mImage8 .gImg1 .txt .mTxt1 .cnt").width()+3);
	});
	
	$(".mMDb6 .text").css("margin-top", -($(".mMDb6 .text").height()/2));
	$(window).on("load resize", function(){
		if ( $(".mMDb6").length > 0)
		{
			$(".mMDb6 .text").css("margin-top", -($(".mMDb6 .text").height()/2));
		}
	});

	if ( $(".mImage10").length )
	{
		$(".mImage10 li").each(function(e){
			if ( e == 0  || e == 1 | e == 2 | e == 3 )
			{
				$(this).addClass("pt0");
			}
		});
	}

	if ( $(".mImage9").length )
	{
		$(".mImage9 li").each(function(e){
			if ( e == 0  || e == 1 | e == 2 )
			{
				$(this).addClass("pt0");
			}
		});
	}

	/* 오토컴플릿 */
	$(".lAComplete .close").on("click", function(){
		$(this).parent().hide();
	});

	/* row2 */
	$(window).on("load resize", function(){
		$(".mProfile .mImg1").css("top", $(".mProfile .text .nam").height()+26);
	});

	/* list6 */
	$(".mList6 dl").each(function(e){
		$(this).addClass("list"+(e+1));
		$(this).children("dd").each(function(e){
			$(this).addClass("lst"+(e+1));
		});
	});
	$(".mList6 dt").on("mouseover click", function(){
		$(".mList6 dl").removeClass("hover");
		$(this).parent().addClass("hover");
	});
	$(".mList6 dt").on("mouseout", function(){
		//$(this).parent().removeClass("hover");
	});
	$(".mList6 dd .ls").each(function(){
		if ( $(this).parent().height() == 116 )
		{
			if ( $(this).height() > 230 )
				$(this).parent().addClass("row2");
		}
		else if ( $(this).parent().height() == 66 )
		{
			if ( $(this).height() > 160 )
				$(this).parent().addClass("row3");
			else if ( $(this).height() > 80 )
				$(this).parent().addClass("row2");
			else
				$(this).parent().addClass("row2");
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
	$('#db-tab-menu1').owlCarousel({
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
	$('#db-tab-menu2').owlCarousel({
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
				margin:60,
				autoWidth:true
			}
		}
	})
	$('#db-tab-menu3').owlCarousel({
		loop:false,
		nav: true,
		dots:false,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		responsive : {
			0:{
				margin:25,
				autoWidth:170
			},
			1024:{
				margin:45,
				autoWidth:true
			}
		}
	})
	$('#db-tab-search1').owlCarousel({
		loop:false,
		nav: false,
		dots:false,
		onInitialized: fixOwl,
		onRefreshed: fixOwl,
		margin:25,
		autoWidth:true
	})
	
	var dbTabMenu4 = $('#db-tab-menu4');
	dbTabMenu4.owlCarousel({
		loop:false,
		nav: false,
		dots:false,
		responsiveClass:true,
		autoWidth:true,
		responsive : {
			0:{
				margin:20
			},
			1024:{
				margin:30
			}
		}
	});

	var dbTabMenu4_2 = $('#db-tab-menu4_2');
	dbTabMenu4_2.owlCarousel({
		loop:false,
		dots:false,
		responsiveClass:true,
		autoWidth:true,
		responsive : {
			0:{
				nav: false,
				margin:20
			},
			1024:{
				nav: true,
				margin:30
			}
		}
	});
	
	var dbMainCate3 = $('#db-main-cate3');
	dbMainCate3.owlCarousel({
		loop:false,
		dots:false,
		nav: false,
		responsive : {
			0:{
				autoWidth:true,
				margin:10
			},
			1024:{
				margin:20,
				items:4
			},
			1280:{
				margin:30,
				items:4
			}
		}
	});
	var dbMainCate2 = $('#db-main-cate2');
	dbMainCate2.owlCarousel({
		loop:false,
		dots:false,
		nav: false,
		margin:0,
		autoWidth:true
	});
	var dbMainCate4 = $('#db-main-cate4');
	dbMainCate4.owlCarousel({
		loop:false,
		dots:false,
		responsive : {
			0:{
				nav: false,
				autoWidth:true,
				margin:10
			},
			1024:{
				nav: true,
				margin:10
			},
			1280:{
				nav: true,
				margin:20
			}
		}
	});
	var dbMainCate1 = $('#db-main-cate1');
	dbMainCate1.owlCarousel({
		loop:false,
		dots:true,
		items:1,
		animateOut: 'fadeOut'
	});
	/* //slider */
	
	$(document).on("click", ".mDBSearch1 dd .iMinus", function(){
		$(this).parent().parent().parent().hide();
		return false;
	});
	$(".mDBSearch1 dd .iAdd").on("click", function(){
		$( $(this).parent().parent().parent().parent().children(".clone") ).clone().appendTo( $(this).parent().parent().parent().parent().parent().find(".person") ).show().removeClass("clone");
	});

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

	$(".mDBSearch1 .asset label").on("click", function(){
		if ($(this).children().children().children("input[type='checkbox'").is(":checked") )
		{
			$(this).addClass("selected");
		}
		else
		{
			$(this).removeClass("selected");
		}
	});

});
