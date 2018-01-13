/**
 * 사료관 파일 다운로드
 * @param pFileSeq
 * @param pFileOrder
 * @returns
 */
function fcnDownload(pFormId, pFileSeq, pFileOrder) {
    $("#dFileSeq").val(pFileSeq);
    $("#dFileOrder").val(pFileOrder);

    formSubmit(pFormId, "/history/download");
}

/**
 * 사료관 PDF 뷰어
 * @param pFileSeq
 * @param pFileOrder
 * @returns
 */
function fcnPdfViewer(pFormId, pFileSeq, pFileOrder) {
    $("#dFileSeq").val(pFileSeq);
    $("#dFileOrder").val(pFileOrder);

    var pdfViewerWin = window.open("about:blank", "pdfViewerWin");

    formSubmit(pFormId, "/history/pdfViewer", "post", "pdfViewerWin");
}