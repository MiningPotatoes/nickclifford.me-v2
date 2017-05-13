ENV['RACK_ENV'] = 'test'

require_relative '../index'
require 'rack/test'

describe NickCliffordV2 do
  include Rack::Test::Methods

  def app
    NickCliffordV2
  end

  it 'works' do
    get '/'
    expect(last_response).to be_ok
  end
end
