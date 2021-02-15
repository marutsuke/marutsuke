module ImageOrPdfTagHelper

  ## pdfの時の出しわけをしたい
  def image_or_pdf_tag(question, html_class = 'm-question__image')
    if question&.image_url&.match(/pdf$/)
      link_to 'ダウンロード', question.image_url, download: question.image_url, target: "_blank", rel: "noopener noreferrer"
    else
      image_tag question.image_url, alt: question.image_alt, class: html_class
    end
  end
end
