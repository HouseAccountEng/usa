namespace :db do
  namespace :usa do
    desc 'Write every state, county, city and ZIP, including the ones a release has added'
    task seed: :environment do
      USA.seed
    end
  end
end
