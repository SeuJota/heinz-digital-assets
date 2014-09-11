class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable
	validates :name, presence: true
	validates :company, presence: true
	validates :area, presence: true
	validates :address, presence: true
	validates :phone, presence: true

	scope :admin, -> {where(admin: true).order("updated_at DESC") }
	scope :approved, -> { where(approved: true).order("updated_at DESC") }
	scope :disapproved, -> { where(approved: false).order("updated_at DESC") }

	STABLE = ["guilhermebav@gmail.com", "daniel@lado9.com.br", "renato@lado9.com.br"]


	def self.send_reset_password_instructions(attributes={})
		recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
		if !recoverable.approved?
			recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
		elsif recoverable.persisted?
			recoverable.send_reset_password_instructions
		end
		recoverable
	end

end
