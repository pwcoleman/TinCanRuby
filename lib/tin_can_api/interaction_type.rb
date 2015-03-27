# encoding: utf-8
module TinCanApi
  # Possible interaction types
  module InteractionType

    CHOICE = {
        to_s: 'choice',
        get_value: proc{'choice'}
    }

    SEQUENCING = {
        to_s: 'sequencing',
        get_value: proc{'sequencing'}
    }

    LIKERT = {
        to_s: 'likert',
        get_value: proc{'likert'}
    }

    MATCHING = {
        to_s: 'matching',
        get_value: proc{'matching'}
    }

    PERFORMANCE = {
        to_s: 'performance',
        get_value: proc{'performance'}
    }

    TRUE_FALSE = {
        to_s: 'true-false',
        get_value: proc{'true-false'}
    }

    FILL_IN = {
        to_s: 'fill-in',
        get_value: proc{'fill-in'}
    }

    NUMERIC = {
        to_s: 'numeric',
        get_value: proc{'numeric'}
    }

    OTHER = {
        to_s: 'other',
        get_value: proc{'other'}
    }

    def type_by_string(type)
      values.select{|v| v.to_s == type}.first
    end

    extend TinCanApi::Enum

  end
end