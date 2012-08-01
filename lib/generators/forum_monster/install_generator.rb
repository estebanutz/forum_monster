require 'rails/generators'
require 'rails/generators/migration'

class ForumMonster::InstallGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  
  desc "Installs the ForumMonster Controllers, Models, Views, and Migrations."
  
  argument :user_model, :type => :string, :required => false, :default => "User", :desc => "Your user model name."
  
  attr_reader :singular_camel_case_name, :plural_camel_case_name, :singular_lower_case_name, :plural_lower_case_name
  
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end
    
  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_controllers
    template "controllers/fm_categories_controller.rb", "app/controllers/fm_categories_controller.rb"
    template "controllers/fm_forums_controller.rb", "app/controllers/fm_forums_controller.rb"
    template "controllers/fm_topics_controller.rb", "app/controllers/fm_topics_controller.rb"
    template "controllers/fm_posts_controller.rb", "app/controllers/fm_posts_controller.rb"
  end

  def create_models
    @singular_camel_case_name = user_model.singularize.camelize
    @plural_camel_case_name = user_model.pluralize.camelize
    @singular_lower_case_name = user_model.singularize.underscore
    @plural_lower_case_name = user_model.pluralize.underscore
  	
  	template "models/fm_category.rb", "app/models/fm_category.rb"
  	template "models/fm_forum.rb", "app/models/fm_forum.rb"
    template "models/fm_topic.rb", "app/models/fm_topic.rb"
    template "models/fm_post.rb", "app/models/fm_post.rb"
  end

  def create_views
    directory "views/fm_categories", "app/views/fm_categories"
    directory "views/fm_forums", "app/views/fm_forums"
    directory "views/fm_topics", "app/views/fm_topics"
    directory "views/fm_posts", "app/views/fm_posts"
    template  "public/stylesheets/forum-monster.css", "public/stylesheets/forum-monster.css"
    template  "public/images/ruby.png", "public/images/ruby.png"
  end

  def create_migrations
    migration_template 'migrations/fm_categories.rb', 'db/migrate/fm_create_categories_table.rb'
    migration_template 'migrations/fm_forums.rb', 'db/migrate/fm_create_forums_table.rb'
    migration_template 'migrations/fm_topics.rb', 'db/migrate/fm_create_topics_table.rb'
    migration_template 'migrations/fm_posts.rb', 'db/migrate/fm_create_posts_table.rb'
    migration_template 'migrations/fm_user.rb', "db/migrate/fm_update_#{plural_lower_case_name}_table.rb"
  end
  
  def create_routes
    route "resources :fm_categories, :except => [:index, :show]
            resources :fm_forums, :except => :index do
            resources :fm_topics, :shallow => true, :except => :index do
              resources :fm_posts, :shallow => true, :except => [:index, :show]
            end
            root :to => 'fm_categories#index', :via => :get
          end"
  end
  
  def self.next_migration_number(path)
    unless @prev_migration_nr
      @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
    else
      @prev_migration_nr += 1
    end
    @prev_migration_nr.to_s
  end
end