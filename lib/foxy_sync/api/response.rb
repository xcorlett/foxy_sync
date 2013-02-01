require 'nokogiri'

module FoxySync::Api
  #
  # A +Response+ represents an XML reply
  # sent by the FoxyCart API. To use it simply
  # send an instance a message that corresponds
  # to an element in the XML. For example,
  #
  # api = FoxySync::Api::Messenger.new
  # reply = api.customer_get :customer_email => 'foo@bar.com'
  # reply.customer_id # is the customer's FoxyCart id
  #
  # Every message will return +nil+ if no matching
  # element is found in the XML reply, a +String+ if
  # there is one matching element in the reply, or an
  # +Array+ with all element values if there is more than one
  # element in the XML reply.
  class Response
    #
    # A +Nokogiri::XML::Document+ of the API reply
    attr_reader :document


    def initialize(xml)
      @document = Nokogiri::XML(xml) {|config| config.strict.nonet }
    end


    def respond_to?(method_name, include_private = false)
      true # respond to everything; we don't know what will be in the response doc
    end


    private

    def method_missing(method_name, *args, &block)
      node_set = document.xpath "//#{method_name}"
      return nil if node_set.nil? || node_set.empty?

      contents = node_set.to_a
      contents.map!{|node| node.content }
      contents.delete_if{|content| content.empty? }
      contents.size == 1 ? contents.first : contents
    end
  end
end