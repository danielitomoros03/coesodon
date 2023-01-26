class Area < ApplicationRecord
  # SCHEMA:
  # t.string "name", null: false
  # t.bigint "school_id", null: false
  # t.bigint "parent_area_id"
  
  # ASSOCITATIONS:
  belongs_to :school
  belongs_to :parent_area, optional: true, class_name: 'Area', primary_key: :parent_area_id
  has_many :admins, as: :env_authorizable 

  has_many :subareas, class_name: 'Area', foreign_key: :parent_area_id

  has_many :subjects
  # accepts_nested_attributes_for :subjects

  # VALIDATIONS:
  validates :name, presence: true
  validates :school_id, presence: true

  def description
    "#{self.id}: #{self.name}"
  end

  def total_subjects
    subjects.count
  end

  def total_subareas
    subareas.count
  end

  rails_admin do
    navigation_label 'Gestión Académica'
    navigation_icon 'fa-regular fa-brain'

    list do
      fields :name, :parent_area_id
      field :total_subjects do
        label 'Total Asignaturas'
      end

      field :total_subareas do
        label 'Total Subareas'
      end
    end
    show do
      fields :name, :parent_area_id, :subjects, :subareas
    end 

    edit do
      fields :name, :parent_area_id, :subjects, :subareas
    end 

    export do
      fields :name
    end

    import do
      fields :name, :school_id 
    end

  end

  after_initialize do
    if new_record?
      self.school_id ||= School.first.id
    end
  end

end
