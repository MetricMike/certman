require 'spec_helper'

describe Certman do
  it 'has a version number' do
    expect(Certman::VERSION).not_to be nil
  end

  context 'S3 bucket name limitation' do
    it '3 =< FQDN.length < 54 generated by certman' do
      domain = '63.example.com'
      expected = '63.example.com-certman'
      expect(Certman::Client.new(domain).send(:bucket_name)).to eq expected

      domain = '63.characters.long.example.com'
      expected = '63.characters.long.example.com-certman'
      expect(Certman::Client.new(domain).send(:bucket_name)).to eq expected
    end

    it '54 =< FQDN.length generated by certman' do
      domain = '0123456789012345678901234567890123456789012.example.com'
      expected = '7c0326349f8377cea67ea8752e9dcdb0c2442ac2-certman'
      expect(Certman::Client.new(domain).send(:bucket_name)).to eq expected
    end
  end
end
