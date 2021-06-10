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

project_id   = attribute('project_id')
host_project_id  = attribute('host_project_id')
name  = attribute('name')
subnet_name  = attribute('subnet_name')
region  = attribute('region')
machine_type  = attribute('machine_type')
min_instances  = attribute('min_instances')
max_instances  = attribute('max_instances')

control "gcloud" do
  title "gcloud configuration"

  describe command("gcloud beta compute networks my-serverless-network connectors describe #{name} --region #{region} --project #{project_id} --format json") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    it "should exist" do
      expect(data).to include(
        "machineType" => "e2-standard-4"
      )
    end
  end
end
