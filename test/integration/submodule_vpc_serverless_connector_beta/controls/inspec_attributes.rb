# Copyright 2021 Google LLC
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
name  = attribute('name')


control "inspec_attributes" do
  title "Terraform Outputs"
  desc "Terraform Outputs"


  describe attribute("output_connector_ids") do
    it { should eq ["projects/#{project_id}/locations/us-central1/connectors/#{name}"] }
  end
end
