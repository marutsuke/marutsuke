module ApplicationHelper

  ## pdfの時の出しわけをしたい
  def image_or_pdf_tag(question, html_class = 'm-question__image')
    if question.image_url.match(/pdf$/)
      tag.object '', data: question.image_url, type: 'application/pdf',style: "width: 100%;", class: html_class
    else
      image_tag question.image_url, alt: question.image_alt, class: html_class
    end
  end
end
