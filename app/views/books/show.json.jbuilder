json.array! @chapters do |chapter|
  json.chapter chapter.chapter
  json.id chapter.id
  json.book_id chapter.book.id
  json.book_image chapter.book.image.url
end
