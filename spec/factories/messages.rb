FactoryGirl.define do

  factory :message do
    body  "test"
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.jpg'))
    created_at { Faker::Time.between(2.days.ago, Time.now, :all)}
  end

end
