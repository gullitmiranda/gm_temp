class Analytic
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::UrlHelper
  include ApplicationHelper

  def initialize(settings={})
    # Merge Configurações padrões com as definidas pelo usuário
    @settings = {
      client_id:        Setting.for_key("rdcms.omniauth.google.key", false),
      client_secret:    Setting.for_key("rdcms.omniauth.google.secret", false),
      scope:            "https://www.googleapis.com/auth/analytics.readonly",
      redirect_uri:     "",
      approval_prompt:  "force",
      response_type:    "code",
      access_type:      "offline",
      token_method:     "post"
    }.merge settings

    @client = nil
    @oauth2 = nil
    @error = nil
    @token = nil
  end

  def client
    return @client
  end
  def oauth2
    return @oauth2
  end
  def error?
    !@error.nil?
  end
  def error_message
    @error
  end

  # OAuth2 com os dados da API do google
  def create
    @client = OAuth2::Client.new(
      @settings[:client_id],
      @settings[:client_secret],
      { :site => 'https://accounts.google.com', :authorize_url => "/o/oauth2/auth", :token_url => "/o/oauth2/token" })
  end

  # Gera url para authorização da api
  def get_authorize_url
    # caso o client ainda não ter sido criado, cria-o
    self.create if @client.nil?

    @client.auth_code.authorize_url(
      redirect_uri:     @settings[:redirect_uri],
      response_type:    @settings[:response_type],
      scope:            @settings[:scope],
      approval_prompt:  @settings[:approval_prompt],
      access_type:      @settings[:access_type]
      )
  end

  # Cria botão para autorização
  def authorize_button
    link_to(I18n.t("admin.analytics.authorize_access"), url_for(get_authorize_url), class: "btn btn-primary")
  end

  # Salva a token e retorna conexão autenticada
  # code = Código de Autorização fornecido pelo google, necessário para requisição da token
  def connect(code=nil)
    # caso o client ainda não ter sido criado, cria-o
    self.create if @client.nil?
    return false if code.nil?

    # Token para permissão de acesso nas requisições
    begin
      @oauth2 = @client.auth_code.get_token(code, redirect_uri: @settings[:redirect_uri])

      Setting.set_value_for_key(@oauth2.token, "rdcms.omniauth.google.token")
      Setting.set_value_for_key(@oauth2.refresh_token, "rdcms.omniauth.google.refresh_token")
      Setting.set_value_for_key(@oauth2.expires_at, "rdcms.omniauth.google.expires_at")
      return @oauth2
    rescue => exception
      @error = I18n.t("error.messages.rest.#{exception.code}") if defined?(exception.code)
      exception
    end
  end

  # Atualiza a token
  def refreshToken!
    oauth = @oauth2.refresh!

    # Atualizando AccessToken existente
    new_oauth oauth.token, { :expires_at => oauth.expires_at }
  end

  # Atualiza a token
  def new_oauth(token=nil, opts={})
    # caso o client ainda não ter sido criado, cria-o
    self.create if @client.nil?


    Setting.set_value_for_key(token, "rdcms.omniauth.google.token") unless token.blank?

    if defined? opts
      Setting.set_value_for_key(opts[:expires_at], "rdcms.omniauth.google.expires_at") unless opts[:expires_at].blank?
      Setting.set_value_for_key(opts[:refresh_token], "rdcms.omniauth.google.refresh_token") unless opts[:refresh_token].blank?
    end

    token ||= Setting.for_key("rdcms.omniauth.google.token", false)
    opts = {:refresh_token  => Setting.for_key("rdcms.omniauth.google.refresh_token", false),
            :expires_at     => Setting.for_key("rdcms.omniauth.google.expires_at", false).to_i}.merge opts

    @oauth2 = OAuth2::AccessToken.new @client, token, opts
  end

  # Faz a requisição
  def get_json(url, data={})
    return false if !defined?(url) or url.blank?

    data = {
      access_token: "#{@oauth2.token unless @oauth2.nil?}"
    }.merge data

    begin
      @oauth2.get url, params: data
    rescue OAuth2::Error => exception
      @error = I18n.t("error.messages.rest.#{exception.code["code"]}")
      exception
    end
  end

  # efetua o logout
  def destroy!
    Setting.set_value_for_key("", "rdcms.omniauth.google.token")
    Setting.set_value_for_key("", "rdcms.omniauth.google.refresh_token")
    Setting.set_value_for_key("", "rdcms.omniauth.google.expires_at")
    nil
  end
  def get_settings
    @settings
  end
end
