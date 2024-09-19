class ApplicationsMailer < ApplicationMailer
      default from: 'no-reply@yourapp.com'

  def application_notification(application)
    @application = application
    @job_offer = application
    mail(to: 'admin@example.com', subject: 'Nueva Aplicación Recibida')
  end
end
