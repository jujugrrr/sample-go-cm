
def get_backends(tag)
  require 'aws-sdk'
  begin
    ec2 = Aws::EC2::Resource.new(region: 'eu-west-1')
    ec2.instances(filters: [{ name: 'tag:app', values: [tag] }]).map(&:private_ip_address)
  rescue
    ['127.0.0.1']
  end
end
