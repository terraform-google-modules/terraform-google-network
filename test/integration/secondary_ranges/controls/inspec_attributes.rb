project_id   = attribute('project_id')
network_name = attribute('network_name')

control "inspec_attributes" do
  title "Terraform Outputs"
  desc "Terraform Outputs"

  describe attribute("output_network_name") do
    it { should eq "#{network_name}" }
  end

  describe attribute("output_network_self_link") do
    it { should eq "https://www.googleapis.com/compute/v1/projects/#{project_id}/global/networks/#{network_name}" }
  end

  describe attribute("output_subnets_ips") do
    it { should eq ["10.10.10.0/24", "10.10.20.0/24", "10.10.30.0/24", "10.10.40.0/24"] }
  end

  describe attribute("output_routes") do
    it { should eq [] }
  end

  describe attribute("output_subnets_flow_logs") do
    it { should eq [false, true, false, false] }
  end

  describe attribute("output_subnets_names") do
    it { should eq ["#{network_name}-subnet-01", "#{network_name}-subnet-02", "#{network_name}-subnet-03", "#{network_name}-subnet-04"] }
  end

  describe attribute("output_subnets_private_access") do
    it { should eq [false, true, false, false] }
  end

  describe attribute("output_subnets_regions") do
    it { should eq ["us-west1", "us-west1", "us-west1", "us-west1"] }
  end

  describe attribute("output_subnets_secondary_ranges") do
    it { should eq [{"ip_cidr_range"=>"192.168.64.0/24", "range_name"=>"#{network_name}-subnet-01-01"}, {"ip_cidr_range"=>"192.168.65.0/24", "range_name"=>"#{network_name}-subnet-01-02"}, {"ip_cidr_range"=>"192.168.66.0/24", "range_name"=>"#{network_name}-subnet-03-01"}] }
  end

  describe attribute("output_svpc_host_project_id") do
    it { should eq "" }
  end
end
