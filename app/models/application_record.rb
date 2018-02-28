# require 'elasticsearch/model'

class ApplicationRecord < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  self.abstract_class = true
end
