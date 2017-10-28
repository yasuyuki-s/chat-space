FactoryGirl.define do

  factory :message do
    body  Faker::Twitter.status[:text]
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.jpg'))
    created_at { Faker::Time.between(2.days.ago, Time.now, :all)}
    association :user, factory: :user
    association :group, factory: :group
  end

end
