

;(function(exports, $){
	var exports = exports;

	$(document).ready(function(){

		function topAreaFn() {
			var $topArea = $('.top-area');
			if (!$topArea.length) return;

			var $topAreaWrap = $('<div class="top-area-wrapper"></div>');
			var $topAreaBg = $('<div class="top-area-back"></div>');
			var $breadcrumb = $('.breadcrumb');

			$topArea.after($topAreaWrap);
			$topAreaWrap.after($topAreaBg);
			$topAreaWrap.append($topArea);



			$('.submenu-depth2>h2').click(function(){
				$('.submenu-depth2>h2>a').children('i').toggleClass('ico-down ico-down-active');
				$('.submenu-depth2>h2>a').children('span').toggleClass('active');
				$('.submenu-depth2-list ul').slideToggle(400);
				if($('.submenu-depth2>h2>a').children('i').hasClass('ico-down-active')){
					$('.submenu-depth3').css('visibility','hidden')
					$('.prev-page').css('visibility','hidden')
					$breadcrumb.css('visibility','hidden')
					$topAreaBg.addClass('view');
				}else{
					$('.submenu-depth3').css('visibility','visible')
					$('.prev-page').css('visibility','visible')
					$topAreaBg.removeClass('view');
					setTimeout(
					  function()
					  {
					  	$breadcrumb.css('visibility','visible')
					  },400)
				}
			})
			$('.submenu-depth3 .submenu-depth3-title').click(function(){
				$('.submenu-depth3 .submenu-depth3-title>a').children('i').toggleClass('ico-down ico-down-active');
				$('.submenu-depth3 .submenu-depth3-title>a').children('span').toggleClass('active');
				$('.submenu-depth3-list ul').slideToggle(400)
				if($('.submenu-depth3 .submenu-depth3-title>a').children('i').hasClass('ico-down-active')){
					$('.submenu-depth2').css('visibility','hidden')
					$('.prev-page').css('visibility','hidden')
					$breadcrumb.css('visibility','hidden')
					$topAreaBg.addClass('view');
				}else{
					$('.submenu-depth2').css('visibility','visible')
					$('.prev-page').css('visibility','visible')
					$topAreaBg.removeClass('view');
					setTimeout(
					  function()
					  {
					  	$breadcrumb.css('visibility','visible')
					  },400)
				}
			})
		}
		topAreaFn();

		$(window).on({
			'scroll': function () {
				console.log(0);
				if ($(this).scrollTop() > 400) {
					$('.btntop').fadeIn();
				} else {
					$('.btntop').fadeOut();
				}
			}
		});
		$('#TopMove').bind("click", function(e) {
			e.preventDefault();

			$('body,html').animate({
				scrollTop: 0
			}, 400);
		});

		$('.owndb-dropmenu a').click(function(){
			$(this).toggleClass('active')
			$(this).parent().siblings('.owndb-dropmenu-list').slideToggle();

		})

	});

	$(document).ready(function() {
		// uniform 등록
		uniformInit();

		// Selectric 가동
		selectricInit();

		// accordion등록
		accordionFunctionInit();

		// 모바일 네비게이션 작동
		mobileGnbSlide();

		// GNB 동작
		gnbFunc();

		mainTopCarousel();

		mainMovieContentCarousel();

		mainHeaderTransform();
	});

	// uniform 등록
	function uniformInit () {
		$('input[type="checkbox"], input[type="radio"]').uniform({
			fileDefaultHtml: '',
			fileButtonHtml: '첨부파일 업로드'
		});
	}

	// Selectric 가동
	function selectricInit () {
		$('.footer-family select').selectric();
		as = $('.select-tric').selectric();
		as2 = $('.select-tric').data('selectric');
		// console.log(as);
		$('.select-tric').on('selectric-change', function(e) {
			console.log(e);
		})
	}

	function accordionFunctionInit () {
		var accordionSelector = '.accordion-wrap';
		var $accordion = $(accordionSelector);
		if ($accordion.length) {
			$.each( $accordion, function(i, el) {
				var $el = $accordion.eq(i);
				var $handle = $el.find('.collapse-handle');
				var $content = $el.find('.accordion-content');
				if ($el.hasClass('on')) {
					$content.css('display', 'block');
				}
				$handle.on('click', function(e) {
					e.preventDefault();
					// var $el;
					$content.slideToggle();
					$el.toggleClass('on');
					if ($el.hasClass('view-alone')) {
						$el.siblings( accordionSelector ).removeClass('on');
					}
				})
			})
		}
	}

	// 모바일 네비게이션 작동
	function mobileGnbSlide () {
		var $btn = $('.sticky-header-wrapper .menu-toggler');
		var $closeBtn = $('.main-navigation .main-navigation-close');
		var $mobileNavi = $('.main-navigation');

		$btn.on('click', function(e) {
			e.preventDefault();
			if ($mobileNavi.hasClass('expand')) {
				$mobileNavi.removeClass('expand');
				// $btn.removeClass('on');
			} else {
				$mobileNavi.addClass('expand');
				// $btn.addClass('on');
			}
		});
		$closeBtn.on('click', function(e) {
			e.preventDefault();
			$mobileNavi.removeClass('expand');
		});
	}

	function gnbFunc() {
		var $gnb = $('ul.gnb');
		var $more = $gnb.find('.btn.more');
		var $back = $gnb.find('a.back');
		var $parentLine;
		var $parent1st;
		var gnbTimer;
		var gnbTimerSpeed = 200;
		$more.on({
			'click': function(e) {
				e.preventDefault();

				$parentLine = $(this).parent('.category-line');
				$parent1st = $parentLine.parent('.category-1st');
				$parentLine.parent('li').siblings().find('.category-line').removeClass('select fix');
				if ($parentLine.hasClass('select')) {
					$parentLine.removeClass('select');
				} else {
					$parentLine.addClass('select');
				}

				clearTimeout(gnbTimer);
				if ($parent1st.length) {
					gnbTimer = setTimeout(function() {
						if ($parentLine.hasClass('fix')) {
							$parentLine.removeClass('select fix');
						} else if ($parentLine.hasClass('select')) {
							$parentLine.removeClass('select').addClass('fix');
							$parentLine.addClass('hide');
							$parent1st.siblings().children('.category-line').addClass('hide');
						}
						clearTimeout(gnbTimer);
					}, gnbTimerSpeed);
				} else {
					$parentLine.parent('li').siblings().children('.category-line').removeClass('select');
				}
			}
		});
		$back.on({
			'click': function(e) {
				e.preventDefault();

				$parentLine = $(this).parent().parent().prev('.category-line');
				$parent1st = $parentLine.parent('.category-1st');

				clearTimeout(gnbTimer);
				if ($parentLine.hasClass('fix')) {
					$parentLine.addClass('select');
					$parentLine.removeClass('hide');
					$parent1st.siblings().children('.category-line').removeClass('hide');

					if ($parent1st.length) {
						gnbTimer = setTimeout(function() {
							$parentLine.removeClass('select fix');
							clearTimeout(gnbTimer);
						}, gnbTimerSpeed);
					}
				}

			}
		});
	}

	function mainTopCarousel() {
		var $topCarousel = $('.main-top-screen');
		if (!$topCarousel.length) return;

		var $items = $topCarousel.find('.item');
		var $topCover = $('.main-top-cover .cover');
		var tgNum = 0;
		var delay = 6000;
		var _timer;

		$.each($items, function(i) {
			// console.log(i);
			var $this = $items.eq(i);
			var $box = $this.find('.box');
			var $btn = $this.find('.control');
			var _i = i;
			$this.attr('data-index', i);
			$btn.on({
				'mouseenter': function(e) {
					e.preventDefault();
					// console.log(_i);
					gotoCarousel(_i);
				}
			});
			$box.on({
				'mouseenter': function(e) {
					e.preventDefault();
					clearTimer();
				},
				'mouseleave': function(e) {
					e.preventDefault();
					setTimer();
				}
			})
		});
		$topCarousel.on({
			'initialized.owl.carousel': function(e) {
				tgNum = $topCarousel.find('.owl-item.center').children('.item').attr('data-index');
				$topCover.eq(tgNum).addClass('on').siblings().removeClass('on');
			},
			'move.owl.carousel': function(e) {
				tgNum = $topCarousel.find('.owl-item.center').children('.item').attr('data-index');
				$topCover.eq(tgNum).addClass('on').siblings().removeClass('on');
			}
		});
		$topCarousel.owlCarousel({
			items: 3,
			nav: false,
			dots: false,
			margin: 0,
			center: true,
			responsive: {
				0 : {
					autoWidth:true,
					// loop: true,
					// items: 1,
					center: true
				},
				1080: {
					loop: false,
					items: 3,
					mouseDrag: false,
				}
			}
		});

		function gotoCarousel(tg) {
			tgNum = tg;
			$topCarousel.trigger('to.owl.carousel', tgNum);
		}

		function setTimer() {
			_timer = setInterval(function() {
				gotoCarousel(++tgNum % 3);
			}, delay);
		}
		function clearTimer() {
			clearInterval(_timer);
		}

		// setTimer();

	}

	function mainMovieContentCarousel() {
		var $movieContent = $('.movies-contents-scroll-carousel');
		if (!$movieContent.length) return;

		var $owlStage = [];
		var $items = $movieContent.find('.item');
		var $viewItem;
		var currentIdx, tgIdx;
		var $viewItemInner = [];
		$.each($items, function(i) {
			var $cover = $items.eq(i).children('.cover');
			$items.eq(i).attr('data-index', i);
			$cover.attr('data-index', i);
			$cover.on({
				'click': function(e) {
					e.preventDefault();
					tgIdx = $cover.attr('data-index');
					$movieContent.trigger('to.owl.carousel', [tgIdx, (800 / Math.abs(currentIdx - tgIdx))]);
				}
			})
		})

		$movieContent.on({
			'move.owl.carousel': function(e) {
				if (!$owlStage.length) $owlStage = $movieContent.find('.owl-stage');
				if ($viewItemInner.length) {
					$viewItemInner.removeAttr('style');
					$viewItem.removeClass('view');
					$viewItemInner = [];
					if ($movieContent.hasClass('resized')) {
						$movieContent.trigger('refresh.owl.carousel');
					}
				}
				$viewItem = $movieContent.find('.owl-item.active').first();
				$viewItem.addClass('view');

				$viewItemInner = $viewItem.children('.item');
				$viewItemInner.css('width', Math.floor($movieContent.width()*0.5));
				currentIdx = $viewItemInner.attr('data-index');

				widthResopnsive();
			},
			'translated.owl.carousel': function(e) {
				if ($movieContent.hasClass('resized')) {
					$movieContent.trigger('refresh.owl.carousel');
					$movieContent.removeClass('resized');
				}
				widthResopnsive();
			},
			'resize.owl.carousel': function() {
			},
			'resized.owl.carousel': function() {
				$movieContent.addClass('resized');
				widthResopnsive();
			}
		});
		$movieContent.owlCarousel({
			autoWidth: true,
			responsive: {
				0: {
					smartSpeed: 400,
					center: true
				},
				1080: {
					smartSpeed: 800,
					// fluidSpeed: 800
				}
			}
		});

		function widthResopnsive() {
			$owlStage.css('width', getTotalWidth() + 'px');
		}
		function getTotalWidth() {
			var _num = 0;
			$.each($items, function(i) {
				_num += $items.eq(i).outerWidth();
			})
			return Math.ceil(_num);
		}
	}

	function mainHeaderTransform() {
		var $win = $(window);
		var $docu = $(document);
		var $body = $('html, body');
		var $header = $('#headerWrap');
		var $second = $('.main-secondary');

		if(!$second.length) return;

		var st = $docu.scrollTop();
		var secTop = $second.offset().top;
		var $down = $('.down-wheel');

		$win.on({
			'scroll': function(e) {
				st = $docu.scrollTop();
				headerClassControl();
			},
			'resize': function() {
				st = $docu.scrollTop();
				secTop = $second.offset().top;
			}
		});

		$down.on({
			'click':function(e) {
				console.log(1);
				e.preventDefault();
				$body.animate({scrollTop:secTop}, 500);
			}
		})

		headerClassControl();

		function headerClassControl() {
			if (secTop > st) {
				$header.addClass('main-header');
			} else {
				$header.removeClass('main-header');
			}
		}



	}



	$(document).ready(function() {

		$(".mLayer1 .iClose").click(function(){
			$(this).parent().parent().parent().hide();
			$("body").removeClass("hiddenWrap");
			return false;
		});
		
		/* tab */
		$(".jsTab1 a").on("click", function(){
			$(".mMenu1 .dep1 a").removeClass("selected");
			$(".mMenu1 .dep1 a").eq($(this).parent().index() ).addClass("selected");
			$(".mMenu1 .dep2").css("display","none");
			$( $(this).attr("href") ).css("display","block");
			return false;
		});
		$(window).on("resize load", function(){
			$(".mImage10.type3 li").each(function(){
				if ( $(this).hasClass("blank") )
				{
					$(this).css("min-height", parseInt( $(".mImage10.type3 li").eq(1).height() ) + parseInt( $(".mImage10.type3 li:last-child").css("padding-top") ) );
				}
			});
			
			$(".mImage7 li").each(function(){
				if ( $(this).hasClass("blank") )
				{
					$(this).css("min-height", parseInt( $(".mImage7 li").eq(1).height() ) + parseInt( $(".mImage7 li:last-child").css("padding-top") ) );
				}
			});
		});
		$(".iOpen1").on("click", function(){
			if ( $(this).hasClass("selected") )
			{
				$(this).text("펼쳐보기");
				$(this).removeClass("selected");
				$( $(this).attr("href") ).removeClass("selected");
			}
			else
			{
				$(this).text("닫기");
				$(this).addClass("selected");
				$( $(this).attr("href") ).addClass("selected");
			}
			return false;
		});

		
		$(".mList1 dd .list2").each(function(){
			if ( $(this).children("ul").children("li").eq(0).height() < 60)
			{
				$(this).animate({"height": "66px" });
			}
		});
		$(".mList1 dt").on("click", function(){
			if ( !( $(this).hasClass("noArrow") ) )
			{
				if ( $(this).hasClass("selected") )
				{
					$(this).removeClass("selected");
					$(this).next().children(".list").animate({"height": "34px" });
					$(this).next().children(".list2").animate({"height": "100px" });
				}
				else
				{
					$(this).addClass("selected");
					$(this).next().children(".list, .list2").animate({"height": $(this).next().children().children("ul").height() });
				}
			}
		});
		/*
		$(".mList1 dt").each(function(){
			var maxHeight = $(this).next().children(".list2").children("ul").children("li").eq(0).height();
			if ( $(this).next().children(".list2").children("ul").children("li").eq(1).height() > $(this).next().children(".list2").children("ul").children("li").eq(0).height())
			{
				maxHeight = $(this).next().children(".list2").children("ul").children("li").eq(1).height();
			}
			$(this).next().children(".list2").animate({"height": maxHeight+10 });
		});
		*/
		if ( $(".mList1").length > 0)
		{
			$(".mList1 dd").each(function(){
				if ( $(this).children(".list").children("ul").height() < 55 )
				{
					$(this).addClass("noArrow").prev().addClass("noArrow");
				}
				else if ( $(this).children(".list2").children("ul").height() < 70 )
				{
					$(this).addClass("noArrow").prev().addClass("noArrow");
				}
			});
		}

		$(".jsBtnAnchor").on("click", function(e){
			 e.preventDefault();
			var aid = $(this).attr("href");
			$('html,body').animate({scrollTop: $(aid).offset().top -50},'fast');
			return false;
		});

		$(window).on("load", function(){
			var locatoin = window.location.href;
			if ( locatoin.length )
			{
				$('html,body').animate({scrollTop: $("#"+ locatoin.split("#")[1]).offset().top -50},'fast');
				return false;
			}
		});

		/* toggle */
		$(".mToggle1 a").on("click", function(){
			$(this).parent().children().removeClass("selected");
			$(this).addClass("selected");
		});
		
		//$(".mLayer1").css("min-height", $("#wrap").height() );
		$(window).on("resize",function(){
			//$(".mLayer1").css("min-height", $("#wrap").height() );
		});
	
	});
	
})(this, this.jQuery)
