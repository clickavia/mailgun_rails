require 'spec_helper'
require 'mailgun_rails/client'

describe MailgunRails::Client do
  describe "MailgunRails client without a region" do
    let(:client){MailgunRails::Client.new(:some_api_key, :some_domain)}

    describe "#send_message" do
      it 'should make a POST rest request passing the parameters to the mailgun end point' do
        expected_url = "https://api:some_api_key@api.mailgun.net/v3/some_domain/messages"
        RestClient::Request.stub(:execute).with({ method: :post, url: expected_url, payload: { foo: :bar }, verify_ssl: true})
        client.send_message foo: :bar
      end
    end
  end

  describe "MailgunRails client with some region" do
    let(:client){MailgunRails::Client.new(:some_api_key, :some_domain, true, :some_region)}

    describe "#send_message" do
      it 'should make a POST rest request passing the parameters to the mailgun end point' do
        expected_url = "https://api:some_api_key@api.some_region.mailgun.net/v3/some_domain/messages"
        RestClient::Request.stub(:execute).with({ method: :post, url: expected_url, payload: { foo: :bar }, verify_ssl: true})
        client.send_message foo: :bar
      end
    end  
  end
end
