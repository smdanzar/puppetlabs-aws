Puppet::Type.newtype(:ec2_vpc_internet_gateway) do
  @doc = 'type representing an EC2 VPC Internet Gateway'

  newparam(:name, namevar: true) do
    desc 'the name of the internet gateway'
    validate do |value|
      fail 'Empty values are not allowed' if value == ''
    end
  end

  ensurable

  newproperty(:tags) do # TODO
    desc 'tags to assign to the internet gateway'
  end

  newproperty(:region) do
    desc 'the region in which to launch the subnet'
  end

  newproperty(:vpcs, :array_matching => :all) do
    desc 'the vpcs to assign this subnet to'
  end

  autorequire(:ec2_vpc) do
    vpcs = self[:vpcs]
    vpcs.is_a?(Array) ? vpcs : [vpcs]
  end
end
