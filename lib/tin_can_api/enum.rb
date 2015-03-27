# encoding: utf-8
module TinCanApi
  module Enum
    CONVERT_PROC = Proc.new do
      @values = constants.collect{|c| const_get(c)}.freeze

      @values.each_with_index do |value, idx|
        the_symbol = constants.find{|c| const_get(c) == value}
        sig = class << value ; self end
        sig.send :define_method, :name, proc{the_symbol}
        sig.send :define_method, :ordinal, proc{idx}

        if value.is_a? Hash
          value.each do |k, v|
            sig.send :define_method, k, (v.is_a?(Proc) ? v : proc{v})
          end
        end
        value.freeze
      end

      class << self
        alias :value_of :const_get
      end

      module_function
      def each
        @values.each { |v| yield v }
      end
      def values
        @values
      end
      extend Enumerable

      freeze
    end

    def self.extended extending_obj
      extending_obj.module_eval &CONVERT_PROC
    end
  end

end