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

project_id             = attribute('project_id')
network_name           = attribute('network_name')
subnets_names          = attribute('subnets_names')
subnets_ips            = attribute('subnets_ips')
subnets_regions        = attribute('subnets_regions')
subnets_private_access = attribute('subnets_private_access')

control "gcp" do
  title "Google Cloud configuration"

  describe google_compute_network(
    project: project_id,
    name: network_name
  ) do
    it { should exist }
  end

  subnets_names.each_with_index do |subnet_name, subnet_index|
    describe google_compute_subnetwork(
      project: project_id,
      name: subnet_name,
      region: subnets_regions[subnet_index]
    ) do
      # true/false come in as strings but need to be matched as booleans
      let(:private_ip_google_access) {
        case subnets_private_access[subnet_index].downcase
        when 'true'
          true
        when 'false'
          false
        end
      }

      # Tests
      it { should exist }
      its('ip_cidr_range') { should eq subnets_ips[subnet_index] }
      its('private_ip_google_access') { should be private_ip_google_access }
    end
  end
end
