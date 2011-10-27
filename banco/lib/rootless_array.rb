class RootlessArray < Array
  def to_xml(options = {})
     require 'active_support/builder' unless defined?(Builder)

     options = options.dup
     options[:indent]  ||= 2
     options[:builder] ||= Builder::XmlMarkup.new(:indent => options[:indent])
     options[:root]    ||= if first.class.to_s != "Hash" && all? { |e| e.is_a?(first.class) }
       underscored = ActiveSupport::Inflector.underscore(first.class.name)
       ActiveSupport::Inflector.pluralize(underscored).tr('/', '_')
     else
       "objects"
     end

     builder = options[:builder]
     builder.instruct! unless options.delete(:skip_instruct)

     root = ActiveSupport::XmlMini.rename_key(options[:root].to_s, options)
     children = options.delete(:children) || root.singularize

     attributes = options[:skip_types] ? {} : {:type => "array"}
     return builder.tag!(root, attributes) if empty?
     
     each { |value| ActiveSupport::XmlMini.to_tag(children, value, options) }
     yield builder if block_given?
   end  
end
