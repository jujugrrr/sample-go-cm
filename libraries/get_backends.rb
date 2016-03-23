
# rubocop:disable Metrics/MethodLength
def get_backends(tag)
  require 'aws-sdk'
  begin
    ec2 = Aws::EC2::Resource.new(region: 'eu-west-1')
    backends = ec2.instances(filters: [{ name: 'tag:app', values: [tag] }, { name: 'instance-state-name', values: ['running'] }]).map(&:private_ip_address)
    if backends.empty?
      Chef::Log.warn('No backend found')
      ['127.0.0.1']
    else
      backends
    end
  rescue
    Chef::Log.warn('Cannot retrieve instances from EC2')
    ['127.0.0.1']
  end
end
# rubocop:enable Metrics/MethodLength
