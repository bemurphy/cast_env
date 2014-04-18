require "cast_env/version"

module CastEnv
  module Type
    Boolean = ->(x) { x.to_s.downcase == 'true' }
    Integer = ->(x) { x.to_i }
  end

  def self.config
    @@config ||= {}
  end

  def self.casts(name, cast_as)
    type = CastEnv::Type.const_get(cast_as)
    config[name.to_s.upcase] = type
  end

  def self.[](name)
    key    = name.to_s.upcase
    val    = ENV.fetch(key)
    caster = config[key]

    if caster
      caster.call(val)
    else
      raise KeyError, "Attribute #{name} not configured"
    end
  end
end
