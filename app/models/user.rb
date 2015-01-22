class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable
	validates :name, presence: true
	validates :company, presence: true
	validates :area, presence: true
	# validates :address, presence: true
	validates :phone, presence: true
	validates :cnpj, presence: true
	validates :work, presence: true
	validates :profile, presence: true

	after_create :send_admin_mail

	scope :admin, -> {where(admin: true).order("updated_at DESC") }
	scope :approved, -> { where(approved: true).order("updated_at DESC") }
	scope :disapproved, -> { where(approved: false).order("updated_at DESC") }
	scope :approver, -> { where(approver: true).order("updated_at DESC") }
		
	STABLE = ["guilhermebav@gmail.com", "daniel@lado9.com.br", "renato@lado9.com.br"]


	def send_admin_mail
		# AdminMailer.new_user_waiting_for_approval.deliver
	end

	def active_for_authentication?
		super && approved?
	end

	def inactive_message
		if !approved?
			:not_approved
		else
			super # Use whatever other message
		end
	end

	def self.send_reset_password_instructions(attributes={})
		recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
		if !recoverable.approved?
			recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
		elsif recoverable.persisted?
			recoverable.send_reset_password_instructions
		end
		recoverable
	end

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |product|
				csv << product.attributes.values_at(*column_names)
			end
		end
	end

end
