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

project_id        = attribute('project_id')
subnets_names     = attribute('subnets_names')
subnets_regions   = attribute('subnets_regions')
subnets_flow_logs = attribute('subnets_flow_logs')

control "gcloud" do
  title "gcloud configuration"

  subnets_names.each_with_index do |subnet_name, subnet_index|
    describe command("gcloud compute networks subnets describe #{subnet_name} --project=#{project_id} --region=#{subnets_regions[subnet_index]} --format=json") do
      its(:exit_status) { should eq 0 }
      its(:stderr) { should eq '' }

      let(:data) do
        if subject.exit_status == 0
          JSON.parse(subject.stdout)
        else
          {}
        end
      end

      # true/false come in as strings but need to be matched as booleans
      let(:enable_flow_logs) {
        case subnets_flow_logs[subnet_index].downcase
        when 'true'
          true
        when 'false'
          false
        end
      }

      describe "enableFlowLogs configuration" do
        it "should match" do
          expect(data).to include(
            "enableFlowLogs" => enable_flow_logs
          )
        end
      end
    end
  end
end
