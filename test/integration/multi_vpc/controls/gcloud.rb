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

project_id            = attribute('project_id')
network_01_name       = attribute('network_01_name')
network_01_routes     = attribute('network_01_routes')
network_01_route_data = attribute('network_01_route_data')
network_02_name       = attribute('network_02_name')
network_02_routes     = attribute('network_02_routes')
network_02_route_data = attribute('network_02_route_data')

control "gcloud" do
  title "gcloud configuration"

  network_01_routes.each_with_index do |route, route_index|
    describe command("gcloud compute routes describe #{route} --project=#{project_id} --format=json") do
      its(:exit_status) { should eq 0 }
      its(:stderr) { should eq '' }

      let(:default_internet_gateway) { "https://www.googleapis.com/compute/v1/projects/#{project_id}/global/gateways/default-internet-gateway" }
      let(:data) do
        if subject.exit_status == 0
          JSON.parse(subject.stdout)
        else
          {}
        end
      end


      describe "destRange configuration" do
        it "should match" do
          expect(data["destRange"]).to eq network_01_route_data[route_index]['destination_range']
        end
      end

      describe "tags configuration" do
        it "should match" do
          expect(data["tags"]).to eq network_01_route_data[route_index]['tags'].split(",")
        end
      end

      if network_01_route_data[route_index]['next_hop_internet']
        describe "nextHopGateway configuration" do
          it "should match" do
            expect(data["nextHopGateway"]).to eq default_internet_gateway
          end
        end
      end
    end
  end

  network_02_routes.each_with_index do |route, route_index|
    describe command("gcloud compute routes describe #{route} --project=#{project_id} --format=json") do
      its(:exit_status) { should eq 0 }
      its(:stderr) { should eq '' }

      let(:default_internet_gateway) { "https://www.googleapis.com/compute/v1/projects/#{project_id}/global/gateways/default-internet-gateway" }
      let(:data) do
        if subject.exit_status == 0
          JSON.parse(subject.stdout)
        else
          {}
        end
      end


      describe "destRange configuration" do
        it "should match" do
          expect(data["destRange"]).to eq network_02_route_data[route_index]['destination_range']
        end
      end

      describe "tags configuration" do
        it "should match" do
          expect(data["tags"]).to eq network_02_route_data[route_index]['tags'].split(",")
        end
      end

      if network_02_route_data[route_index]['next_hop_internet']
        describe "nextHopGateway configuration" do
          it "should match" do
            expect(data["nextHopGateway"]).to eq default_internet_gateway
          end
        end
      end

      if network_02_route_data[route_index]['next_hop_ip']
        describe "nextHopIp configuration" do
          it "should match" do
            expect(data["nextHopIp"]).to eq network_02_route_data[route_index]['next_hop_ip']
          end
        end
      end
    end
  end
end
