require "minitest"
require "minitest/spec"
require "minitest/autorun"
require "cast_env"

describe CastEnv::Type::Boolean do
  it "is compares the downcased value to 'true'" do
    CastEnv::Type::Boolean.call('true').must_equal true
    CastEnv::Type::Boolean.call('TRUE').must_equal true
    CastEnv::Type::Boolean.call('false').must_equal false
  end
end

describe CastEnv::Type::Integer do
  it "converts a string number to an integer" do
    CastEnv::Type::Integer.call('123').must_equal 123
    CastEnv::Type::Integer.call('99').must_equal 99
  end
end

describe CastEnv, '.casts' do
  it "sets the config with uppercase key for the given type" do
    CastEnv.casts :enabled, :Boolean
    CastEnv.casts :max_projects, :Integer

    assert CastEnv.config['ENABLED'] == CastEnv::Type::Boolean
    assert CastEnv.config['MAX_PROJECTS'] == CastEnv::Type::Integer
  end
end

describe CastEnv, '.[]' do
  it "casts the value from ENV on retrieval" do
    CastEnv.casts :enabled, :Boolean
    CastEnv.casts :max_projects, :Integer

    ENV['ENABLED'] = 'true'
    assert CastEnv['ENABLED'] == true
    assert CastEnv[:enabled] == true
    ENV['ENABLED'] = 'false'
    assert CastEnv['ENABLED'] == false

    ENV['MAX_PROJECTS'] = '42'
    assert CastEnv['MAX_PROJECTS'] == 42
  end

  it "raises a KeyError if the given key doesn't exist" do
    proc { CastEnv[:bogus_test_key] }.must_raise KeyError
  end

  it "raises an error if the given key wasn't configured" do
    ENV['DISABLED'] = 'true'
    proc { CastEnv[:disabled] }.must_raise KeyError
  end
end
