# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
    def initialize(flash:)
      @flash = flash.to_h.symbolize_keys
    end
  
    def styles_for(type)
      case type.to_sym
      when :notice
        { bg: "bg-green-50", text: "text-green-800", icon: "text-green-400" }
      when :alert
        { bg: "bg-red-50", text: "text-red-800", icon: "text-red-400" }
      else
        { bg: "bg-gray-50", text: "text-gray-800", icon: "text-gray-400" }
      end
    end
  end
  
