require 'open-uri'
require 'nokogiri'

TAGS = ["h1", "h2", "h3"].freeze

class ContentsController < JSONAPI::ResourceController
  skip_before_action :verify_authenticity_token        

  def index
    contents = Content.all
    include_resources = ['tags']
    content_resources = contents.map { |content| ContentResource.new(content, nil) }

    render json: JSONAPI::ResourceSerializer.new(ContentResource, include: include_resources,
      fields: {
        content: [:url],
        tags: [:tag, :value],
      }
    ).serialize_to_hash(content_resources)
  end

  def create
    url = params[:url]
    doc = Nokogiri::HTML(open(url))
    content = Content.create(url: url)
    TAGS.each do |tag|
      entries = doc.css(tag)
      entries.each do |entry|
        tag = Tag.new(tag: entry.name, value: entry.text, content_id: content.id)
        tag.save
      end
    end
    doc.css("a[href]").pluck(:href).reject(&:empty?).each do |link|
      tag = Tag.new(tag: 'a', value: link, content_id: content.id)
      tag.save
    end
    render json: content, status: :created
  end
end
