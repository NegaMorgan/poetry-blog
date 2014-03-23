json.array!(@poems) do |poem|
  json.extract! poem, :id, :title, :content, :author_id
  json.url poem_url(poem, format: :json)
end
