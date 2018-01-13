$(document).ready(function(){

	$('#sub-visual-slide').owlCarousel({
		loop: false,
		lazyLoad: true,
		nav: true,
		items: 1,
		navigation: true,
		pagination : true,
		paginationNumbers: false,
		dots: false,
		autoHeight : false
	});
	$('#sub-visual-slide').on('changed.owl.carousel', function(e){
		if (!e.namespace || e.property.name != 'position') return;
		var items_per_page = e.page.size;
		if (items_per_page > 1){
			var min_item_index  = e.item.index,
			max_item_index  = min_item_index + items_per_page,
			display_text    = (min_item_index+1) + '-' + max_item_index;
		} else {
			var display_text = (e.item.index+1);
		}
		$('#sliderCount').html( "<b>" + display_text + "</b>" + " / " + e.item.count);
	});
	$('#owndb-menu').owlCarousel({
	    loop:false,
	    nav: false,
	    dots:false,
	    responsive:{
			0:{
				margin:18,
				autoWidth:true,
				items:4
			},
			1024:{
				width:120,
				items:9
			}
		}
	})
	$('#total-search-menu').owlCarousel({
	    loop:false,
	    nav: false,
	    dots:false,
	    responsive:{
			0:{
				margin:18,
				autoWidth:true,
				items:4
			},
			1024:{
				items:11
			}
		}
	})

	
});