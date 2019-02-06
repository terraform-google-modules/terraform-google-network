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

project_id               = attribute('project_id')
subnets_names            = attribute('subnets_names')
subnets_regions          = attribute('subnets_regions')
subnets_secondary_ranges = attribute('subnets_secondary_ranges')

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

      # The subnets_secondary_ranges array does not map 1-for-1 with the
      # subnets_names array because not all subnets have a secondary range (so
      # you can't just cross-reference the elements). Instead we need to match
      # on rangeName/range_name and compare the values. This test will fail if
      # subnets_secondary_ranges.find doesn't locate a match because of the
      # expectation that follows it, so the test should still be accurate.
      it "should match secondaryIpRanges configuration" do
        if data["secondaryIpRanges"]
          data["secondaryIpRanges"].each do |item|
            found_subnet_range = subnets_secondary_ranges.find {|element| element["range_name"] == item["rangeName"]}
            expect(item).to include(
              "rangeName"   => found_subnet_range["range_name"],
              'ipCidrRange' => found_subnet_range['ip_cidr_range']
            )
          end
        end
      end
    end
  end
end
