<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>

<script type="text/javascript" src="<c:url value='/static/js/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/pdf.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/pdf.worker.js'/>"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pdf viewer</title>
</head>
<body>
	<div>
		<button id="prev">Previous</button>
		<button id="next">Next</button>
		&nbsp; &nbsp; <span>Page: <span id="page_num"></span> / <span
			id="page_count"></span></span>
	</div>

	<canvas id="the-canvas"></canvas>
</body>

<script type="text/javascript">
var pdfDoc = null,
pageNum = 1,
pageRendering = false,
pageNumPending = null,
scale = 1.5,
canvas = document.getElementById('the-canvas'),
ctx = canvas.getContext('2d');

$(document).ready(function () {
	PDFJS.getDocument("<c:url value='/resources/viewer/pdf/document1.pdf'/>").then(function(_pdfDoc) {
		pdfDoc = _pdfDoc;
		  document.getElementById('page_count').textContent = pdfDoc.numPages;

		  // Initial/first page rendering
		  renderPage(pageNum);
		});

    /*

	PDFJS.getDocument("<c:url value='/static/js/pdfView/web/compressed.tracemonkey-pldi-09.pdf'/>");


	PDFJS.getDocument("<c:url value='/static/js/pdfView/web/compressed.tracemonkey-pldi-09.pdf'/>").then(function(pdf) {
		pdf.getPage(1).then(function(page) {
			var scale = 1.5;
			var viewport = page.getViewport(scale);

			var canvas = document.getElementById('the-canvas');
			var context = canvas.getContext('2d');
			canvas.height = viewport.height;
			canvas.width = viewport.width;

			var renderContext = {
			  canvasContext: context,
			  viewport: viewport
			};
			page.render(renderContext);
	    });
	});

	*/
});

function renderPage(num) {
	  pageRendering = true;
	  // Using promise to fetch the page
	  pdfDoc.getPage(num).then(function(page) {
	    var viewport = page.getViewport(scale);
	    canvas.height = viewport.height;
	    canvas.width = viewport.width;

	    // Render PDF page into canvas context
	    var renderContext = {
	      canvasContext: ctx,
	      viewport: viewport
	    };
	    var renderTask = page.render(renderContext);

	    // Wait for rendering to finish
	    renderTask.promise.then(function() {
	      pageRendering = false;
	      if (pageNumPending !== null) {
	        // New page rendering is pending
	        renderPage(pageNumPending);
	        pageNumPending = null;
	      }
	    });
	  });

	  // Update page counters
	  document.getElementById('page_num').textContent = pageNum;
	}

	/**
	 * If another page rendering in progress, waits until the rendering is
	 * finised. Otherwise, executes rendering immediately.
	 */
	function queueRenderPage(num) {
	  if (pageRendering) {
	    pageNumPending = num;
	  } else {
	    renderPage(num);
	  }
	}

	/**
	 * Displays previous page.
	 */
	function onPrevPage() {
	  if (pageNum <= 1) {
	    return;
	  }
	  pageNum--;
	  queueRenderPage(pageNum);
	}
	document.getElementById('prev').addEventListener('click', onPrevPage);

	/**
	 * Displays next page.
	 */
	function onNextPage() {
	  if (pageNum >= pdfDoc.numPages) {
	    return;
	  }
	  pageNum++;
	  queueRenderPage(pageNum);
	}
	document.getElementById('next').addEventListener('click', onNextPage);
</script>
</html>