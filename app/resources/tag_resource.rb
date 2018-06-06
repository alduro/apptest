class TagResource < JSONAPI::Resource
  attributes :tag, :value
  relationship :content, to: :one
end
