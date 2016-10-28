module ActiveScaffold::DataStructures::Association
  class ActiveMongoid < Mongoid
    def self.reflect_on_all_associations(klass)
      return [] unless klass.respond_to? :am_relations
      klass.am_relations.values
    end

    def inverse_klass
      as ? @association[:inverse_class_name].constantize : super
    end

    def allow_join?
      false
    end

    def belongs_to?
      %i(belongs_to_record belongs_to_document).include?(@association.macro)
    end

    def has_one?
      %i(has_one_record has_one_document).include?(@association.macro)
    end

    def has_many?
      %i(has_many_records has_many_documents).include?(@association.macro)
    end

    def collection?
      %i(has_many_documents has_many_records).include?(@association.macro)
    end

    def table_name
      @association.klass < ActiveRecord::Base ? @association.klass.table_name : super
    end

    protected

    def reflect_on_association(name)
      @association.klass.reflect_on_am_association(name)
    end
  end
end
