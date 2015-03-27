# encoding: utf-8
require 'spec_helper'

describe TinCanApi::Attachment do
  include Helpers

  it 'should serialize and deserialize' do
    attachment = TinCanApi::Attachment.new
    attachment.content_type = 'text/plain'
    map = {}
    map['en-US'] = 'Some attachment'
    attachment.display = map

    map = {}
    map['en-US'] = 'Some attachment description'
    attachment.description = map

    attachment.file_url = URI.parse('http://example.com/somefile')
    attachment.length = 27
    attachment.sha2 = '495395e777cd98da653df9615d09c0fd6bb2f8d4788394cd53c56a3bfdcd848a'
    attachment.usage_type = Addressable::URI.parse('http://example.com/attachment-usage/test')

    assert_serialize_and_deserialize(attachment)

  end
end