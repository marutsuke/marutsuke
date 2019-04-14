json.array! @sections do |section|
  json.section section.section
  json.id section.id
  json.book_id section.chapter.book.id
  json.chapter_id section.chapter.id
end