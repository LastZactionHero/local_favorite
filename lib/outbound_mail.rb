require 'pry'
require 'mandrill'

class OutboundMail

  def initialize(template, email, name)
    @template = template
    @email = email
    @name = name
  end

  def send!
    api_key = APP_SETTINGS["mandrill_api_key"]
    m = Mandrill::API.new(api_key)

    rendered = m.templates.render(@template,
      [],
      [{name: 'first_name',
        :content => @name.strip
      }]
    )

    message = {
     subject: "Build a local audience with LocalFavorite",
     to: [
       {
         email: @email,
         name: @name
       }
     ],
     html: rendered["html"],
     from_email: "zach@localfavorite.me",
     from_name: "LocalFavorite"
    }
    sending = m.messages.send message
  end

end
