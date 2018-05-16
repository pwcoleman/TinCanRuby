# encoding: utf-8
module TinCanApi
  # ContextActivities Model class
  class ContextActivities

    attr_reader :parent, :grouping, :other, :category

    def initialize(options={}, &block)
      json = options.fetch(:json, nil)
      if json
        attributes = JSON.parse(json)
        if attributes['parent']
          if attributes['parent'].is_a?(Array)
            self.parent = attributes['parent'].map {|element| Activity.new(json: element.to_json)}
          else
            self.parent = [Activity.new(json: attributes['parent'].to_json)]
          end
        end

        if attributes['grouping']
          if attributes['grouping'].is_a?(Array)
            self.grouping = attributes['grouping'].map {|element| Activity.new(json: element.to_json)}
          else
            self.grouping = [Activity.new(json: attributes['grouping'].to_json)]
          end
        end

        if attributes['other']
          if attributes['other'].is_a?(Array)
            self.other = attributes['other'].map {|element| Activity.new(json: element.to_json)}
          else
            self.other = [Activity.new(json: attributes['other'].to_json)]
          end
        end

        if attributes['category']
          if attributes['category'].is_a?(Array)
            self.category = attributes['category'].map {|element| Activity.new(json: element.to_json)}
          else
            self.category = [Activity.new(json: attributes['category'].to_json)]
          end
        end
      else
        self.parent = options.fetch(:parent, nil)
        self.grouping = options.fetch(:grouping, nil)
        self.other = options.fetch(:other, nil)
        self.category = options.fetch(:category, nil)

        if block_given?
          block[self]
        end
      end
    end

    def parent=(value)
      if value.is_a(Array)
        @parent = value
      else
        @parent = [value]
      end
    end

    def grouping=(value)
      if value.is_a(Array)
        @grouping = value
      else
        @grouping = [value]
      end
    end

    def other=(value)
      if value.is_a(Array)
        @other = value
      else
        @other = [value]
      end
    end

    def category=(value)
      if value.is_a(Array)
        @category = value
      else
        @category = [value]
      end
    end

    def serialize(version)
      node = {}
      if parent && parent.any?
        if version == TinCanApi::TCAPIVersion::V095 && parent.size > 1
          raise TinCanApi::Errors::IncompatibleTCAPIVersion, "Version #{version.to_s} doesn't support lists of activities (parent)"
        end
        if version == TinCanApi::TCAPIVersion::V095
          node['parent'] = parent.first.serialize(version)
        else
          node['parent'] = parent.map {|element| element.serialize(version)}
        end
      end

      if grouping && grouping.any?
        if version == TinCanApi::TCAPIVersion::V095 && grouping.size > 1
          raise TinCanApi::Errors::IncompatibleTCAPIVersion, "Version #{version.to_s} doesn't support lists of activities (grouping)"
        end
        if version == TinCanApi::TCAPIVersion::V095
          node['grouping'] = grouping.first.serialize(version)
        else
          node['grouping'] = grouping.map {|element| element.serialize(version)}
        end
      end

      if other && other.any?
        if version == TinCanApi::TCAPIVersion::V095 && other.size > 1
          raise TinCanApi::Errors::IncompatibleTCAPIVersion, "Version #{version.to_s} doesn't support lists of activities (other)"
        end
        if version == TinCanApi::TCAPIVersion::V095
          node['other'] = other.first.serialize(version)
        else
          node['other'] = other.map {|element| element.serialize(version)}
        end
      end

      if category && category.any?
        if version.ordinal <= TinCanApi::TCAPIVersion::V100.ordinal
          node['category'] = category.map {|element| element.serialize(version)}
        else
          raise TinCanApi::Errors::IncompatibleTCAPIVersion, "Version #{version.to_s} doesn't support the category context activity"
        end
      end

      node
    end

  end
end