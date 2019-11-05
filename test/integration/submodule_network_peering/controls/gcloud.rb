# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

project_id         = attribute('project_id')
prefix             = attribute('prefix')
local_network_name = attribute('local_network_name')
peer_network_name  = attribute('peer_network_name')

control "gcloud" do
  title "gcloud configuration"

  describe command("gcloud compute networks peerings list --project=#{project_id} --format=json") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    describe "local VPC peering" do
      it "should exist" do
        expect(data)[0].to include(
          "name" => "#{prefix}-#{local_network_name}-#{peer_network_name}"
        )
      end
      it "should be active" do
        expect(data)[0].to include(
          "state" => "ACTIVE"
        )
      end
    end

    describe "peer VPC peering" do
      it "should exist" do
        expect(data)[1].to include(
          "name" => "#{prefix}-#{peer_network_name}-#{local_network_name}"
        )
      end
      it "should be active" do
        expect(data)[1].to include(
          "state" => "ACTIVE"
        )
      end
    end

  end

end
