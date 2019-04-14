json.array! @sections do |section|
  json.section section.section
  json.id section.id
  json.book_id section.book.id
end