class FormObject
  include ActiveModel::Model

  class_attribute :managed_resource

  def initialize(resource)
    instance_variable_set("@#{self.class.managed_resource}".to_sym, resource)
    prepopulate!
  end

  def submit(form_params = {}, options = {})
    self.form_params = form_params
    self.submit_options = options

    execute_before_assign_callbacks
    assign_attributes

    if valid?
      execute_before_submit_callbacks
      execute_save
      execute_after_submit_callbacks
    end

    saved?
  end

  def submitted?
    saved?
  end

  protected

  def prepopulate!
    managed_attributes.each do |attr|
      if managed_resource.respond_to?(attr)
        self.send("#{attr}=".to_sym, managed_resource.send(attr))
      end
    end
  end

  def self.manage_attributes(*vars)
    @managed_attributes ||= []
    @managed_attributes.concat vars
    attr_accessor(*vars)
  end

  def self.managed_attributes
    @managed_attributes
  end

  def managed_attributes
    self.class.managed_attributes
  end

  attr_accessor :saved, :submit_options, :form_params

  def self.manage_resource(name)
    setup_class_attributes
    add_resource(name)
  end

  # Defines hooks for before_submit, before_save, after_save, after_submit
  # Defines class attributes...
  # Defines execute_methods....
  %i[submit save].each do |action|
    %i[before after].each do |time|
      callback_method = "#{time}_#{action}"
      add_callback_method = "add_#{callback_method}_callback"
      class_attribute_name = "#{callback_method}_callbacks"

      define_singleton_method(add_callback_method) do |callback|
        self.send(class_attribute_name) << callback
      end

      private_class_method add_callback_method

      define_singleton_method(callback_method) do |callback|
        self.send(add_callback_method, callback)
      end

      define_method("execute_#{class_attribute_name}") do
        self.class.send(class_attribute_name).each do |callback|
          self.send(callback)
        end
      end
    end
  end

  def self.before_assign(callback)
    before_assign_callbacks << callback
  end

  def assign_attributes
    super(form_params)
    managed_resource.assign_attributes(form_params)
  end

  alias_method :attributes=, :assign_attributes

  def self.setup_class_attributes
    # Setup before/after submit/save attributes
    %i[submit save].each do |action|
      %i[before after].each do |time|
        class_attribute_name = "#{time}_#{action}_callbacks".to_sym

        class_attribute class_attribute_name

        self.send("#{class_attribute_name}=", []) if self.send(class_attribute_name).nil?
      end
    end

    class_attribute :before_assign_callbacks

    self.before_assign_callbacks = [] if before_assign_callbacks.nil?
  end

  def self.add_resource(name)
    # TODO if already managed resource raise error
    self.managed_resource = name
    attr_reader name
  end

  def execute_save
    ActiveRecord::Base.transaction(requires_new: true) do
      execute_before_save_callbacks
      save_managed_resource
      execute_after_save_callbacks
    end
  end

  def save_managed_resource
    self.saved = managed_resource.save(submit_options)
    saved? || raise(ActiveRecord::Rollback)
  end

  def managed_resource
    self.send(self.class.managed_resource)
  end

  def saved?
    saved
  end

  def execute_before_assign_callbacks
    self.class.before_assign_callbacks.each do |callback|
      send(callback)
    end
  end
end
