module Winker
  #TODO make temperture class for easy conversion between F and C
  # this is not included in the project at this moment
  class Temperature < Numeric
    DEFAULT_SCALE = "f"
    attr_accessor :reading, :scale, :display_scale

    def initialize(temp, scale = DEFAULT_SCALE, display_scale = DEFAULT_SCALE)
      @reading = temp
      @scale = scale
      @display_scale = display_scale
    end

    def to_s
      temp.to_s
    end

    def to_i
      temp.to_i
    end

    def to_f
      temp.to_f
    end

    def temp
      case
      when scale == display_scale
        return reading
      when scale == "f" && display_scale == "c"
        return (reading - 32) * 5.0 / 9
      when scale == "c" && display_scale == "f"
        return (reading * 9.0 / 5) + 32
      else
        raise "Doesn't support #{scale} temp scale"
      end
    end
  end
end