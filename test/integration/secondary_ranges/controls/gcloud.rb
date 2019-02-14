# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

project_id = attribute('project_id')

control "gcloud" do
  title "gcloud configuration"

  describe command("gcloud compute networks subnets describe secondary-ranges-subnet-01 --project=#{project_id} --region=us-west1 --format=json") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    it "should have the correct secondaryIpRanges configuration for secondary-ranges-subnet-01" do
      expect(data["secondaryIpRanges"][0]).to include(
        "rangeName"   => "subnet-01-01",
        "ipCidrRange" => "192.168.64.0/24"
      )
    end

    it "should have the correct secondaryIpRanges configuration for secondary-ranges-subnet-02" do
      expect(data["secondaryIpRanges"][1]).to include(
        "rangeName"   => "subnet-01-02",
        "ipCidrRange" => "192.168.65.0/24"
      )
    end
  end

  describe command("gcloud compute networks subnets describe secondary-ranges-subnet-03 --project=#{project_id} --region=us-west1 --format=json") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    it "should have the correct secondaryIpRanges configuration for secondary-ranges-subnet-01" do
      expect(data["secondaryIpRanges"][0]).to include(
        "rangeName"   => "subnet-03-01",
        "ipCidrRange" => "192.168.66.0/24"
      )
    end
  end
end
