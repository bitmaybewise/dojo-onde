# encoding: UTF-8

class Local < ActiveRecord::Base
  belongs_to :dojo, dependent: :destroy
  attr_accessible :address, :city, :name, :state

  validates :name,    :presence => { message: "local é obrigatório" }
  validates :address, :presence => { message: "endereço é obrigatório" }
  validates :city,    :presence => { message: "cidade é obrigatória" }
end
