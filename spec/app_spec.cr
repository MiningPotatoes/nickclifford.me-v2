require "spec-kemal"
require "../index"

describe "nickclifford.me-v2" do
  it "renders /" do
    get "/"
    response.body.should contain "Nick Clifford"
  end
end
