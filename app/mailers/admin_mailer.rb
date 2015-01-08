class AdminMailer < ActionMailer::Base
  default to: Proc.new { User.admin.pluck(:email) },
		  from: "support@heinzimagens.com.br"

	def new_user_waiting_for_approval
		mail(subject: 'Novos usuários aguardando aguardando aprovação!')
	end

	def user_approved(user)
		@user = user
		mail(to: @user.email, subject: 'Heinz Catálogo Online - Cadastro Aprovado.')
	end


end
