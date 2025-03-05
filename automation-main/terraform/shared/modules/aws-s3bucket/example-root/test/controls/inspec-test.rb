describe aws_s3_bucket('test-bucket1') do
  it { should exist }
  it { should_not be_public }
  its('bucket_acl.count') { should eq 1 }
  its('bucket_policy') { should_not be_empty }
  it { should_not have_access_logging_enabled }
  it { should_not have_default_encryption_enabled }
  it { should_not have_versioning_enabled }
end
