class Seller < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products
  has_many :buyers
  has_many :events
  has_many :orders, through: :buyers
  has_many :billings, through: :buyers
  enum bank: [:'Seleccione Banco',
              :'BANCO DE CHILE - EDWARDS',
              :'BANCO_BICE',
              :'BANCO_CONSORCIO',
              :'BANCO_DEL ESTADO DE CHILE',
              :'BANCO DO BRASIL S.A.',
              :'BANCO FALABELLA',
              :'BANCO INTERNACIONAL',
              :'BANCO PARIS',
              :'BANCO RIPLEY',
              :'BANCO SANTANDER',
              :'BANCO SECURITY',
              :'BBVA (BCO BILBAO VIZCAYA ARG)',
              :'BCI (BCO DE CREDITO E INV)',
              :'COOPEUCH',
              :'HSBC BANK',
              :'ITAU CHILE',
              :'ITAU-CORPBANCA',
              :'SCOTIABANK'
              ]

  enum accounttype: [:'Seleccione tipo de cuenta',
                     :'Cuenta Corriente',
                     :'Cuenta Vista',
                     :'Cuenta de ahorra'
                    ]

  enum plan_type: [:'Plan Gratis', :'Plan Pagado 1']                  

end
