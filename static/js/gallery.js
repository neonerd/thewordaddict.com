var selectedGallery = null;

window.initGallery = function(id) {

	selectedGallery = id;
	$('#gallery-' + id).show();
	$('#gallery-' + id).animate({opacity: 1});

}

window.switchGallery = function(id) {

	$(window).scrollTop(0);

	$('#gallery-' + selectedGallery).animate({opacity:0}, function(){
		$('#gallery-' + selectedGallery).hide();
		$('#gallery-' + id).show();
		$('#gallery-' + id).animate({opacity: 1});
		selectedGallery = id;
	});

	
}