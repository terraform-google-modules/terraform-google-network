project_id   = attribute('project_id')
network_name = attribute('network_name')

control "inspec_attributes" do
  title "Test Terraform Outputs"
  desc "Test Terraform outputs"

  describe attribute("output_network_name") do
    it { should eq "#{network_name}" }
  end

  describe attribute("output_network_self_link") do
    it { should eq "https://www.googleapis.com/compute/v1/projects/#{project_id}/global/networks/#{network_name}" }
  end

end
