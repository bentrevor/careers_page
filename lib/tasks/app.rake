namespace :app do
  desc 'create and seed the db'
  task :setup do
    Rake::Task['db:create:all'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
  end
end
